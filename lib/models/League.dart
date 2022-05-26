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
  final String? _events;
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
  
  String? get events {
    return _events;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const League._internal({required this.id, name, tournament, teams, wagers, images, events, createdAt, updatedAt}): _name = name, _tournament = tournament, _teams = teams, _wagers = wagers, _images = images, _events = events, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory League({String? id, String? name, String? tournament, String? teams, String? wagers, String? images, String? events}) {
    return League._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      tournament: tournament,
      teams: teams,
      wagers: wagers,
      images: images,
      events: events);
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
      _events == other._events;
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
    buffer.write("events=" + "$_events" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  League copyWith({String? id, String? name, String? tournament, String? teams, String? wagers, String? images, String? events}) {
    return League._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      tournament: tournament ?? this.tournament,
      teams: teams ?? this.teams,
      wagers: wagers ?? this.wagers,
      images: images ?? this.images,
      events: events ?? this.events);
  }
  
  League.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _tournament = json['tournament'],
      _teams = json['teams'],
      _wagers = json['wagers'],
      _images = json['images'],
      _events = json['events'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'tournament': _tournament, 'teams': _teams, 'wagers': _wagers, 'images': _images, 'events': _events, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "league.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField TOURNAMENT = QueryField(fieldName: "tournament");
  static final QueryField TEAMS = QueryField(fieldName: "teams");
  static final QueryField WAGERS = QueryField(fieldName: "wagers");
  static final QueryField IMAGES = QueryField(fieldName: "images");
  static final QueryField EVENTS = QueryField(fieldName: "events");
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: League.EVENTS,
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

class _LeagueModelType extends ModelType<League> {
  const _LeagueModelType();
  
  @override
  League fromJson(Map<String, dynamic> jsonData) {
    return League.fromJson(jsonData);
  }
}