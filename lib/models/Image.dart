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


/** This is an auto generated class representing the Image type in your schema. */
@immutable
class Image extends Model {
  static const classType = const _ImageModelType();
  final String id;
  final String? _url;
  final String? _players;
  final String? _tournaments;
  final String? _leagues;
  final String? _events;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get url {
    return _url;
  }
  
  String? get players {
    return _players;
  }
  
  String? get tournaments {
    return _tournaments;
  }
  
  String? get leagues {
    return _leagues;
  }
  
  String? get events {
    return _events;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Image._internal({required this.id, url, players, tournaments, leagues, events, createdAt, updatedAt}): _url = url, _players = players, _tournaments = tournaments, _leagues = leagues, _events = events, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Image({String? id, String? url, String? players, String? tournaments, String? leagues, String? events}) {
    return Image._internal(
      id: id == null ? UUID.getUUID() : id,
      url: url,
      players: players,
      tournaments: tournaments,
      leagues: leagues,
      events: events);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Image &&
      id == other.id &&
      _url == other._url &&
      _players == other._players &&
      _tournaments == other._tournaments &&
      _leagues == other._leagues &&
      _events == other._events;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Image {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("url=" + "$_url" + ", ");
    buffer.write("players=" + "$_players" + ", ");
    buffer.write("tournaments=" + "$_tournaments" + ", ");
    buffer.write("leagues=" + "$_leagues" + ", ");
    buffer.write("events=" + "$_events" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Image copyWith({String? id, String? url, String? players, String? tournaments, String? leagues, String? events}) {
    return Image._internal(
      id: id ?? this.id,
      url: url ?? this.url,
      players: players ?? this.players,
      tournaments: tournaments ?? this.tournaments,
      leagues: leagues ?? this.leagues,
      events: events ?? this.events);
  }
  
  Image.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _url = json['url'],
      _players = json['players'],
      _tournaments = json['tournaments'],
      _leagues = json['leagues'],
      _events = json['events'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'url': _url, 'players': _players, 'tournaments': _tournaments, 'leagues': _leagues, 'events': _events, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "image.id");
  static final QueryField URL = QueryField(fieldName: "url");
  static final QueryField PLAYERS = QueryField(fieldName: "players");
  static final QueryField TOURNAMENTS = QueryField(fieldName: "tournaments");
  static final QueryField LEAGUES = QueryField(fieldName: "leagues");
  static final QueryField EVENTS = QueryField(fieldName: "events");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Image";
    modelSchemaDefinition.pluralName = "Images";
    
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
      key: Image.URL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Image.PLAYERS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Image.TOURNAMENTS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Image.LEAGUES,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Image.EVENTS,
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

class _ImageModelType extends ModelType<Image> {
  const _ImageModelType();
  
  @override
  Image fromJson(Map<String, dynamic> jsonData) {
    return Image.fromJson(jsonData);
  }
}