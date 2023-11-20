import { ApolloServer } from '@apollo/server';
import { startStandaloneServer } from '@apollo/server/standalone';
import mongoose from 'mongoose';

const MongoDB = "mongodb+srv://arturobarrios357:Ruforufo357@tsndev.xuzcz.mongodb.net/?retryWrites=true&w=majority"
import resolvers from './resolvers.js';



// A schema is a collection of type definitions (hence "typeDefs")
// that together define the "shape" of queries that are executed against
// your data.
const typeDefs = `#graphql
  interface MutationResponse {
  code: String!
  success: Boolean!
  message: String!
}

type CreateGameMutationResponse implements MutationResponse {
  code: String!
  success: Boolean!
  message: String!
  game: Game
}

type Mutation {
  createGame(input: GameInput): CreateGameMutationResponse
}




  input GameInput {
    pickup: Boolean
    eventInput: EventInput
      
    

  }

  input EventInput {        
    name: String    
}


  type Query {    
    allFieldLocations: [FieldLocation!]
    allGames(pickup: Boolean): [Game!]
    getGames: [Game!]
    allEvents(type: EventType): [Event!]
    allTrainings: [Training!]
    allTryouts: [Tryout!]
    allLeagues: [League!]
    allTournaments: [Tournament!]
    allUsers: [User!]
    allPlayers: [Player!]
    allRequests: [Request!]
    allTeams: [Team!]
    allGroups: [Group!]
    getUserByEmail(email: String): User
    getUserByPhone(phone: String): User
    getUserByUsername(username: String): User    
    allSubscriptionTypes: [SubscriptionType!]
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
  location: Location
  player: Player
  organizer: Organizer
  coach: Coach
  referee: Referee
  status: UserAccountStatus
  createdAt: Int
  updatedAt: String
  images: [Image] 
  events: [Event] 
  eventUserParticipants: [EventUserParticipant] 
  teamUserParticipants: [TeamUserParticipant] 
  groupUserParticipants: [GroupUserParticipant] 
  regionUserParticipants: [RegionUserParticipant]
  requestsSent: [Request]  
  requestsReceived: [Request]
  requestsAccepted: [Request]
  chats: [Chat] 
  sentMessages: [Message]
  messagesDirectedForMe: [Message]
  onboarded: Boolean 
  mainImageKey: String
  isProfilePrivate: Boolean 
  socialMediaApps: [SocialMediaApp]
  appSubscriptions: [AppSubscription]
  coupons: [Coupon] 
  groups: [Group] 
  ratings: [Rating]
  eventRatings: [EventRating]
  hasAcceptedTermsAndConditions: Boolean 
  hasAcceptedPrivacyPolicy: Boolean 
}
type Request {
  type: RequestType
  sender: User 
  receivers: [User]
  acceptedBy: User 
  status: RequestStatus
  requestAttempts: Int
  fromOrganizer: Boolean
  event: Event
  team: Team
  group: Group
  forRole: String
  sentAt: Int
  acceptedAt: Int
}

type StripeCustomer {
  customerId: String
  user: User
}

type FollowRelation {
  follower: User 
  following: User
}


type Player   {
  wagers: [Wager]
  competitiveLevel: String
  hasRating: String
  showRating: String
  user: User
  selfRating: Int
  sponsors: [Sponsor]
  playerReputation: [PlayerReputation]
}

type PlayerReputation {  
  ratings: [Rating] 
  player: Player
}



type EventUserParticipant {
  event: Event
  user: User
  roles: String
  organization: Organization
  isAttending: EventUserParticipantAttendingOptions
}

type TeamUserParticipant {
  team: Team
  user: User
  roles: String
  isAttending: EventUserParticipantAttendingOptions
}

type GroupUserParticipant {
  group: Group
  user: User
  roles: String
  isAttending: EventUserParticipantAttendingOptions
}

type Game {
  hometeam: Team
  awayteam: Team
  teamA: String
  teamB: String
  round: Int
  gameNumber: Int
  homegoals: Int
  awaygoals: Int
  pickup: Boolean
  event: Event  
}

type JoinConditions {
  withRequest: Boolean
  withPayment: Boolean
  forTeam: Boolean
  forEvent: Boolean
  event: Event
  team: Team
  group: Group
}

type Event   {
  name: String
  joinConditions: [JoinConditions]
  isMainEvent: Boolean
  amenities: String
  userParticipants: [EventUserParticipant]
  price: Price 
  requests: [Request]
  coorganizations: [Organization]
  sponsors: [Sponsor] 
  images: [Image] 
  fieldLocations: [FieldLocation]
  type: EventType
  payments: [Payment] 
  chats: [Chat] 
  teams: [Team] 
  games: [Game] 
  users: [User] 
  tryouts: [Tryout] 
  leagues: [League] 
  tournaments: [Tournament] 
  trainings: [Training] 
  wager: [Wager] 
  rsvp: [Rsvp] 
  archived: Boolean
  deleted: Boolean 
  startTime: String
  endTime: String
  createdAt: String
  capacity: Int
  teamCapacity: Int
  mainImageKey: String
  SocialMediaApps: [SocialMediaApp] 
  prizes: [Prize] 
  coupons: [Coupon]
  eventRatings: [EventRating]
  slot: Slot
  group: Group
}

type Rsvp {
  id: ID!
  user: User! 
  event: Event!
  status: RsvpStatus
  createdAt: String
}


type Group   {
  name: String  
  description: String
  events: [Event] 
  images: [Image] 
  users: [User] 
  sponsors: [Sponsor]
  groupLocations: [GroupLocation]
  userParticipants: [GroupUserParticipant]
  deleted: Boolean
  createdAt: String
  updatedAt: String
  request: [Request]
  chats: [Chat] 
  price: Price
  payments: [Payment]
  joinConditions: [JoinConditions]
  organization: Organization  
  SocialMediaApps: [SocialMediaApp]
  coupons: [Coupon] 
  groupReputation: GroupReputation
  status: String
}

type Team   {
  name: String
  color: String
  events: [Event]
  images: [Image] 
  users: [User] 
  sponsors: [Sponsor]
  teamLocations: [TeamLocation]
  userParticipants: [TeamUserParticipant]
  regions: [Region] 
  status: String
  deleted: Boolean
  createdAt: String
  updatedAt: String
  request: [Request]
  chats: [Chat] 
  price: Price
  payments: [Payment]
  joinConditions: [JoinConditions]
  teamOrders: [TeamOrder] 
  organization: Organization  
  SocialMediaApps: [SocialMediaApp]
  capacity: Int
  coupons: [Coupon] 
  teamReputation: TeamReputation
}

type TeamReputation {
  ratings: [Rating] 
  team: Team
}

type GroupReputation {
  ratings: [Rating] 
  group: Group
}

type Coach   {
  user: User  
  coachReputation: CoachReputation
}

type CoachReputation {
  ratings: [Rating] 
  coach: Coach
}

type Referee   {
  user: User
  refereeReputation: [RefereeReputation]
}

type RefereeReputation {
  ratings: [Rating] 
  referee: Referee
}

# a payment is attached to event
# use payment object to create payment screen details for event
type Payment   {
  amount: String
  event: Event
  team: Team
  group: Group
  paidAt: String
  user: User
  isPlayerPayment: Boolean
  isTeamPayment: Boolean
  refunded: Boolean
  charge: String
  paymentType: PaymentType
}

# orgs can have many suborgs
# allow org to behave as Sponsor
type Organization   {
  name: String
  images: [Image] 
  events: [Event] 
  teams: [Team] 
  groups: [Group]  
  sponsors: [Sponsor] 
  description: String
  minAge: Int
  maxAge: Int
  inviteOnly: Boolean
  private: Boolean #it won't show up in public search
  isMainOrg: Boolean
  userParticipants: [EventUserParticipant]
  organizationLocation: [OrganizationLocation]
  facilities: [Facility] 
  organizationReputation: [OrganizationReputation]  
}

type OrganizationReputation {
  ratings: [Rating] 
  organization: Organization
}


# sponsor is an org
type Sponsor {
  id: ID!
  name: String
  images: [Image] 
  description: String
  url: String    
  event: [Event] 
  sponsoredOrgs: [Organization]
  sponsoredPlayers: [Player] 
  sponsoredTeams: [Team] 
  sponsoredGroups: [Group]
}

type Wager   {
  name: String
  amount: String
  players: [Player]  
  private: Boolean
  events: [Event] 
}

type Tryout   {  
  event: Event  
}

type League   {
  tournaments: [Tournament]  
  events: [Event] 
  numberOfTeams: Int  
  season: Season
  region: Region
}

type Season {
  leagues: [League]
  tournaments: [Tournament] 
  startDate: String
  endDate: String
}

type TeamOrder {
  team: Team
  points: Int
  group: TournamentGroup
  order: Int

}

type TeamGroup {
  numberOfPoints: Int

}

type TournamentGroup {
  groupNumber: Int
  groupStage: GroupStage
  teamOrders: [TeamOrder] 
}

type GroupStage {
  groups: [TournamentGroup]
  numberOfTeams: Int
  numberOfRoundsPerTeam: Int
  tournament: Tournament
  league: League
  type: EventType
}

type EventOrder {
  event: Event
  order: Int
  tournamentStage: TournamentStage
}

type TournamentStage {
  numberOfTeams: Int
  numberOfRoundsPerTeam: Int
  tournament: Tournament
  eventOrders: [EventOrder]

}

type Tournament   {
  groupPlay: Boolean  
  events: [Event] 
  numberOfTeams: Int
  groupStage: GroupStage
  tournamentStage: TournamentStage
  region: Region
  season: Season
  leagues: [League]  
}

type Training   {
  event: Event  
}

type Image   {
  isMainImage: Boolean
  public: Boolean
  url: String
  key: String
  user: User
  event: Event
  chat: Chat
  team: Team
  group: Group
  location: Location
  organization: Organization  
  sponsor: Sponsor
  s3bucket: String
}

type GifContent   {
  gifUrl: String
}

type TextContent   {
  content: String
}

type Message {
  chatObject: Chat #belongs to chat
  textObject: TextContent
  gifObject: GifContent
  imageObject: Image
  sender: User 
  messageType: MessageType
  for: [User] 
}

type Chat  {
  name: String
  messages: [Message] 
  users: [User] 
  event: Event
  team: Team
  group: Group
  archived: Boolean
  isPrivate: Boolean
  IsMainChat: Boolean
  mainImageKey: String
  images: [Image] 
}




type Location   {
  name: String
  secondaryName: String
  address: String  
  latitude: Float!
  longitude: Float!    
  locationType: LocationType
}

type UserLocation   {
  user: User
  location: Location
}

type GroupLocation   {  
  location: Location
  group: Group    
}

type TeamLocation   {
  isMainField: Boolean 
  location: Location
  team: Team    
}

type OrganizationLocation{
  location: Location
  organization: Organization
}

type StoreLocation{
  location: Location
  store: Store
}
     

type FieldLocation  {  
  isMainField: Boolean 
  location: Location
  facility: Facility
  events: [Event] 
  fieldSize: FieldPlayerOccupancySize  
  surface: SurfaceType
  private: Boolean
  amenities: [Amenity]
  socialMediaApps: [SocialMediaApp]
  organization: Organization
  fieldLocationReputation: FieldLocationReputation
  schedule: Schedule
  parkingOptions: [ParkingOption]
  field: Field
  eventRatings: [EventRating] 


}

type ParkingOption {
  fieldLocation: FieldLocation
  parkingTypes: [ParkingType]
  info: String
}





type FieldLocationReputation {
  ratings: [Rating]
  fieldLocation: FieldLocation
  verified: Boolean
}

type Rating   {
  rating: Int
  feedback: String
  user: User
  organizationReputations: [OrganizationReputation] 
  organizerReputations: [OrganizerReputation] 
  teamReputation: [TeamReputation] 
  fieldLocationReputations: [FieldLocationReputation] 
  playerReputations: [PlayerReputation] 
  coachReputations: [CoachReputation] 
  refereeReputations: [RefereeReputation] 
  ratingCategory: [RatingCategory]  
  groupReputation: [GroupReputation]
}

type EventRating   {
  event: Event
  user: User
  fieldLocation: FieldLocation
  eventRating: Int
  hostRating: Int
  fieldLocationRating: Int 
  eventFeedback: String
  hostFeedback: String
  fieldLocationFeedback: String
}

type RatingCategory {
  rating: [Rating] 
  ratingCategoryType: RatingCategoryType  
}


type Price   {
  amount: String
  event: Event 
  team: Team
  group: Group
  location: Location
  teamAmount: String
  time: Int #in minutes
  subscriptionType: SubscriptionType
}

type SocialMediaApp   {
  type: SocialMediaType
  url: String
  user: User
  team: Team
  event: Event
  group: Group
  fieldLocation: FieldLocation
}

type Item {
  name: String
  description: String #size 5
  price: String
  quantity: Int
}

type Region {
  name: String
  location: Location
  Leagues: [League] 
  tournaments: [Tournament]
  teams: [Team] 
  userParticipants: [RegionUserParticipant] 
}

type RegionUserParticipant {
  region: Region
  user: User
  roles: String
}

type Prize {
  amount: String
  type: PrizeType  
  description: String
  event: Event
}

type Amenity {  
  type: AmenityType    
  fieldLocations: [FieldLocation]
}

type Organizer {
  organizerReputation: OrganizerReputation
  slots: [Slot]
  schedules: [Schedule]
}



type OrganizerReputation {
  ratings: [Rating]
  canOrganizeGame: Boolean
  canOrganizeLeague: Boolean
  canOrganizeTournament: Boolean
  canOrganizeTryout: Boolean
  canOrganizeTraining: Boolean
  canOrganizeTeam: Boolean
  gameReputationScore: Int
  leagueReputationScore: Int
  tournamentReputationScore: Int
  tryoutReputationScore: Int
  trainingReputationScore: Int
  teamReputationScore: Int
  
}

type SubscriptionType {
  name: String
  description: String
  price: Price
  lengths: String
  appSubscriptions: [AppSubscription]
}

type AppSubscription  {
  subscriptionType: SubscriptionType
  user: User
  startDate: String
  endDate: String
  length: Int
}

type Schedule {
  slots: [Slot]
  organizers: [Organizer]
  fieldLocation: [FieldLocation] #maybe only FieldLocation or locations????
}


type Slot {
  startTime: String
  endTime: String
  events: [Event]
  slotCreators: [Organizer]
  field: [Field] 
  schedule: Schedule 
}

type Field {
  name: String
  fieldLocation: FieldLocation
  slots: [Slot] 
}

type Facility {
  organizations: [Organization]
  url: String
}

type Advertisement {
  store: Store
  
}

type Discount {
  percentage: Int, 
  amount: String
}

type Coupon {
  code: String
  discount: Discount
  event: [Event]
  teams: [Team] 
  users: [User] 
  groups: [Group]
  access: [Access]
  accessCoupon: Boolean
  capacity: Int
}

type Store{
  name: String
  address: String
  storeLocation: StoreLocation
  parentStore: parentStore
}

type parentStore {
  name: String
  address: String
  stores: [Store] 
}

type Access {
  accessType: String
  coupon: Coupon
}

type AppFeedback {
  feedback: String
}

type BugFeedback {
  feedback: String
  severity: Int
}

`;



  // Resolvers define how to fetch the types defined in your schema.
