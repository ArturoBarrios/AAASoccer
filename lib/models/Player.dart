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


/** This is an auto generated class representing the Player type in your schema. */
@immutable
class Player extends Model {
  static const classType = const _PlayerModelType();
  final String id;
  final String? _playerRating;
  final String? _wagerRating;
  final String? _events;
  final String? _competitiveLevel;
  final String? _ratings;
  final String? _hasRating;
  final String? _showRating;
  final String? _hasSubscription;
  final User? _user;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get playerRating {
    return _playerRating;
  }
  
  String? get wagerRating {
    return _wagerRating;
  }
  
  String? get events {
    return _events;
  }
  
  String? get competitiveLevel {
    return _competitiveLevel;
  }
  
  String? get ratings {
    return _ratings;
  }
  
  String? get hasRating {
    return _hasRating;
  }
  
  String? get showRating {
    return _showRating;
  }
  
  String? get hasSubscription {
    return _hasSubscription;
  }
  
  User? get user {
    return _user;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Player._internal({required this.id, playerRating, wagerRating, events, competitiveLevel, ratings, hasRating, showRating, hasSubscription, user, createdAt, updatedAt}): _playerRating = playerRating, _wagerRating = wagerRating, _events = events, _competitiveLevel = competitiveLevel, _ratings = ratings, _hasRating = hasRating, _showRating = showRating, _hasSubscription = hasSubscription, _user = user, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Player({String? id, String? playerRating, String? wagerRating, String? events, String? competitiveLevel, String? ratings, String? hasRating, String? showRating, String? hasSubscription, User? user}) {
    return Player._internal(
      id: id == null ? UUID.getUUID() : id,
      playerRating: playerRating,
      wagerRating: wagerRating,
      events: events,
      competitiveLevel: competitiveLevel,
      ratings: ratings,
      hasRating: hasRating,
      showRating: showRating,
      hasSubscription: hasSubscription,
      user: user);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Player &&
      id == other.id &&
      _playerRating == other._playerRating &&
      _wagerRating == other._wagerRating &&
      _events == other._events &&
      _competitiveLevel == other._competitiveLevel &&
      _ratings == other._ratings &&
      _hasRating == other._hasRating &&
      _showRating == other._showRating &&
      _hasSubscription == other._hasSubscription &&
      _user == other._user;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Player {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("playerRating=" + "$_playerRating" + ", ");
    buffer.write("wagerRating=" + "$_wagerRating" + ", ");
    buffer.write("events=" + "$_events" + ", ");
    buffer.write("competitiveLevel=" + "$_competitiveLevel" + ", ");
    buffer.write("ratings=" + "$_ratings" + ", ");
    buffer.write("hasRating=" + "$_hasRating" + ", ");
    buffer.write("showRating=" + "$_showRating" + ", ");
    buffer.write("hasSubscription=" + "$_hasSubscription" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Player copyWith({String? id, String? playerRating, String? wagerRating, String? events, String? competitiveLevel, String? ratings, String? hasRating, String? showRating, String? hasSubscription, User? user}) {
    return Player._internal(
      id: id ?? this.id,
      playerRating: playerRating ?? this.playerRating,
      wagerRating: wagerRating ?? this.wagerRating,
      events: events ?? this.events,
      competitiveLevel: competitiveLevel ?? this.competitiveLevel,
      ratings: ratings ?? this.ratings,
      hasRating: hasRating ?? this.hasRating,
      showRating: showRating ?? this.showRating,
      hasSubscription: hasSubscription ?? this.hasSubscription,
      user: user ?? this.user);
  }
  
  Player.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _playerRating = json['playerRating'],
      _wagerRating = json['wagerRating'],
      _events = json['events'],
      _competitiveLevel = json['competitiveLevel'],
      _ratings = json['ratings'],
      _hasRating = json['hasRating'],
      _showRating = json['showRating'],
      _hasSubscription = json['hasSubscription'],
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'playerRating': _playerRating, 'wagerRating': _wagerRating, 'events': _events, 'competitiveLevel': _competitiveLevel, 'ratings': _ratings, 'hasRating': _hasRating, 'showRating': _showRating, 'hasSubscription': _hasSubscription, 'user': _user?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField PLAYERRATING = QueryField(fieldName: "playerRating");
  static final QueryField WAGERRATING = QueryField(fieldName: "wagerRating");
  static final QueryField EVENTS = QueryField(fieldName: "events");
  static final QueryField COMPETITIVELEVEL = QueryField(fieldName: "competitiveLevel");
  static final QueryField RATINGS = QueryField(fieldName: "ratings");
  static final QueryField HASRATING = QueryField(fieldName: "hasRating");
  static final QueryField SHOWRATING = QueryField(fieldName: "showRating");
  static final QueryField HASSUBSCRIPTION = QueryField(fieldName: "hasSubscription");
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Player";
    modelSchemaDefinition.pluralName = "Players";
    
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
      key: Player.PLAYERRATING,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Player.WAGERRATING,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Player.EVENTS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Player.COMPETITIVELEVEL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Player.RATINGS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Player.HASRATING,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Player.SHOWRATING,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Player.HASSUBSCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Player.USER,
      isRequired: false,
      targetName: "playerUserId",
      ofModelName: (User).toString()
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

class _PlayerModelType extends ModelType<Player> {
  const _PlayerModelType();
  
  @override
  Player fromJson(Map<String, dynamic> jsonData) {
    return Player.fromJson(jsonData);
  }
}