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


/** This is an auto generated class representing the Tryout type in your schema. */
@immutable
class Tryout extends Model {
  static const classType = const _TryoutModelType();
  final String id;
  final String? _players;
  final String? _game;
  final Event? _event;
  final List<Event>? _events;
  final List<TryoutEvent>? _eligibleEventTypes;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _tryoutEventId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get players {
    return _players;
  }
  
  String? get game {
    return _game;
  }
  
  Event? get event {
    return _event;
  }
  
  List<Event>? get events {
    return _events;
  }
  
  List<TryoutEvent>? get eligibleEventTypes {
    return _eligibleEventTypes;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get tryoutEventId {
    return _tryoutEventId;
  }
  
  const Tryout._internal({required this.id, players, game, event, events, eligibleEventTypes, createdAt, updatedAt, tryoutEventId}): _players = players, _game = game, _event = event, _events = events, _eligibleEventTypes = eligibleEventTypes, _createdAt = createdAt, _updatedAt = updatedAt, _tryoutEventId = tryoutEventId;
  
  factory Tryout({String? id, String? players, String? game, Event? event, List<Event>? events, List<TryoutEvent>? eligibleEventTypes, String? tryoutEventId}) {
    return Tryout._internal(
      id: id == null ? UUID.getUUID() : id,
      players: players,
      game: game,
      event: event,
      events: events != null ? List<Event>.unmodifiable(events) : events,
      eligibleEventTypes: eligibleEventTypes != null ? List<TryoutEvent>.unmodifiable(eligibleEventTypes) : eligibleEventTypes,
      tryoutEventId: tryoutEventId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Tryout &&
      id == other.id &&
      _players == other._players &&
      _game == other._game &&
      _event == other._event &&
      DeepCollectionEquality().equals(_events, other._events) &&
      DeepCollectionEquality().equals(_eligibleEventTypes, other._eligibleEventTypes) &&
      _tryoutEventId == other._tryoutEventId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Tryout {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("players=" + "$_players" + ", ");
    buffer.write("game=" + "$_game" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("tryoutEventId=" + "$_tryoutEventId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Tryout copyWith({String? id, String? players, String? game, Event? event, List<Event>? events, List<TryoutEvent>? eligibleEventTypes, String? tryoutEventId}) {
    return Tryout._internal(
      id: id ?? this.id,
      players: players ?? this.players,
      game: game ?? this.game,
      event: event ?? this.event,
      events: events ?? this.events,
      eligibleEventTypes: eligibleEventTypes ?? this.eligibleEventTypes,
      tryoutEventId: tryoutEventId ?? this.tryoutEventId);
  }
  
  Tryout.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _players = json['players'],
      _game = json['game'],
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
          .map((e) => TryoutEvent.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _tryoutEventId = json['tryoutEventId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'players': _players, 'game': _game, 'event': _event?.toJson(), 'events': _events?.map((Event? e) => e?.toJson()).toList(), 'eligibleEventTypes': _eligibleEventTypes?.map((TryoutEvent? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'tryoutEventId': _tryoutEventId
  };

  static final QueryField ID = QueryField(fieldName: "tryout.id");
  static final QueryField PLAYERS = QueryField(fieldName: "players");
  static final QueryField GAME = QueryField(fieldName: "game");
  static final QueryField EVENT = QueryField(
    fieldName: "event",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Event).toString()));
  static final QueryField EVENTS = QueryField(
    fieldName: "events",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Event).toString()));
  static final QueryField ELIGIBLEEVENTTYPES = QueryField(
    fieldName: "eligibleEventTypes",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (TryoutEvent).toString()));
  static final QueryField TRYOUTEVENTID = QueryField(fieldName: "tryoutEventId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Tryout";
    modelSchemaDefinition.pluralName = "Tryouts";
    
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
      key: Tryout.PLAYERS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Tryout.GAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Tryout.EVENT,
      isRequired: false,
      ofModelName: (Event).toString(),
      associatedKey: Event.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Tryout.EVENTS,
      isRequired: false,
      ofModelName: (Event).toString(),
      associatedKey: Event.TRYOUTID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Tryout.ELIGIBLEEVENTTYPES,
      isRequired: false,
      ofModelName: (TryoutEvent).toString(),
      associatedKey: TryoutEvent.TRYOUT
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
      key: Tryout.TRYOUTEVENTID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _TryoutModelType extends ModelType<Tryout> {
  const _TryoutModelType();
  
  @override
  Tryout fromJson(Map<String, dynamic> jsonData) {
    return Tryout.fromJson(jsonData);
  }
}