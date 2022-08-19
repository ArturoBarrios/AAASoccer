/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Event type in your schema. */
@immutable
class Event extends Model {
  static const classType = const _EventModelType();
  final String id;
  final String? _name;
  final String? _organizer;
  final String? _tryout;
  final String? _training;
  final String? _ratings;
  final String? _images;
  final String? _price;
  final String? _location;
  final EventType? _type;
  final String? _locationID;
  final String? _trainingID;
  final String? _tournamentID;
  final String? _leagueID;
  final String? _tryoutID;
  final List<TryoutEvent>? _tryouts;
  final List<LeagueEvent>? _leagues;
  final List<TournamentEvent>? _tournaments;
  final List<TrainingEvent>? _trainings;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  String? get organizer {
    return _organizer;
  }
  
  String? get tryout {
    return _tryout;
  }
  
  String? get training {
    return _training;
  }
  
  String? get ratings {
    return _ratings;
  }
  
  String? get images {
    return _images;
  }
  
  String? get price {
    return _price;
  }
  
  String? get location {
    return _location;
  }
  
  EventType? get type {
    return _type;
  }
  
  String? get locationID {
    return _locationID;
  }
  
  String? get trainingID {
    return _trainingID;
  }
  
  String? get tournamentID {
    return _tournamentID;
  }
  
  String? get leagueID {
    return _leagueID;
  }
  
  String? get tryoutID {
    return _tryoutID;
  }
  
  List<TryoutEvent>? get tryouts {
    return _tryouts;
  }
  
  List<LeagueEvent>? get leagues {
    return _leagues;
  }
  
  List<TournamentEvent>? get tournaments {
    return _tournaments;
  }
  
