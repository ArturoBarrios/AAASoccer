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


/** This is an auto generated class representing the Team type in your schema. */
@immutable
class Team extends Model {
  static const classType = const _TeamModelType();
  final String id;
  final String? _name;
  final String? _color;
  final String? _logo;
  final String? _event;
  final String? _images;
  final String? _players;
  final String? _events;
  final String? _leagues;
  final String? _tournaments;
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
  
  String? get color {
    return _color;
  }
  
  String? get logo {
    return _logo;
  }
  
  String? get event {
    return _event;
  }
  
  String? get images {
    return _images;
  }
  
  String? get players {
    return _players;
  }
  
  String? get events {
    return _events;
  }
  
  String? get leagues {
    return _leagues;
  }
  
  String? get tournaments {
    return _tournaments;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Team._internal({required this.id, name, color, logo, event, images, players, events, leagues, tournaments, createdAt, updatedAt}): _name = name, _color = color, _logo = logo, _event = event, _images = images, _players = players, _events = events, _leagues = leagues, _tournaments = tournaments, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Team({String? id, String? name, String? color, String? logo, String? event, String? images, String? players, String? events, String? leagues, String? tournaments}) {
    return Team._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      color: color,
      logo: logo,
      event: event,
      images: images,
      players: players,
      events: events,
      leagues: leagues,
      tournaments: tournaments);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Team &&
      id == other.id &&
      _name == other._name &&
      _color == other._color &&
      _logo == other._logo &&
      _event == other._event &&
      _images == other._images &&
      _players == other._players &&
      _events == other._events &&
      _leagues == other._leagues &&
      _tournaments == other._tournaments;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Team {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("color=" + "$_color" + ", ");
    buffer.write("logo=" + "$_logo" + ", ");
    buffer.write("event=" + "$_event" + ", ");
    buffer.write("images=" + "$_images" + ", ");
    buffer.write("players=" + "$_players" + ", ");
    buffer.write("events=" + "$_events" + ", ");
    buffer.write("leagues=" + "$_leagues" + ", ");
    buffer.write("tournaments=" + "$_tournaments" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Team copyWith({String? id, String? name, String? color, String? logo, String? event, String? images, String? players, String? events, String? leagues, String? tournaments}) {
    return Team._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      logo: logo ?? this.logo,
      event: event ?? this.event,
      images: images ?? this.images,
      players: players ?? this.players,
      events: events ?? this.events,
      leagues: leagues ?? this.leagues,
      tournaments: tournaments ?? this.tournaments);
  }
  
  Team.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _color = json['color'],
      _logo = json['logo'],
      _event = json['event'],
      _images = json['images'],
      _players = json['players'],
      _events = json['events'],
      _leagues = json['leagues'],
      _tournaments = json['tournaments'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'color': _color, 'logo': _logo, 'event': _event, 'images': _images, 'players': _players, 'events': _events, 'leagues': _leagues, 'tournaments': _tournaments, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField COLOR = QueryField(fieldName: "color");
  static final QueryField LOGO = QueryField(fieldName: "logo");
  static final QueryField EVENT = QueryField(fieldName: "event");
  static final QueryField IMAGES = QueryField(fieldName: "images");
  static final QueryField PLAYERS = QueryField(fieldName: "players");
  static final QueryField EVENTS = QueryField(fieldName: "events");
  static final QueryField LEAGUES = QueryField(fieldName: "leagues");
  static final QueryField TOURNAMENTS = QueryField(fieldName: "tournaments");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Team";
    modelSchemaDefinition.pluralName = "Teams";
    
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
      key: Team.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Team.COLOR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Team.LOGO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Team.EVENT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Team.IMAGES,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Team.PLAYERS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Team.EVENTS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Team.LEAGUES,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Team.TOURNAMENTS,
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

class _TeamModelType extends ModelType<Team> {
  const _TeamModelType();
  
  @override
  Team fromJson(Map<String, dynamic> jsonData) {
    return Team.fromJson(jsonData);
  }
}