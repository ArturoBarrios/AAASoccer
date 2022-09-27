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


/** This is an auto generated class representing the Organization type in your schema. */
@immutable
class Organization extends Model {
  static const classType = const _OrganizationModelType();
  final String id;
  final String? _name;
  final String? _images;
  final String? _rating;
  final String? _events;
  final String? _description;
  final String? _ageRange;
  final bool? _inviteOnly;
  final String? _members;
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
  
  String? get images {
    return _images;
  }
  
  String? get rating {
    return _rating;
  }
  
  String? get events {
    return _events;
  }
  
  String? get description {
    return _description;
  }
  
  String? get ageRange {
    return _ageRange;
  }
  
  bool? get inviteOnly {
    return _inviteOnly;
  }
  
  String? get members {
    return _members;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Organization._internal({required this.id, name, images, rating, events, description, ageRange, inviteOnly, members, createdAt, updatedAt}): _name = name, _images = images, _rating = rating, _events = events, _description = description, _ageRange = ageRange, _inviteOnly = inviteOnly, _members = members, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Organization({String? id, String? name, String? images, String? rating, String? events, String? description, String? ageRange, bool? inviteOnly, String? members}) {
    return Organization._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      images: images,
      rating: rating,
      events: events,
      description: description,
      ageRange: ageRange,
      inviteOnly: inviteOnly,
      members: members);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Organization &&
      id == other.id &&
      _name == other._name &&
      _images == other._images &&
      _rating == other._rating &&
      _events == other._events &&
      _description == other._description &&
      _ageRange == other._ageRange &&
      _inviteOnly == other._inviteOnly &&
      _members == other._members;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Organization {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("images=" + "$_images" + ", ");
    buffer.write("rating=" + "$_rating" + ", ");
    buffer.write("events=" + "$_events" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("ageRange=" + "$_ageRange" + ", ");
    buffer.write("inviteOnly=" + (_inviteOnly != null ? _inviteOnly!.toString() : "null") + ", ");
    buffer.write("members=" + "$_members" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Organization copyWith({String? id, String? name, String? images, String? rating, String? events, String? description, String? ageRange, bool? inviteOnly, String? members}) {
    return Organization._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      images: images ?? this.images,
      rating: rating ?? this.rating,
      events: events ?? this.events,
      description: description ?? this.description,
      ageRange: ageRange ?? this.ageRange,
      inviteOnly: inviteOnly ?? this.inviteOnly,
      members: members ?? this.members);
  }
  
  Organization.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _images = json['images'],
      _rating = json['rating'],
      _events = json['events'],
      _description = json['description'],
      _ageRange = json['ageRange'],
      _inviteOnly = json['inviteOnly'],
      _members = json['members'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'images': _images, 'rating': _rating, 'events': _events, 'description': _description, 'ageRange': _ageRange, 'inviteOnly': _inviteOnly, 'members': _members, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField IMAGES = QueryField(fieldName: "images");
  static final QueryField RATING = QueryField(fieldName: "rating");
  static final QueryField EVENTS = QueryField(fieldName: "events");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField AGERANGE = QueryField(fieldName: "ageRange");
  static final QueryField INVITEONLY = QueryField(fieldName: "inviteOnly");
  static final QueryField MEMBERS = QueryField(fieldName: "members");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Organization";
    modelSchemaDefinition.pluralName = "Organizations";
    
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
      key: Organization.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Organization.IMAGES,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Organization.RATING,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Organization.EVENTS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Organization.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Organization.AGERANGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Organization.INVITEONLY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Organization.MEMBERS,
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

class _OrganizationModelType extends ModelType<Organization> {
  const _OrganizationModelType();
  
  @override
  Organization fromJson(Map<String, dynamic> jsonData) {
    return Organization.fromJson(jsonData);
  }
}