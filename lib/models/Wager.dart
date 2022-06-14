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

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Wager type in your schema. */
@immutable
class Wager extends Model {
  static const classType = const _WagerModelType();
  final String id;
  final String? _name;
  final String? _amount;
  final String? _players;
  final String? _events;
  final String? _private;
  final String? _league;
  final String? _tournament;
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
  
  String? get amount {
    return _amount;
  }
  
  String? get players {
    return _players;
  }
  
  String? get events {
    return _events;
  }
  
  String? get private {
    return _private;
  }
  
  String? get league {
    return _league;
  }
  
  String? get tournament {
    return _tournament;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Wager._internal({required this.id, name, amount, players, events, private, league, tournament, createdAt, updatedAt}): _name = name, _amount = amount, _players = players, _events = events, _private = private, _league = league, _tournament = tournament, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Wager({String? id, String? name, String? amount, String? players, String? events, String? private, String? league, String? tournament}) {
    return Wager._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      amount: amount,
      players: players,
      events: events,
      private: private,
      league: league,
      tournament: tournament);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Wager &&
      id == other.id &&
      _name == other._name &&
      _amount == other._amount &&
      _players == other._players &&
      _events == other._events &&
      _private == other._private &&
      _league == other._league &&
      _tournament == other._tournament;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Wager {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("amount=" + "$_amount" + ", ");
    buffer.write("players=" + "$_players" + ", ");
    buffer.write("events=" + "$_events" + ", ");
    buffer.write("private=" + "$_private" + ", ");
    buffer.write("league=" + "$_league" + ", ");
    buffer.write("tournament=" + "$_tournament" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Wager copyWith({String? id, String? name, String? amount, String? players, String? events, String? private, String? league, String? tournament}) {
    return Wager._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      players: players ?? this.players,
      events: events ?? this.events,
      private: private ?? this.private,
      league: league ?? this.league,
      tournament: tournament ?? this.tournament);
  }
  
  Wager.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _amount = json['amount'],
      _players = json['players'],
      _events = json['events'],
      _private = json['private'],
      _league = json['league'],
      _tournament = json['tournament'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'amount': _amount, 'players': _players, 'events': _events, 'private': _private, 'league': _league, 'tournament': _tournament, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "wager.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField AMOUNT = QueryField(fieldName: "amount");
  static final QueryField PLAYERS = QueryField(fieldName: "players");
  static final QueryField EVENTS = QueryField(fieldName: "events");
  static final QueryField PRIVATE = QueryField(fieldName: "private");
  static final QueryField LEAGUE = QueryField(fieldName: "league");
  static final QueryField TOURNAMENT = QueryField(fieldName: "tournament");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Wager";
    modelSchemaDefinition.pluralName = "Wagers";
    
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
      key: Wager.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Wager.AMOUNT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Wager.PLAYERS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Wager.EVENTS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Wager.PRIVATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Wager.LEAGUE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Wager.TOURNAMENT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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

class _WagerModelType extends ModelType<Wager> {
  const _WagerModelType();
  
  @override
  Wager fromJson(Map<String, dynamic> jsonData) {
    return Wager.fromJson(jsonData);
  }
}