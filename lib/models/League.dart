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


/** This is an auto generated class representing the League type in your schema. */
@immutable
class League extends Model {
  static const classType = const _LeagueModelType();
  final String id;
  final String? _name;
  final String? _tournament;
  final String? _teams;
  final String? _wagers;
  final String? _images;
  final Event? _event;
  final List<Event>? _events;
  final List<LeagueEvent>? _eligibleEventTypes;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _leagueEventId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  String? get tournament {
    return _tournament;
  }
  
  String? get teams {
    return _teams;
  }
  
  String? get wagers {
    return _wagers;
  }
  
  String? get images {
    return _images;
  }
  
  Event? get event {
    return _event;
  }
  
  List<Event>? get events {
    return _events;
  }
  
  List<LeagueEvent>? get eligibleEventTypes {
    return _eligibleEventTypes;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get leagueEventId {
    return _leagueEventId;
  }
  
  const League._internal({required this.id, name, tournament, teams, wagers, images, event, events, eligibleEventTypes, createdAt, updatedAt, leagueEventId}): _name = name, _tournament = tournament, _teams = teams, _wagers = wagers, _images = images, _event = event, _events = events, _eligibleEventTypes = eligibleEventTypes, _createdAt = createdAt, _updatedAt = updatedAt, _leagueEventId = leagueEventId;
  
  factory League({String? id, String? name, String? tournament, String? teams, String? wagers, String? images, Event? event, List<Event>? events, List<LeagueEvent>? eligibleEventTypes, String? leagueEventId}) {
    return League._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      tournament: tournament,
      teams: teams,
      wagers: wagers,
      images: images,
      event: event,
      events: events != null ? List<Event>.unmodifiable(events) : events,
      eligibleEventTypes: eligibleEventTypes != null ? List<LeagueEvent>.unmodifiable(eligibleEventTypes) : eligibleEventTypes,
      leagueEventId: leagueEventId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is League &&
      id == other.id &&
      _name == other._name &&
      _tournament == other._tournament &&
      _teams == other._teams &&
      _wagers == other._wagers &&
      _images == other._images &&
      _event == other._event &&
      DeepCollectionEquality().equals(_events, other._events) &&
      DeepCollectionEquality().equals(_eligibleEventTypes, other._eligibleEventTypes) &&
      _leagueEventId == other._leagueEventId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("League {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("tournament=" + "$_tournament" + ", ");
    buffer.write("teams=" + "$_teams" + ", ");
    buffer.write("wagers=" + "$_wagers" + ", ");
    buffer.write("images=" + "$_images" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("leagueEventId=" + "$_leagueEventId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  League copyWith({String? id, String? name, String? tournament, String? teams, String? wagers, String? images, Event? event, List<Event>? events, List<LeagueEvent>? eligibleEventTypes, String? leagueEventId}) {
    return League._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      tournament: tournament ?? this.tournament,
      teams: teams ?? this.teams,
      wagers: wagers ?? this.wagers,
      images: images ?? this.images,
      event: event ?? this.event,
      events: events ?? this.events,
      eligibleEventTypes: eligibleEventTypes ?? this.eligibleEventTypes,
      leagueEventId: leagueEventId ?? this.leagueEventId);
  }
  
  League.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _tournament = json['tournament'],
      _teams = json['teams'],
      _wagers = json['wagers'],
      _images = json['images'],
      _event = json['event']?['serializedData'] != null
        ? Event.fromJson(new Map<String, dynamic>.from(json['event']['serializedData']))
        : null,
      _events = json['events'] is List
        ? (json['events'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Event.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _eligibleEventTypes = json['eligibleEventTypes'] is List
        ? (json['eligibleEventTypes'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => LeagueEvent.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _leagueEventId = json['leagueEventId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'tournament': _tournament, 'teams': _teams, 'wagers': _wagers, 'images': _images, 'event': _event?.toJson(), 'events': _events?.map((Event? e) => e?.toJson()).toList(), 'eligibleEventTypes': _eligibleEventTypes?.map((LeagueEvent? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'leagueEventId': _leagueEventId
  };

  static final QueryField ID = QueryField(fieldName: "league.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField TOURNAMENT = QueryField(fieldName: "tournament");
  static final QueryField TEAMS = QueryField(fieldName: "teams");
  static final QueryField WAGERS = QueryField(fieldName: "wagers");
  static final QueryField IMAGES = QueryField(fieldName: "images");
  static final QueryField EVENT = QueryField(
    fieldName: "event",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Event).toString()));
  static final QueryField EVENTS = QueryField(
    fieldName: "events",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Event).toString()));
  static final QueryField ELIGIBLEEVENTTYPES = QueryField(
    fieldName: "eligibleEventTypes",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (LeagueEvent).toString()));
  static final QueryField LEAGUEEVENTID = QueryField(fieldName: "leagueEventId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "League";
    modelSchemaDefinition.pluralName = "Leagues";
    
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
      key: League.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: League.TOURNAMENT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: League.TEAMS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: League.WAGERS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: League.IMAGES,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: League.EVENT,
      isRequired: false,
      ofModelName: (Event).toString(),
      associatedKey: Event.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: League.EVENTS,
      isRequired: false,
      ofModelName: (Event).toString(),
      associatedKey: Event.LEAGUEID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: League.ELIGIBLEEVENTTYPES,
      isRequired: false,
      ofModelName: (LeagueEvent).toString(),
      associatedKey: LeagueEvent.LEAGUE
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: League.LEAGUEEVENTID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _LeagueModelType extends ModelType<League> {
  const _LeagueModelType();
  
  @override
  League fromJson(Map<String, dynamic> jsonData) {
    return League.fromJson(jsonData);
  }
}