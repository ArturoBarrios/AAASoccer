import { ApolloServer } from '@apollo/server';
import { startStandaloneServer } from '@apollo/server/standalone';

// A schema is a collection of type definitions (hence "typeDefs")
// that together define the "shape" of queries that are executed against
// your data.
const typeDefs = `#graphql
  # Comments in GraphQL strings (such as this one) start with the hash (#) symbol.

  # This "Book" type defines the queryable fields for every book in our data source.
  type Book {
    title: String
    author: String
  }

  # The "Query" type is special: it lists all of the available queries that
  # clients can execute, along with the return type for each. In this
  # case, the "books" query returns an array of zero or more Books (defined above).
  type Query {
    books: [Book]
  }

  # enums
  enum PaymentType {
  STRIPE
  PAYPAL
  GOOGLE
  APPLE  
}

enum AmenityType {
  BATHROOMS
  WATERFOUNDATIN
  BIKESTATION
  TRAIN
  BUS
  TURF
  PINNIES
}

enum RoleType {
  COACH
  PLAYER
  REFERREE
  ORGANIZER
  VOLUNTEER
  SPONSOR
}

enum EventType {
  TRYOUT
  GAME
  LEAGUE
  TOURNAMENT
  TRAINING
}

enum MessageType {
  TEXT
  IMAGE
  VIDEO
  AUDIO
}

enum SocialMediaType {
  FACEBOOK
  INSTAGRAM
  X
  YOUTUBE
  LINKEDIN
}

enum ParkingType {
  STREET
  GARAGE
  LOT
  METERED
  FREE
  LIMITED
  PAID
}

enum SurfaceType {
  TURFPOOR
  TURFOKAY
  TURFGOOD
  TURFEXCELLENT
  GRASSPOOR
  GRASSOKAY
  GRASSGOOD
  GRASSEXCELLENT
  HARDFLOOR
  SAND
  NAILS
  QUICKSAND
}

enum FieldPlayerOccupancySize {
  SMALL
  MEDIUM
  FULLSIZE
}

enum GenderType {
  MALE
  FEMALE
}

enum ModelType {
  USER
  ORGANIZATION
  EVENT
}

enum UserAccountStatus{
  UNCOMFIRMED
  CONFIRMED
  INACTIVE
  BANNED
}

enum RequestStatus{
  PENDING
  ACCEPTED
  REJECTED
}

enum UserType{
  PLAYER
  ORGANIZER
  MANAGER
  MAINCOACH
  ASSISTANTCOACH
  REF
}

enum RequestType{
  FRIENDREQUEST
  GAMEREQUEST
  TEAMREQUEST
  TOURNAMENTREQUEST
  LEAGUEREQUEST
  TRAININGREQUEST
  TEAMEVENTREQUEST
  TEAMCHATREQUEST
  EVENTCHATREQUEST
}

# when someone rates anything, their relationship to the
# thing they are rating is stored in the rating object
# maybe define this as a number indicating how strong
# the relationship is
enum RatingCategoryType{
  TEAMMATE
  OPPONENT
  COACH
  REFEREE
  ORGANIZER
  PARTICIPANT 
}

enum EventUserParticipantAttendingOptions {
  YES
  NO
  MAYBE
}

enum RsvpStatus{
  Yes,
  No,
  Maybe
}

enum PrizeType {
  CASH
  TROPHY
  MEDAL
  OTHER
}


enum LocationType {
  TEAM
  EVENT
  ORGANIZATION
  USER
  FACILITY
}

type AppPreference {
  language: String
  user: User
}

type User  {
  isSuperUser: Boolean
  appPreference: AppPreference
  stripeCustomers: [StripeCustomer] 
  payments: [Payment]
  userType: UserType
  OSPID: String
  name: String
  phone: String
  email: String
  bio: String
  username: String
  birthdate: String
  age: Int
  teams: [Team]
  gender: GenderType
  followers: [FollowRelation]
  following: [FollowRelation] 
  # location: Location
  # player: Player
  # organizer: Organizer
  # coach: Coach
  # referee: Referee
  # status: UserAccountStatus
  # createdAt: Int
  # updatedAt: String
  # images: [Image] @relation
  # events: [Event] @relation
  # eventUserParticipants: [EventUserParticipant] @relation
  # teamUserParticipants: [TeamUserParticipant] @relation
  # groupUserParticipants: [GroupUserParticipant] @relation
  # regionUserParticipants: [RegionUserParticipant] @relation
  # requestsSent: [Request]  @relation(name: "requests_sent")
  # requestsReceived: [Request] @relation(name: "request_receivers")
  # requestsAccepted: [Request] @relation(name: "request_acceptedBy")
  # chats: [Chat] @relation(name: "user_chats")
  # sentMessages: [Message] @relation(name: "messages_sent")
  # messagesDirectedForMe: [Message] @relation(name: "messages_for")
  # onboarded: Boolean @default(value: false)  
  # mainImageKey: String
  # isProfilePrivate: Boolean @default(value: false)
  # socialMediaApps: [SocialMediaApp] @relation
  # appSubscriptions: [AppSubscription] @relation
  # coupons: [Coupon] @relation  
  # groups: [Group] @relation
  # ratings: [Rating] @relation
  # eventRatings: [EventRating] @relation
  # hasAcceptedTermsAndConditions: Boolean @default(value: false)
  # hasAcceptedPrivacyPolicy: Boolean @default(value: false)
}

type StripeCustomer {
  customerId: String
  user: User
}

type Payment   {
  # amount: String
  # event: Event
  # team: Team
  # group: Group
  # paidAt: String
  user: User
  # isPlayerPayment: Boolean
  # isTeamPayment: Boolean
  # refunded: Boolean
  # charge: String
  # paymentType: PaymentType
}

type Team   {
  name: String
  color: String
  # events: [Event] @relation
  # images: [Image] @relation
  users: [User]
  # sponsors: [Sponsor] @relation
  # teamLocations: [TeamLocation] @relation
  # userParticipants: [TeamUserParticipant] @relation
  # regions: [Region] @relation
  # status: String
  # deleted: Boolean
  # createdAt: String
  # updatedAt: String
  # request: [Request] @relation
  # chats: [Chat] @relation
  # price: Price
  # payments: [Payment] @relation
  # joinConditions: [JoinConditions] @relation
  # teamOrders: [TeamOrder] @relation
  # organization: Organization  
  # SocialMediaApps: [SocialMediaApp] @relation
  # capacity: Int
  # coupons: [Coupon] @relation
  # teamReputation: TeamReputation @relation
}

type FollowRelation {
  follower: User
  following: User 
}


`;

const books = [
    {
      title: 'The Awakening',
      author: 'Kate Chopin',
    },
    {
      title: 'City of Glass',
      author: 'Paul Auster',
    },
  ];

  // Resolvers define how to fetch the types defined in your schema.
// This resolver retrieves books from the "books" array above.
const resolvers = {
    Query: {
      books: () => books,
    },
  };

  // The ApolloServer constructor requires two parameters: your schema
// definition and your set of resolvers.
const server = new ApolloServer({
    typeDefs,
    resolvers,
  });
  
  // Passing an ApolloServer instance to the `startStandaloneServer` function:
  //  1. creates an Express app
  //  2. installs your ApolloServer instance as middleware
  //  3. prepares your app to handle incoming requests
  const { url } = await startStandaloneServer(server, {
    listen: { port: 4000 },
  });
  
  console.log(`🚀  Server ready at: ${url}`);