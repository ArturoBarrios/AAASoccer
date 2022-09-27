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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Game type in your schema. */
@immutable
class Game extends Model {
  static const classType = const _GameModelType();
  final String id;
  final String? _hometeam;
  final String? _awayTeam;
  final String? _score;
  final String? _wagers;
  final bool? _pickup;
  final Event? _event;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _gameEventId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get hometeam {
    return _hometeam;
  }
  
  String? get awayTeam {
    return _awayTeam;
  }
  
  String? get score {
    return _score;
  }
  
  String? get wagers {
    return _wagers;
  }
  
  bool? get pickup {
    return _pickup;
  }
  
  Event? get event {
    return _event;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get gameEventId {
    return _gameEventId;
  }
  
  const Game._internal({required this.id, hometeam, awayTeam, score, wagers, pickup, event, createdAt, updatedAt, gameEventId}): _hometeam = hometeam, _awayTeam = awayTeam, _score = score, _wagers = wagers, _pickup = pickup, _event = event, _createdAt = createdAt, _updatedAt = updatedAt, _gameEventId = gameEventId;
  
  factory Game({String? id, String? hometeam, String? awayTeam, String? score, String? wagers, bool? pickup, Event? event, String? gameEventId}) {
    return Game._internal(
      id: id == null ? UUID.getUUID() : id,
      hometeam: hometeam,
      awayTeam: awayTeam,
      score: score,
      wagers: wagers,
      pickup: pickup,
      event: event,
      gameEventId: gameEventId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Game &&
      id == other.id &&
      _hometeam == other._hometeam &&
      _awayTeam == other._awayTeam &&
      _score == other._score &&
      _wagers == other._wagers &&
      _pickup == other._pickup &&
      _event == other._event &&
      _gameEventId == other._gameEventId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Game {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("hometeam=" + "$_hometeam" + ", ");
    buffer.write("awayTeam=" + "$_awayTeam" + ", ");
    buffer.write("score=" + "$_score" + ", ");
    buffer.write("wagers=" + "$_wagers" + ", ");
    buffer.write("pickup=" + (_pickup != null ? _pickup!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("gameEventId=" + "$_gameEventId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Game copyWith({String? id, String? hometeam, String? awayTeam, String? score, String? wagers, bool? pickup, Event? event, String? gameEventId}) {
    return Game._internal(
      id: id ?? this.id,
      hometeam: hometeam ?? this.hometeam,
      awayTeam: awayTeam ?? this.awayTeam,
      score: score ?? this.score,
      wagers: wagers ?? this.wagers,
      pickup: pickup ?? this.pickup,
      event: event ?? this.event,
      gameEventId: gameEventId ?? this.gameEventId);
  }
  
  Game.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _hometeam = json['hometeam'],
      _awayTeam = json['awayTeam'],
      _score = json['score'],
      _wagers = json['wagers'],
      _pickup = json['pickup'],
      _event = json['event']?['serializedData'] != null
        ? Event.fromJson(new Map<String, dynamic>.from(json['event']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _gameEventId = json['gameEventId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'hometeam': _hometeam, 'awayTeam': _awayTeam, 'score': _score, 'wagers': _wagers, 'pickup': _pickup, 'event': _event?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'gameEventId': _gameEventId
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField HOMETEAM = QueryField(fieldName: "hometeam");
  static final QueryField AWAYTEAM = QueryField(fieldName: "awayTeam");
  static final QueryField SCORE = QueryField(fieldName: "score");
  static final QueryField WAGERS = QueryField(fieldName: "wagers");
  static final QueryField PICKUP = QueryField(fieldName: "pickup");
  static final QueryField EVENT = QueryField(
    fieldName: "event",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Event).toString()));
  static final QueryField GAMEEVENTID = QueryField(fieldName: "gameEventId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Game";
    modelSchemaDefinition.pluralName = "Games";
    
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
      key: Game.HOMETEAM,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Game.AWAYTEAM,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Game.SCORE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Game.WAGERS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Game.PICKUP,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Game.EVENT,
      isRequired: false,
      ofModelName: (Event).toString(),
      associatedKey: Event.ID
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
      key: Game.GAMEEVENTID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _GameModelType extends ModelType<Game> {
  const _GameModelType();
  
  @override
  Game fromJson(Map<String, dynamic> jsonData) {
    return Game.fromJson(jsonData);
  }
}