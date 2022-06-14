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


/** This is an auto generated class representing the Event type in your schema. */
@immutable
class Event extends Model {
  static const classType = const _EventModelType();
  final String id;
  final String? _name;
  final String? _organizer;
  final String? _game;
  final String? _tryout;
  final String? _training;
  final String? _ratings;
  final String? _images;
  final String? _price;
  final String? _location;
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
  
  String? get organizer {
    return _organizer;
  }
  
  String? get game {
    return _game;
  }
  
  String? get tryout {
    return _tryout;
  }
  
  String? get training {
    return _training;
  }
  
  String? get ratings {
    return _ratings;
  }
  
  String? get images {
    return _images;
  }
  
  String? get price {
    return _price;
  }
  
  String? get location {
    return _location;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Event._internal({required this.id, name, organizer, game, tryout, training, ratings, images, price, location, createdAt, updatedAt}): _name = name, _organizer = organizer, _game = game, _tryout = tryout, _training = training, _ratings = ratings, _images = images, _price = price, _location = location, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Event({String? id, String? name, String? organizer, String? game, String? tryout, String? training, String? ratings, String? images, String? price, String? location}) {
    return Event._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      organizer: organizer,
      game: game,
      tryout: tryout,
      training: training,
      ratings: ratings,
      images: images,
      price: price,
      location: location);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Event &&
      id == other.id &&
      _name == other._name &&
      _organizer == other._organizer &&
      _game == other._game &&
      _tryout == other._tryout &&
      _training == other._training &&
      _ratings == other._ratings &&
      _images == other._images &&
      _price == other._price &&
      _location == other._location;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Event {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("organizer=" + "$_organizer" + ", ");
    buffer.write("game=" + "$_game" + ", ");
    buffer.write("tryout=" + "$_tryout" + ", ");
    buffer.write("training=" + "$_training" + ", ");
    buffer.write("ratings=" + "$_ratings" + ", ");
    buffer.write("images=" + "$_images" + ", ");
    buffer.write("price=" + "$_price" + ", ");
    buffer.write("location=" + "$_location" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Event copyWith({String? id, String? name, String? organizer, String? game, String? tryout, String? training, String? ratings, String? images, String? price, String? location}) {
    return Event._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      organizer: organizer ?? this.organizer,
      game: game ?? this.game,
      tryout: tryout ?? this.tryout,
      training: training ?? this.training,
      ratings: ratings ?? this.ratings,
      images: images ?? this.images,
      price: price ?? this.price,
      location: location ?? this.location);
  }
  
  Event.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _organizer = json['organizer'],
      _game = json['game'],
      _tryout = json['tryout'],
      _training = json['training'],
      _ratings = json['ratings'],
      _images = json['images'],
      _price = json['price'],
      _location = json['location'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'organizer': _organizer, 'game': _game, 'tryout': _tryout, 'training': _training, 'ratings': _ratings, 'images': _images, 'price': _price, 'location': _location, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "event.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField ORGANIZER = QueryField(fieldName: "organizer");
  static final QueryField GAME = QueryField(fieldName: "game");
  static final QueryField TRYOUT = QueryField(fieldName: "tryout");
  static final QueryField TRAINING = QueryField(fieldName: "training");
  static final QueryField RATINGS = QueryField(fieldName: "ratings");
  static final QueryField IMAGES = QueryField(fieldName: "images");
  static final QueryField PRICE = QueryField(fieldName: "price");
  static final QueryField LOCATION = QueryField(fieldName: "location");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Event";
    modelSchemaDefinition.pluralName = "Events";
    
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
      key: Event.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.ORGANIZER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.GAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.TRYOUT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.TRAINING,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.RATINGS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.IMAGES,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.PRICE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Event.LOCATION,
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

class _EventModelType extends ModelType<Event> {
  const _EventModelType();
  
  @override
  Event fromJson(Map<String, dynamic> jsonData) {
    return Event.fromJson(jsonData);
  }
}