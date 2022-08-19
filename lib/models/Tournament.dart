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


/** This is an auto generated class representing the Tournament type in your schema. */
@immutable
class Tournament extends Model {
  static const classType = const _TournamentModelType();
  final String id;
  final String? _name;
  final bool? _groupPlay;
  final String? _teams;
  final String? _images;
  final Event? _event;
  final List<Event>? _events;
  final List<TournamentEvent>? _eligibleEventTypes;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _tournamentEventId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  bool? get groupPlay {
    return _groupPlay;
  }
  
  String? get teams {
    return _teams;
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
  
  List<TournamentEvent>? get eligibleEventTypes {
    return _eligibleEventTypes;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get tournamentEventId {
    return _tournamentEventId;
  }
  
  const Tournament._internal({required this.id, name, groupPlay, teams, images, event, events, eligibleEventTypes, createdAt, updatedAt, tournamentEventId}): _name = name, _groupPlay = groupPlay, _teams = teams, _images = images, _event = event, _events = events, _eligibleEventTypes = eligibleEventTypes, _createdAt = createdAt, _updatedAt = updatedAt, _tournamentEventId = tournamentEventId;
  
  factory Tournament({String? id, String? name, bool? groupPlay, String? teams, String? images, Event? event, List<Event>? events, List<TournamentEvent>? eligibleEventTypes, String? tournamentEventId}) {
    return Tournament._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      groupPlay: groupPlay,
      teams: teams,
      images: images,
      event: event,
      events: events != null ? List<Event>.unmodifiable(events) : events,
      eligibleEventTypes: eligibleEventTypes != null ? List<TournamentEvent>.unmodifiable(eligibleEventTypes) : eligibleEventTypes,
      tournamentEventId: tournamentEventId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Tournament &&
      id == other.id &&
      _name == other._name &&
      _groupPlay == other._groupPlay &&
      _teams == other._teams &&
      _images == other._images &&
      _event == other._event &&
      DeepCollectionEquality().equals(_events, other._events) &&
      DeepCollectionEquality().equals(_eligibleEventTypes, other._eligibleEventTypes) &&
      _tournamentEventId == other._tournamentEventId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Tournament {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("groupPlay=" + (_groupPlay != null ? _groupPlay!.toString() : "null") + ", ");
    buffer.write("teams=" + "$_teams" + ", ");
    buffer.write("images=" + "$_images" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("tournamentEventId=" + "$_tournamentEventId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Tournament copyWith({String? id, String? name, bool? groupPlay, String? teams, String? images, Event? event, List<Event>? events, List<TournamentEvent>? eligibleEventTypes, String? tournamentEventId}) {
    return Tournament._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      groupPlay: groupPlay ?? this.groupPlay,
      teams: teams ?? this.teams,
      images: images ?? this.images,
      event: event ?? this.event,
      events: events ?? this.events,
      eligibleEventTypes: eligibleEventTypes ?? this.eligibleEventTypes,
      tournamentEventId: tournamentEventId ?? this.tournamentEventId);
  }
  
  Tournament.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _groupPlay = json['groupPlay'],
      _teams = json['teams'],
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
          .map((e) => TournamentEvent.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _tournamentEventId = json['tournamentEventId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'groupPlay': _groupPlay, 'teams': _teams, 'images': _images, 'event': _event?.toJson(), 'events': _events?.map((Event? e) => e?.toJson()).toList(), 'eligibleEventTypes': _eligibleEventTypes?.map((TournamentEvent? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'tournamentEventId': _tournamentEventId
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField GROUPPLAY = QueryField(fieldName: "groupPlay");
  static final QueryField TEAMS = QueryField(fieldName: "teams");
  static final QueryField IMAGES = QueryField(fieldName: "images");
  static final QueryField EVENT = QueryField(
    fieldName: "event",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Event).toString()));
  static final QueryField EVENTS = QueryField(
    fieldName: "events",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Event).toString()));
  static final QueryField ELIGIBLEEVENTTYPES = QueryField(
    fieldName: "eligibleEventTypes",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (TournamentEvent).toString()));
  static final QueryField TOURNAMENTEVENTID = QueryField(fieldName: "tournamentEventId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Tournament";
    modelSchemaDefinition.pluralName = "Tournaments";
    
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
      key: Tournament.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Tournament.GROUPPLAY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Tournament.TEAMS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Tournament.IMAGES,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Tournament.EVENT,
      isRequired: false,
      ofModelName: (Event).toString(),
      associatedKey: Event.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Tournament.EVENTS,
      isRequired: false,
      ofModelName: (Event).toString(),
      associatedKey: Event.TOURNAMENTID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Tournament.ELIGIBLEEVENTTYPES,
      isRequired: false,
      ofModelName: (TournamentEvent).toString(),
      associatedKey: TournamentEvent.TOURNAMENT
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
      key: Tournament.TOURNAMENTEVENTID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _TournamentModelType extends ModelType<Tournament> {
  const _TournamentModelType();
  
  @override
  Tournament fromJson(Map<String, dynamic> jsonData) {
    return Tournament.fromJson(jsonData);
  }
}