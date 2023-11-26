import Game from "./Game.js";
import Event from "./Event.js";
import Price from "./Price.js";
import JoinConditions from "./JoinConditions.js";
import EventUserParticipant from "./EventUserParticipant.js";
import FieldLocation from "./FieldLocation.js";
import Location from "./Location.js";
import Player from "./Player.js";
import User from "./User.js";
import StripeCustomer from "./StripeCustomer.js";
import Payment from "./Payment.js";

const resolvers = {
    Mutation: {
        createGame: async (parent, args, context, info) => {
            console.log("createGame: ");

            console.log("args.input.event.userParticipants.userId: ", args.input.event.userParticipants[0].userId);
            //get user
            const user = await User.findById(args.input.event.userParticipants[0].userId);
            console.log("user retrieved from userId: " + user.toString());

            const createdPrice = new Price({
                amount: args.input.event.price.amount,
            });
            await createdPrice.save();
            console.log("createdPrice: ", createdPrice._id);

            const joinConditions = new JoinConditions({
                withRequest: args.input.event.joinConditions.withRequest,
                withPayment: args.input.event.joinConditions.withPayment,
            });
            await joinConditions.save();
            console.log("joinConditions: ", joinConditions._id);

            const eventUserParticipants = new EventUserParticipant({
                user: user._id,
                roles: args.input.event.userParticipants[0].roles,
            });
            await eventUserParticipants.save();
            console.log("eventUserParticipants: ", eventUserParticipants._id);

            await user.eventUserParticipants.push(eventUserParticipants._id);
            await user.save();

            console.log("args.input.event.fieldLocations.location: ", args.input.event.fieldLocations[0].location);
            const location = new Location({
                name: args.input.event.fieldLocations[0].location.name,
                address: args.input.event.fieldLocations[0].location.address,
                latitude: args.input.event.fieldLocations[0].location.latitude,
                longitude: args.input.event.fieldLocations[0].location.longitude,
            });
            await location.save();
            console.log("location: ", location._id);

            const fieldLocations = new FieldLocation({
                isMainField: args.input.event.fieldLocations[0].isMainField,
                location: location._id,
            });
            await fieldLocations.save();
            console.log("fieldLocations: ", fieldLocations._id);



            const createdEvent = new Event({
                name: args.input.event.name,
                type: args.input.event.type,
                archived: args.input.event.archived,
                amenities: args.input.event.amenities,
                isMainEvent: args.input.event.isMainEvent,
                startTime: args.input.event.startTime,
                endTime: args.input.event.endTime,
                createdAt: args.input.event.createdAt,
                capacity: args.input.event.capacity,
                price: createdPrice._id,
                joinConditions: joinConditions._id,
                userParticipants: [eventUserParticipants._id],
                fieldLocations: fieldLocations._id,
            });
            await createdEvent.save();

            eventUserParticipants.event = createdEvent._id;
            await eventUserParticipants.save();

            console.log("createdEvent: ", createdEvent._id);


            const createdGame = new Game({
                pickup: args.input.pickup,
                event: createdEvent._id,
            });

            const res = await createdGame.save();
            await res.populate('event');


            console.log("createdGame res: ", res);

            return {
                code: "200",
                success: true,
                message: "User email was successfully updated",
                game: res
            };
        },
        addUserToEvent: async (parent, args, context, info) => {
            console.log("addUserToEvent");

            //update
            const user = await User.findById(args.userId);
            const userParticipant = new EventUserParticipant({
                user: user._id,
                roles: args.roles,
            });
            await userParticipant.save();
            const event = await Event.findById(args.eventId);
            await event.userParticipants.push(userParticipant._id);
            await event.save();

            event.populate([
                {
                    path: 'fieldLocations',
                    populate: {
                        path: 'location'
                    },
                },
                {
                    path: 'joinConditions'
                },
                {
                    path: 'userParticipants',
                    populate: {
                        path: 'user'
                    }
                },
                {
                    path: 'price'
                }
            ]);
            

            return {
                code: "200",
                success: true,
                message: "User email was successfully updated",
                event: event
            };
        },
        updateUserOnboarding: async (parent, args, context, info) => {
            console.log("updateUserOnboarding");

            //update
            const user = await User.findById(args._id);
            user.onboarded = args.onboarded;
            await user.save();

            // await user.populate('user');
            await user.populate('location');


            console.log("updatedUser: ", user);

            return {
                code: "200",
                success: true,
                message: "User email was successfully updated",
                user: user
            };
        },
        createStripeCustomer: async (parent, args, context, info) => {
            console.log("createStripeCustomer");            
            
            const user = await User.findById(args.userId);

            const stripeCustomer = new StripeCustomer({
                customerId: args.customerId,
                user: user._id,            
            });
            await stripeCustomer.save();

            stripeCustomer.populate('user');
            
            
            return {
                code: "200",
                success: true,
                message: "User email was successfully updated",
                stripeCustomer: stripeCustomer
            }
            
        },

        createPayment: async (parent, args, context, info) => {
            console.log("createPayment");

            const user = await User.findById(args.input.userId);
            const event = await User.findById(args.input.eventId);

            const payment = new Payment({
                amount: args.input.amount,
                charge: args.input.charge,                
                paidAt: args.input.paidAt,
                user: user._id,
                event: event._id,
                isPlayerPayment: true,
                isTeamPayment: false,                                
            });
            await payment.save();

            console.log("createdPayment: ", payment);
        },
        createPlayer: async (parent, args, context, info) => {
            console.log("createPlayer args: ", args.input.user);

            const location = new Location({
                name: args.input.user.location.name,
                address: args.input.user.location.address,
                latitude: args.input.user.location.latitude,
                longitude: args.input.user.location.longitude,
            });
            await location.save();
            console.log("location: ", location._id);

            const createdUser = new User({
                name: args.input.user.name,
                username: args.input.user.username,
                phone: args.input.user.phone,
                email: args.input.user.email,
                birthdate: args.input.user.birthdate,
                location: location._id,

            });
            await createdUser.save();
            console.log("createdUser: ", createdUser._id);


            const createdPlayer = new Player({
                user: createdUser._id,
                location: location._id,
            });
            await createdPlayer.save();

            console.log("createdPlayer: ", createdPlayer._id);

            const res = await createdPlayer.save();

            await res.populate('user');
            await res.populate('user.location');


            console.log("createdPlayer: ", res);

            return {
                code: "200",
                success: true,
                message: "User email was successfully updated",
                player: res
            };
        },
    },
    Query: {

        allUserEventParticipants: async (parent, args, context, info) => {
            // const events = await Event.find({ type: args.type });
            console.log("allUserEventParticipants");                        
            console.log("startTime: ", args.startTime);
            console.log("_id: ", args._id);

            const user = await User.findById(args._id)
            .populate([
                {
                    path: 'eventUserParticipants',
                    populate: 
                    [
                        {
                            path: 'user'
                        },
                        {
                            path: 'event',
                            populate: [
                                {
                                    path: 'fieldLocations',
                                    populate: {
                                        path: 'location'
                                    },
                                },
                                {
                                    path: 'joinConditions'
                                },
                                {
                                    path: 'userParticipants',
                                    populate: {
                                        path: 'user'
                                    }
                                },
                                {
                                    path: 'price'
                                }
                            ]
                            
                        }


                    ]
                },
            ]
            );


            console.log("events: ", user.eventUserParticipants);





            return {
                code: 200,
                success: true,
                message: "User email was successfully updated",
                eventUserParticipants: user.eventUserParticipants
            };
        },
        allEventsInAreaOfType: async (parent, args, context, info) => {
            // const events = await Event.find({ type: args.type });
            console.log("allEventsInAreaOfType");
            console.log("type: ", args.type);
            console.log("latitude: ", args.latitude);
            console.log("longitude: ", args.longitude);
            console.log("radius: ", args.radius);
            console.log("startTime: ", args.startTime);

            const events = await Event.find({
                type: args.type,
                startTime: { $gte: args.startTime }
            }).populate([
                {
                    path: 'fieldLocations',
                    populate: {
                        path: 'location'
                    },
                },
                {
                    path: 'joinConditions'
                },
                {
                    path: 'userParticipants',
                    populate: {
                        path: 'user'
                    }
                },
                {
                    path: 'price'
                }
            ]);


            console.log("events: ", events);





            return {
                code: 200,
                success: true,
                message: "User email was successfully updated",
                events: events
            };
        },
        allGames: async (parent, args, context, info) => {
            const games = await Game.find();



            console.log("games: ", games);

            return {
                code: 200,
                success: true,
                message: "User email was successfully updated",
                games: games
            };
        },
        findUserByEmail: async (parent, args, context, info) => {
            console.log("findUserByEmail: ");
            const user = await User.findOne({ email: args.email })
                .populate([
                    {
                        path: 'location'
                    },
                    {
                        path: 'eventUserParticipants',
                        populate: [
                            {
                                path: 'user'
                            },
                            {
                                path: 'event',
                                populate: [
                                    {
                                        path: 'fieldLocations',
                                        populate: {
                                            path: 'location'
                                        },
                                    },
                                    {
                                        path: 'joinConditions'
                                    },
                                    {
                                        path: 'userParticipants',
                                        populate: {
                                            path: 'user'
                                        }
                                    },
                                    {
                                        path: 'price'
                                    }
                                ]
                            }
                        ]
                    }
                ])
                ;
            // await user.populate('location');
            console.log("user: ", user);

            return {
                code: 200,
                success: true,
                message: "User email was successfully retrieved",
                user: user
            };
        },
        findUserById: async (parent, args, context, info) => {
            const user = await User.findById(args._id)
            .populate([
                {
                    path: 'eventUserParticipants',
                    populate: 
                    [
                        {
                            path: 'user'
                        },
                        {
                            path: 'event',
                            populate: [
                                {
                                    path: 'fieldLocations',
                                    populate: {
                                        path: 'location'
                                    },
                                },
                                {
                                    path: 'joinConditions'
                                },
                                {
                                    path: 'userParticipants',
                                    populate: {
                                        path: 'user'
                                    }
                                },
                                {
                                    path: 'price'
                                }
                            ]
                            
                        }


                    ]
                },
            ]
            );

            console.log("user: ", user);

            return {
                code: 200,
                success: true,
                message: "User email was successfully retrieved",
                user: user
            };
        }
    },
};



export default resolvers;
