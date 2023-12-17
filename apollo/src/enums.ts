export enum EventType {
    TRYOUT,
    GAME,
    LEAGUE,
    TOURNAMENT,
    TRAINING,
}


export enum EventUserParticipantAttendingOptions {
    YES,
    NO,
    MAYBE,
  }

  export enum PaymentType {
    STRIPE,
    PAYPAL,
    GOOGLE,
    APPLE,
  }
 
  export enum GenderType {
    MALE,
    FEMALE,
    OTHER,
  }

  export enum LocationType {
    TEAM,
    EVENT,
    ORGANIZATION,
    USER,
    FACILITY,
  }

  export enum UserAccountStatus{
    UNCOMFIRMED,
    CONFIRMED,
    INACTIVE,
    BANNED, 
  }

  export enum RequestType{
    FRIENDREQUEST,
    GAMEREQUEST,
    TEAMREQUEST,
    TOURNAMENTREQUEST,
    LEAGUEREQUEST,
    TRAININGREQUEST,
    TEAMEVENTREQUEST,
    TEAMCHATREQUEST,
    EVENTCHATREQUEST,
  }

  export enum RequestStatus{
    PENDING,
    ACCEPTED,
    REJECTED
  }

  export enum SocialMediaType {
    FACEBOOK,
    INSTAGRAM,
    X,
    YOUTUBE,
    LINKEDIN,
  }

  export enum FieldPlayerOccupancySize {
    SMALL,
    MEDIUM,
    FULLSIZE,
  }

  export enum SurfaceType {
    TURFPOOR,
    TURFOKAY,
    TURFGOOD,
    TURFEXCELLENT,
    GRASSPOOR,
    GRASSOKAY,
    GRASSGOOD,
    GRASSEXCELLENT,
    HARDFLOOR,
    SAND,
    NAILS,
    QUICKSAND,
  }

  export enum AmenityType {
    BATHROOMS,
    WATERFOUNDATIN,
    BIKESTATION,
    TRAIN,
    BUS,
    TURF,
    PINNIES,
    PARKING
  }