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


/** This is an auto generated class representing the Location type in your schema. */
@immutable
class Location extends Model {
  static const classType = const _LocationModelType();
  final String id;
  final String? _name;
  final String? _secondaryName;
  final String? _address;
  final String? _surface;
  final String? _images;
  final String? _fieldSize;
  final String? _games;
  final String? _private;
  final String? _schedule;
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
  
  String? get secondaryName {
    return _secondaryName;
  }
  
  String? get address {
    return _address;
  }
  
  String? get surface {
    return _surface;
  }
  
  String? get images {
    return _images;
  }
  
  String? get fieldSize {
    return _fieldSize;
  }
  
  String? get games {
    return _games;
  }
  
  String? get private {
    return _private;
  }
  
  String? get schedule {
    return _schedule;
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
  
  const Location._internal({required this.id, name, secondaryName, address, surface, images, fieldSize, games, private, schedule, events, createdAt, updatedAt}): _name = name, _secondaryName = secondaryName, _address = address, _surface = surface, _images = images, _fieldSize = fieldSize, _games = games, _private = private, _schedule = schedule, _events = events, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Location({String? id, String? name, String? secondaryName, String? address, String? surface, String? images, String? fieldSize, String? games, String? private, String? schedule, String? events}) {
    return Location._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      secondaryName: secondaryName,
      address: address,
      surface: surface,
      images: images,
      fieldSize: fieldSize,
      games: games,
      private: private,
      schedule: schedule,
      events: events);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Location &&
      id == other.id &&
      _name == other._name &&
      _secondaryName == other._secondaryName &&
      _address == other._address &&
      _surface == other._surface &&
      _images == other._images &&
      _fieldSize == other._fieldSize &&
      _games == other._games &&
      _private == other._private &&
      _schedule == other._schedule &&
      _events == other._events;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Location {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("secondaryName=" + "$_secondaryName" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("surface=" + "$_surface" + ", ");
    buffer.write("images=" + "$_images" + ", ");
    buffer.write("fieldSize=" + "$_fieldSize" + ", ");
    buffer.write("games=" + "$_games" + ", ");
    buffer.write("private=" + "$_private" + ", ");
    buffer.write("schedule=" + "$_schedule" + ", ");
    buffer.write("events=" + "$_events" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Location copyWith({String? id, String? name, String? secondaryName, String? address, String? surface, String? images, String? fieldSize, String? games, String? private, String? schedule, String? events}) {
    return Location._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      secondaryName: secondaryName ?? this.secondaryName,
      address: address ?? this.address,
      surface: surface ?? this.surface,
      images: images ?? this.images,
      fieldSize: fieldSize ?? this.fieldSize,
      games: games ?? this.games,
      private: private ?? this.private,
      schedule: schedule ?? this.schedule,
      events: events ?? this.events);
  }
  
  Location.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _secondaryName = json['secondaryName'],
      _address = json['address'],
      _surface = json['surface'],
      _images = json['images'],
      _fieldSize = json['fieldSize'],
      _games = json['games'],
      _private = json['private'],
      _schedule = json['schedule'],
      _events = json['events'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'secondaryName': _secondaryName, 'address': _address, 'surface': _surface, 'images': _images, 'fieldSize': _fieldSize, 'games': _games, 'private': _private, 'schedule': _schedule, 'events': _events, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "location.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField SECONDARYNAME = QueryField(fieldName: "secondaryName");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField SURFACE = QueryField(fieldName: "surface");
  static final QueryField IMAGES = QueryField(fieldName: "images");
  static final QueryField FIELDSIZE = QueryField(fieldName: "fieldSize");
  static final QueryField GAMES = QueryField(fieldName: "games");
  static final QueryField PRIVATE = QueryField(fieldName: "private");
  static final QueryField SCHEDULE = QueryField(fieldName: "schedule");
  static final QueryField EVENTS = QueryField(fieldName: "events");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Location";
    modelSchemaDefinition.pluralName = "Locations";
    
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
      key: Location.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.SECONDARYNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.ADDRESS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.SURFACE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.IMAGES,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.FIELDSIZE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.GAMES,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.PRIVATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.SCHEDULE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.EVENTS,
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

class _LocationModelType extends ModelType<Location> {
  const _LocationModelType();
  
  @override
  Location fromJson(Map<String, dynamic> jsonData) {
    return Location.fromJson(jsonData);
  }
}