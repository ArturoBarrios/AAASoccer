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
import { print } from "graphql";
import EventRating from "./EventRating.js";
import { getDistanceFromLatLonInKm } from './EventFunctions.js';



const resolvers = {
    Mutation: {
        deleteUser: async (parent, args, context, info) => {
            var user = await User.findById(args._id);
            

        },
        createEventRating: async (parent, args, context, info) => {
            console.log("createEventRating");
            
            var event = await Event.findById(args.input.eventId);
            // console.log("event: ", event);
            // var fieldLocation 
            
            const eventRating = new EventRating({
                event: args.input.eventId,
                user: args.input.userId,
                fieldLocation: args.input.fieldLocationId,
                eventRating: args.input.eventRating,
                hostRating: args.input.hostRating,
                fieldLocationRating: args.input.fieldLocationRating,                
            });
            
            await eventRating.save();
            console.log("eventRating: ", eventRating);

            event.eventRatings.push(eventRating._id);

            await event.save();

            return {
                code: "200",
                success: true,
                message: "User email was successfully updated",
                eventRating: eventRating
            
            };


        },

        updatePrice: async (parent, args, context, info) => {
            console.log("updatePrice");

            //update
            const price = await Price.findById(args.pricesId);
            price.amount = args.amount;
            await price.save();

            console.log("updatedPrice: ", price);

            return {
                code: "200",
                success: true,
                message: "User email was successfully updated",
                price: price
            };

        },

        createGame: async (parent, args, context, info) => {
            console.log("createGame: ");

            console.log("args.input.event.userParticipants.userId: ", args.input.event.userParticipants[0].userId);
            //server validation
            if(args.input.event.fieldLocations[0].location.latitude != 0  
               && args.input.event.fieldLocations[0].location.longitude != 0) {
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
                       fieldAmenities: args.input.event.fieldLocations[0].fieldAmenities,
                       location: location._id,
                       fieldLocationRating: -1,
                   });
                   await fieldLocations.save();
                   console.log("fieldLocations: ", fieldLocations._id);
       
                   console.log("hostAmenities: ", args.input.event.hostAmenities);
       
                   const createdEvent = new Event({
                       name: args.input.event.name,
                       type: args.input.event.type,
                       archived: args.input.event.archived,
                       hostAmenities: args.input.event.hostAmenities,
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
                   res.populate([
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
                               },
                               {
                                   path: 'payments',
                                   populate: {
                                       path: 'user'
                                   }
                               },
                           ]
                       }
                   ]);
                   
                   await res.populate('event');
       
       
                   console.log("createdGame res: ", res);
       
                   return {
                       code: "200",
                       success: true,
                       message: "User email was successfully updated",
                       game: res
                   };

               }
               else{
                return {
                    code: "500",
                    success: false,
                    message: "error creating game",
                    game: null
                
                };
               }
        },
        addUserToEvent: async (parent, args, context, info) => {
            console.log("addUserToEvent");

            //update
            const user = await User.findById(args.userId);
            const userEventParticipant = new EventUserParticipant({
                user: user._id,
                roles: args.roles,
            });
            const event = await Event.findById(args.eventId);
            userEventParticipant.event = event._id;
            await userEventParticipant.save();
            await event.userParticipants.push(userEventParticipant._id);
            await event.save();

            await user.eventUserParticipants.push(userEventParticipant._id);
            await user.save();

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
        updateUserAccount: async (parent, args, context, info) => {
            console.log("updateUser");

            //update
            // const user = await User.findById(args._id);
            // user.onboarded = args.onboarded;
            // await user.save();

            // // await user.populate('user');
            // await user.populate('location');


            // console.log("updatedUser: ", user);

            return {
                code: "200",
                success: true,
                message: "User email was successfully updated",
                // user: user
            };
        },
        updateUsertermsAndPrivacy: async (parent, args, context, info) => {
            console.log("updateUsertermsAndPrivacy");
            console.log("args.hasAcceptedTermsAndConditions: ", args.hasAcceptedTermsAndConditions);
            console.log("args.hasAcceptedPrivacyPolicy: ", args.hasAcceptedPrivacyPolicy);
            //update
            const user = await User.findById(args._id);
            // if(args.hasAcceptedTermsAndConditions != "null"){
            //     user.hasAcceptedTermsAndConditions = args.hasAcceptedTermsAndConditions;
            // }
            // else if(args.hasAcceptedPrivacyPolicy != "null"){
            //     user.hasAcceptedPrivacyPolicy = args.hasAcceptedPrivacyPolicy;
            // }
            await user.save();            


            console.log("updatedUser: ", user);

            return {
                code: "200",
                success: true,
                message: "User email was successfully updated",
                user: user
            };
        },
        deleteEventUserParticipant: async (parent, args, context, info) => {
            console.log("deleteEventUserParticipant");

            //delete
            const eventUserParticipant = await EventUserParticipant.findById(args._id);
            await eventUserParticipant.deleteOne();






            return {
                code: "200",
                success: true,
                message: "User email was successfully updated",
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

            await user.stripeCustomers.push(stripeCustomer._id);
            await user.save();

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
            console.log("args.input.userId: ", args.input.userId);
            console.log("args.input.eventId: ", args.input.eventId);
            console.log("args.input.amount: ", args.input.amount);
            console.log("args.input.charge: ", args.input.charge);
            console.log("args.input.paidAt: ", args.input.paidAt);

            const user = await User.findById(args.input.userId);
            const event = await Event.findById(args.input.eventId);

            console.log("eventtt: ", event);
            const payment = new Payment({
                amount: args.input.amount,
                charge: args.input.charge,
                paidAt: args.input.paidAt,
                user: user._id,
                event: event._id,
                isPlayerPayment: true,
                isTeamPayment: false,
            });

            console.log("payment created");
            await payment.save();
            console.log("payment saved");

            event.payments.push(payment._id);
            console.log("payment pushed to event");
            await event.save();

            console.log("createdPayment: ", payment);

            return {
                code: "200",
                success: true,
                message: "User email was successfully updated",
                payment: payment
            };
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
                gender: args.input.user.gender,
                hostRating: -1,

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
                                        },
                                        {
                                            path: 'payments',
                                            populate: {
                                                path: 'user'
                                            }
                                        },
                                        {
                                            path: 'eventRatings',
                                            populate: {
                                                path: 'user'
                                            }
                                        }

                                    ]

                                }


                            ]
                    },
                ]
                );
            

            const cutoffTime = parseInt(args.startTime);
            console.log("cutoffTime: ", cutoffTime);
            user.eventUserParticipants = user.eventUserParticipants.reduce((filteredEvents, eventUserParticipant) => {
                const event = eventUserParticipant['event'];
                const eventStartTime = parseInt(event['startTime']);
                console.log("eventStartTime: ", eventStartTime);
            
                // Filter events based on the cutoffTime condition
                if (cutoffTime <= eventStartTime) {                    
                    filteredEvents.push(eventUserParticipant);
                }
            
                return filteredEvents;
            }, []).sort((a, b) => {
                // Assuming 'startTime' is a string of milliseconds since the epoch
                const startTimeA = parseInt(a.event['startTime']);
                const startTimeB = parseInt(b.event['startTime']);
                return startTimeA - startTimeB; // Sorting in ascending order
            });
            


            console.log("user.eventUserParticipants: ", user.eventUserParticipants);




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
            console.log("startTime: ", args.startTime);
            
            var events = await Event.find({
                type: args.type,
                // startTime: { $gte: args.startTime }
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
                },
                {
                    path: 'payments',
                    populate: {
                        path: 'user',                        
                    }
                },
                
            ]).sort({ startTime: 1 });
            
            const userLatitude = args.latitude;
            const userLongitude = args.longitude;
            const radius = args.radius;
            
                        
            console.log("userLatitude: ", userLatitude);
            console.log("userLongitude: ", userLongitude);
            console.log("radius: ", radius);
            
            const cutoffTime = parseInt(args.startTime);
            console.log("cutoffTime: ", cutoffTime);
            var resEvents = [];
            for (var event of events) {
                const eventStartTime = parseInt(event['startTime']);
                console.log("eventStartTime: ", eventStartTime);
            
                if (cutoffTime <= eventStartTime) {
                    const eventLatitude = event['fieldLocations'][0]['location']['latitude'];
                    const eventLongitude = event['fieldLocations'][0]['location']['longitude'];
                    console.log("eventLatitude: ", eventLatitude);
                    console.log("eventLongitude: ", eventLongitude);
                    const distance = getDistanceFromLatLonInKm(userLatitude, userLongitude, eventLatitude, eventLongitude);
                    console.log("distance: ", distance);
                    if (distance <= radius) {
                        resEvents.push(event);
                    }                    
                }
            }
            
            
            console.log("resEvents: ", resEvents);

            return {
                code: 200,
                success: true,
                message: "User email was successfully updated",
                events: resEvents
            };
        },
       
        getArchivedEvents: async (parent, args, context, info) => {            
            console.log("getArchivedEvents");
            console.log("userId: ", args.userId);           
            console.log("startTime: ", args.startTime);

            const user = await User.findById(args.userId)
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
                                        },
                                        {
                                            path: 'payments',
                                            populate: {
                                                path: 'user'
                                            }
                                        },
                                        {
                                            path: 'eventRatings',
                                            populate: {
                                                path: 'user'
                                            }
                                        }

                                    ]
                                }
                                


                            ]
                    },
                ]
                );


            const cutoffTime = parseInt(args.startTime);
            // console.log("cutoffTime: ", cutoffTime);
            // console.log("user: ", user);
            const userEvents = user.eventUserParticipants;
            // console.log("userEvents: ", userEvents);
            
            const archivedEvents = userEvents
    .filter(eventUserParticipant =>  {
        const event = eventUserParticipant['event'];
        const eventStartTime = parseInt(event['startTime']);
        console.log("eventStartTime: ", eventStartTime);

        return cutoffTime > eventStartTime;
    })
    .map(eventUserParticipant => eventUserParticipant['event']);         


            console.log("archivedEvents: ", archivedEvents);


            return {
                code: 200,
                success: true,
                message: "User email was successfully updated",
                archivedEvents: archivedEvents
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
                        path: 'stripeCustomers',
                        
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
                                    },
                                    {
                                        path: 'payments',
                                        populate: {
                                            path: 'user'
                                        }
                                    },                                    
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
                                            populate: [
                                                {
                                                    path: 'user'
                                                }
                                        ], 

                                        },
                                        {
                                            path: 'price'
                                        },
                                        {
                                            path: 'payments',
                                            populate: {
                                                path: 'user'
                                            }
                                        },

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