// This resolver retrieves books from the "books" array above.


  // interface ContextValue {
  //   dataSources: {
  //     eventsAPI: EventsAPI;
  //   };
  // }

  
  
  
  // The ApolloServer constructor requires two parameters: your schema
  // definition and your set of resolvers.
  const server = new ApolloServer({
    typeDefs,
    resolvers,
    
  });
  
  mongoose.connect(MongoDB, {
    
  })
  .then( () => {
    console.log('Connected to MongoDB');
    return startStandaloneServer(server, {
      context: async () => {
         const { cache } = server;      
        return {
          // We create new instances of our data sources with each request,
          // passing in our server's cache.
          dataSources: {
            // eventsAPI: new EventsAPI({ cache }),
            
          },
        };
      },
      listen: { port: 4000 },
    });
    
    
  }).then((res) => {
    console.log(`Server running at ${res.url}`);  
  })
  
  
  // const { url } = await startStandaloneServer(server, {
  //   context: async () => {
  //      const { cache } = server;      
  //     return {
  //       // We create new instances of our data sources with each request,
  //       // passing in our server's cache.
  //       dataSources: {
  //         eventsAPI: new EventsAPI({ cache }),
          
  //       },
  //     };
  //   },
  //   listen: { port: 4000 },
  // });

  
  
  
  // Passing an ApolloServer instance to the `startStandaloneServer` function:
  //  1. creates an Express app
  //  2. installs your ApolloServer instance as middleware
  //  3. prepares your app to handle incoming requests
  // const { url } = await startStandaloneServer(server, {
  //   listen: { port: 4000 },
  // });
  
  