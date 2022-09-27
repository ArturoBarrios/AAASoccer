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


/** This is an auto generated class representing the Location type in your schema. */
@immutable
class Location extends Model {
  static const classType = const _LocationModelType();
  final String id;
  final String? _name;
  final String? _secondaryName;
  final String? _address;
  final SurfaceType? _surface;
  final String? _images;
  final FieldPlayerOccupancySize? _fieldSize;
  final bool? _private;
  final String? _schedule;
  final double? _latitude;
  final double? _longitude;
  final List<Event>? _events;
  final String? _userID;
  final User? _user;
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
  
  SurfaceType? get surface {
    return _surface;
  }
  
  String? get images {
    return _images;
  }
  
  FieldPlayerOccupancySize? get fieldSize {
    return _fieldSize;
  }
  
  bool? get private {
    return _private;
  }
  
  String? get schedule {
    return _schedule;
  }
  
  double? get latitude {
    return _latitude;
  }
  
  double? get longitude {
    return _longitude;
  }
  
  List<Event>? get events {
    return _events;
  }
  
  String get userID {
    try {
      return _userID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
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
  
  const Location._internal({required this.id, name, secondaryName, address, surface, images, fieldSize, private, schedule, latitude, longitude, events, required userID, user, createdAt, updatedAt}): _name = name, _secondaryName = secondaryName, _address = address, _surface = surface, _images = images, _fieldSize = fieldSize, _private = private, _schedule = schedule, _latitude = latitude, _longitude = longitude, _events = events, _userID = userID, _user = user, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Location({String? id, String? name, String? secondaryName, String? address, SurfaceType? surface, String? images, FieldPlayerOccupancySize? fieldSize, bool? private, String? schedule, double? latitude, double? longitude, List<Event>? events, required String userID, User? user}) {
    return Location._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      secondaryName: secondaryName,
      address: address,
      surface: surface,
      images: images,
      fieldSize: fieldSize,
      private: private,
      schedule: schedule,
      latitude: latitude,
      longitude: longitude,
      events: events != null ? List<Event>.unmodifiable(events) : events,
      userID: userID,
      user: user);
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
      _private == other._private &&
      _schedule == other._schedule &&
      _latitude == other._latitude &&
      _longitude == other._longitude &&
      DeepCollectionEquality().equals(_events, other._events) &&
      _userID == other._userID &&
      _user == other._user;
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
    buffer.write("surface=" + (_surface != null ? enumToString(_surface)! : "null") + ", ");
    buffer.write("images=" + "$_images" + ", ");
    buffer.write("fieldSize=" + (_fieldSize != null ? enumToString(_fieldSize)! : "null") + ", ");
    buffer.write("private=" + (_private != null ? _private!.toString() : "null") + ", ");
    buffer.write("schedule=" + "$_schedule" + ", ");
    buffer.write("latitude=" + (_latitude != null ? _latitude!.toString() : "null") + ", ");
    buffer.write("longitude=" + (_longitude != null ? _longitude!.toString() : "null") + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Location copyWith({String? id, String? name, String? secondaryName, String? address, SurfaceType? surface, String? images, FieldPlayerOccupancySize? fieldSize, bool? private, String? schedule, double? latitude, double? longitude, List<Event>? events, String? userID, User? user}) {
    return Location._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      secondaryName: secondaryName ?? this.secondaryName,
      address: address ?? this.address,
      surface: surface ?? this.surface,
      images: images ?? this.images,
      fieldSize: fieldSize ?? this.fieldSize,
      private: private ?? this.private,
      schedule: schedule ?? this.schedule,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      events: events ?? this.events,
      userID: userID ?? this.userID,
      user: user ?? this.user);
  }
  
  Location.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _secondaryName = json['secondaryName'],
      _address = json['address'],
      _surface = enumFromString<SurfaceType>(json['surface'], SurfaceType.values),
      _images = json['images'],
      _fieldSize = enumFromString<FieldPlayerOccupancySize>(json['fieldSize'], FieldPlayerOccupancySize.values),
      _private = json['private'],
      _schedule = json['schedule'],
      _latitude = (json['latitude'] as num?)?.toDouble(),
      _longitude = (json['longitude'] as num?)?.toDouble(),
      _events = json['events'] is List
        ? (json['events'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Event.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _userID = json['userID'],
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'secondaryName': _secondaryName, 'address': _address, 'surface': enumToString(_surface), 'images': _images, 'fieldSize': enumToString(_fieldSize), 'private': _private, 'schedule': _schedule, 'latitude': _latitude, 'longitude': _longitude, 'events': _events?.map((Event? e) => e?.toJson()).toList(), 'userID': _userID, 'user': _user?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField SECONDARYNAME = QueryField(fieldName: "secondaryName");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField SURFACE = QueryField(fieldName: "surface");
  static final QueryField IMAGES = QueryField(fieldName: "images");
  static final QueryField FIELDSIZE = QueryField(fieldName: "fieldSize");
  static final QueryField PRIVATE = QueryField(fieldName: "private");
  static final QueryField SCHEDULE = QueryField(fieldName: "schedule");
  static final QueryField LATITUDE = QueryField(fieldName: "latitude");
  static final QueryField LONGITUDE = QueryField(fieldName: "longitude");
  static final QueryField EVENTS = QueryField(
    fieldName: "events",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Event).toString()));
  static final QueryField USERID = QueryField(fieldName: "userID");
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
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
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.IMAGES,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.FIELDSIZE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.PRIVATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.SCHEDULE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.LATITUDE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.LONGITUDE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Location.EVENTS,
      isRequired: false,
      ofModelName: (Event).toString(),
      associatedKey: Event.LOCATIONID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Location.USERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Location.USER,
      isRequired: false,
      targetName: "userLocationsId",
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

class _LocationModelType extends ModelType<Location> {
  const _LocationModelType();
  
  @override
  Location fromJson(Map<String, dynamic> jsonData) {
    return Location.fromJson(jsonData);
  }
}