  List<TrainingEvent>? get trainings {
    return _trainings;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Event._internal({required this.id, name, organizer, tryout, training, ratings, images, price, location, type, locationID, trainingID, tournamentID, leagueID, tryoutID, tryouts, leagues, tournaments, trainings, createdAt, updatedAt}): _name = name, _organizer = organizer, _tryout = tryout, _training = training, _ratings = ratings, _images = images, _price = price, _location = location, _type = type, _locationID = locationID, _trainingID = trainingID, _tournamentID = tournamentID, _leagueID = leagueID, _tryoutID = tryoutID, _tryouts = tryouts, _leagues = leagues, _tournaments = tournaments, _trainings = trainings, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Event({String? id, String? name, String? organizer, String? tryout, String? training, String? ratings, String? images, String? price, String? location, EventType? type, String? locationID, String? trainingID, String? tournamentID, String? leagueID, String? tryoutID, List<TryoutEvent>? tryouts, List<LeagueEvent>? leagues, List<TournamentEvent>? tournaments, List<TrainingEvent>? trainings}) {
    return Event._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      organizer: organizer,
      tryout: tryout,
      training: training,
      ratings: ratings,
      images: images,
      price: price,
      location: location,
      type: type,
      locationID: locationID,
      trainingID: trainingID,
      tournamentID: tournamentID,
      leagueID: leagueID,
      tryoutID: tryoutID,
      tryouts: tryouts != null ? List<TryoutEvent>.unmodifiable(tryouts) : tryouts,
      leagues: leagues != null ? List<LeagueEvent>.unmodifiable(leagues) : leagues,
      tournaments: tournaments != null ? List<TournamentEvent>.unmodifiable(tournaments) : tournaments,
      trainings: trainings != null ? List<TrainingEvent>.unmodifiable(trainings) : trainings);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Event &&
      id == other.id &&
      _name == other._name &&
      _organizer == other._organizer &&
      _tryout == other._tryout &&
      _training == other._training &&
      _ratings == other._ratings &&
      _images == other._images &&
      _price == other._price &&
      _location == other._location &&
      _type == other._type &&
      _locationID == other._locationID &&
      _trainingID == other._trainingID &&
      _tournamentID == other._tournamentID &&
      _leagueID == other._leagueID &&
      _tryoutID == other._tryoutID &&
      DeepCollectionEquality().equals(_tryouts, other._tryouts) &&
      DeepCollectionEquality().equals(_leagues, other._leagues) &&
      DeepCollectionEquality().equals(_tournaments, other._tournaments) &&
      DeepCollectionEquality().equals(_trainings, other._trainings);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Event {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("organizer=" + "$_organizer" + ", ");
    buffer.write("tryout=" + "$_tryout" + ", ");
    buffer.write("training=" + "$_training" + ", ");
    buffer.write("ratings=" + "$_ratings" + ", ");
    buffer.write("images=" + "$_images" + ", ");
    buffer.write("price=" + "$_price" + ", ");
    buffer.write("location=" + "$_location" + ", ");
    buffer.write("type=" + (_type != null ? enumToString(_type)! : "null") + ", ");
    buffer.write("locationID=" + "$_locationID" + ", ");
    buffer.write("trainingID=" + "$_trainingID" + ", ");
    buffer.write("tournamentID=" + "$_tournamentID" + ", ");
    buffer.write("leagueID=" + "$_leagueID" + ", ");
    buffer.write("tryoutID=" + "$_tryoutID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Event copyWith({String? id, String? name, String? organizer, String? tryout, String? training, String? ratings, String? images, String? price, String? location, EventType? type, String? locationID, String? trainingID, String? tournamentID, String? leagueID, String? tryoutID, List<TryoutEvent>? tryouts, List<LeagueEvent>? leagues, List<TournamentEvent>? tournaments, List<TrainingEvent>? trainings}) {
    return Event._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      organizer: organizer ?? this.organizer,
      tryout: tryout ?? this.tryout,
      training: training ?? this.training,
      ratings: ratings ?? this.ratings,
      images: images ?? this.images,
      price: price ?? this.price,
      location: location ?? this.location,
      type: type ?? this.type,
      locationID: locationID ?? this.locationID,
      trainingID: trainingID ?? this.trainingID,
      tournamentID: tournamentID ?? this.tournamentID,
      leagueID: leagueID ?? this.leagueID,
      tryoutID: tryoutID ?? this.tryoutID,
      tryouts: tryouts ?? this.tryouts,
      leagues: leagues ?? this.leagues,
      tournaments: tournaments ?? this.tournaments,
      trainings: trainings ?? this.trainings);
  }
  
  Event.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _organizer = json['organizer'],
      _tryout = json['tryout'],
      _training = json['training'],
      _ratings = json['ratings'],
      _images = json['images'],
      _price = json['price'],
      _location = json['location'],
      _type = enumFromString<EventType>(json['type'], EventType.values),
      _locationID = json['locationID'],
      _trainingID = json['trainingID'],
      _tournamentID = json['tournamentID'],
      _leagueID = json['leagueID'],
      _tryoutID = json['tryoutID'],
      _tryouts = json['tryouts'] is List
        ? (json['tryouts'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => TryoutEvent.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _leagues = json['leagues'] is List
        ? (json['leagues'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => LeagueEvent.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _tournaments = json['tournaments'] is List
        ? (json['tournaments'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => TournamentEvent.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _trainings = json['trainings'] is List
        ? (json['trainings'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => TrainingEvent.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'organizer': _organizer, 'tryout': _tryout, 'training': _training, 'ratings': _ratings, 'images': _images, 'price': _price, 'location': _location, 'type': enumToString(_type), 'locationID': _locationID, 'trainingID': _trainingID, 'tournamentID': _tournamentID, 'leagueID': _leagueID, 'tryoutID': _tryoutID, 'tryouts': _tryouts?.map((TryoutEvent? e) => e?.toJson()).toList(), 'leagues': _leagues?.map((LeagueEvent? e) => e?.toJson()).toList(), 'tournaments': _tournaments?.map((TournamentEvent? e) => e?.toJson()).toList(), 'trainings': _trainings?.map((TrainingEvent? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField ORGANIZER = QueryField(fieldName: "organizer");
  static final QueryField TRYOUT = QueryField(fieldName: "tryout");
  static final QueryField TRAINING = QueryField(fieldName: "training");
  static final QueryField RATINGS = QueryField(fieldName: "ratings");
  static final QueryField IMAGES = QueryField(fieldName: "images");
  static final QueryField PRICE = QueryField(fieldName: "price");
  static final QueryField LOCATION = QueryField(fieldName: "location");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField LOCATIONID = QueryField(fieldName: "locationID");
  static final QueryField TRAININGID = QueryField(fieldName: "trainingID");
  static final QueryField TOURNAMENTID = QueryField(fieldName: "tournamentID");
  static final QueryField LEAGUEID = QueryField(fieldName: "leagueID");
  static final QueryField TRYOUTID = QueryField(fieldName: "tryoutID");
  static final QueryField TRYOUTS = QueryField(
    fieldName: "tryouts",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (TryoutEvent).toString()));
  static final QueryField LEAGUES = QueryField(
    fieldName: "leagues",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (LeagueEvent).toString()));
  static final QueryField TOURNAMENTS = QueryField(
    fieldName: "tournaments",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (TournamentEvent).toString()));
  static final QueryField TRAININGS = QueryField(
    fieldName: "trainings",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (TrainingEvent).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Event";
    modelSchemaDefinition.pluralName = "Events";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.ORGANIZER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.TRYOUT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.TRAINING,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.RATINGS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.IMAGES,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.PRICE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.LOCATION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.TYPE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.LOCATIONID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.TRAININGID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.TOURNAMENTID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.LEAGUEID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.TRYOUTID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Event.TRYOUTS,
      isRequired: false,
      ofModelName: (TryoutEvent).toString(),
      associatedKey: TryoutEvent.EVENT
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Event.LEAGUES,
      isRequired: false,
      ofModelName: (LeagueEvent).toString(),
      associatedKey: LeagueEvent.EVENT
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Event.TOURNAMENTS,
      isRequired: false,
      ofModelName: (TournamentEvent).toString(),
      associatedKey: TournamentEvent.EVENT
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Event.TRAININGS,
      isRequired: false,
      ofModelName: (TrainingEvent).toString(),
      associatedKey: TrainingEvent.EVENT
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _EventModelType extends ModelType<Event> {
  const _EventModelType();
  
  @override
  Event fromJson(Map<String, dynamic> jsonData) {
    return Event.fromJson(jsonData);
  }
}