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


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final Player? _Player;
  final Organizer? _Organizer;
  final Coach? _Coach;
  final Referee? _Referee;
  final String? _name;
  final String? _phone;
  final String? _email;
  final String? _username;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _userPlayerId;
  final String? _userOrganizerId;
  final String? _userCoachId;
  final String? _userRefereeId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  Player? get Player {
    return _Player;
  }
  
  Organizer? get Organizer {
    return _Organizer;
  }
  
  Coach? get Coach {
    return _Coach;
  }
  
  Referee? get Referee {
    return _Referee;
  }
  
  String? get name {
    return _name;
  }
  
  String? get phone {
    return _phone;
  }
  
  String? get email {
    return _email;
  }
  
  String? get username {
    return _username;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get userPlayerId {
    return _userPlayerId;
  }
  
  String? get userOrganizerId {
    return _userOrganizerId;
  }
  
  String? get userCoachId {
    return _userCoachId;
  }
  
  String? get userRefereeId {
    return _userRefereeId;
  }
  
  const User._internal({required this.id, Player, Organizer, Coach, Referee, name, phone, email, username, createdAt, updatedAt, userPlayerId, userOrganizerId, userCoachId, userRefereeId}): _Player = Player, _Organizer = Organizer, _Coach = Coach, _Referee = Referee, _name = name, _phone = phone, _email = email, _username = username, _createdAt = createdAt, _updatedAt = updatedAt, _userPlayerId = userPlayerId, _userOrganizerId = userOrganizerId, _userCoachId = userCoachId, _userRefereeId = userRefereeId;
  
  factory User({String? id, Player? Player, Organizer? Organizer, Coach? Coach, Referee? Referee, String? name, String? phone, String? email, String? username, String? userPlayerId, String? userOrganizerId, String? userCoachId, String? userRefereeId}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      Player: Player,
      Organizer: Organizer,
      Coach: Coach,
      Referee: Referee,
      name: name,
      phone: phone,
      email: email,
      username: username,
      userPlayerId: userPlayerId,
      userOrganizerId: userOrganizerId,
      userCoachId: userCoachId,
      userRefereeId: userRefereeId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _Player == other._Player &&
      _Organizer == other._Organizer &&
      _Coach == other._Coach &&
      _Referee == other._Referee &&
      _name == other._name &&
      _phone == other._phone &&
      _email == other._email &&
      _username == other._username &&
      _userPlayerId == other._userPlayerId &&
      _userOrganizerId == other._userOrganizerId &&
      _userCoachId == other._userCoachId &&
      _userRefereeId == other._userRefereeId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("phone=" + "$_phone" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("userPlayerId=" + "$_userPlayerId" + ", ");
    buffer.write("userOrganizerId=" + "$_userOrganizerId" + ", ");
    buffer.write("userCoachId=" + "$_userCoachId" + ", ");
    buffer.write("userRefereeId=" + "$_userRefereeId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? id, Player? Player, Organizer? Organizer, Coach? Coach, Referee? Referee, String? name, String? phone, String? email, String? username, String? userPlayerId, String? userOrganizerId, String? userCoachId, String? userRefereeId}) {
    return User._internal(
      id: id ?? this.id,
      Player: Player ?? this.Player,
      Organizer: Organizer ?? this.Organizer,
      Coach: Coach ?? this.Coach,
      Referee: Referee ?? this.Referee,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      username: username ?? this.username,
      userPlayerId: userPlayerId ?? this.userPlayerId,
      userOrganizerId: userOrganizerId ?? this.userOrganizerId,
      userCoachId: userCoachId ?? this.userCoachId,
      userRefereeId: userRefereeId ?? this.userRefereeId);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _Player = json['Player']?['serializedData'] != null
        ? Player.fromJson(new Map<String, dynamic>.from(json['Player']['serializedData']))
        : null,
      _Organizer = json['Organizer']?['serializedData'] != null
        ? Organizer.fromJson(new Map<String, dynamic>.from(json['Organizer']['serializedData']))
        : null,
      _Coach = json['Coach']?['serializedData'] != null
        ? Coach.fromJson(new Map<String, dynamic>.from(json['Coach']['serializedData']))
        : null,
      _Referee = json['Referee']?['serializedData'] != null
        ? Referee.fromJson(new Map<String, dynamic>.from(json['Referee']['serializedData']))
        : null,
      _name = json['name'],
      _phone = json['phone'],
      _email = json['email'],
      _username = json['username'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _userPlayerId = json['userPlayerId'],
      _userOrganizerId = json['userOrganizerId'],
      _userCoachId = json['userCoachId'],
      _userRefereeId = json['userRefereeId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'Player': _Player?.toJson(), 'Organizer': _Organizer?.toJson(), 'Coach': _Coach?.toJson(), 'Referee': _Referee?.toJson(), 'name': _name, 'phone': _phone, 'email': _email, 'username': _username, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'userPlayerId': _userPlayerId, 'userOrganizerId': _userOrganizerId, 'userCoachId': _userCoachId, 'userRefereeId': _userRefereeId
  };

  static final QueryField ID = QueryField(fieldName: "user.id");
  static final QueryField PLAYER = QueryField(
    fieldName: "Player",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Player).toString()));
  static final QueryField ORGANIZER = QueryField(
    fieldName: "Organizer",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Organizer).toString()));
  static final QueryField COACH = QueryField(
    fieldName: "Coach",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Coach).toString()));
  static final QueryField REFEREE = QueryField(
    fieldName: "Referee",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Referee).toString()));
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField PHONE = QueryField(fieldName: "phone");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField USERPLAYERID = QueryField(fieldName: "userPlayerId");
  static final QueryField USERORGANIZERID = QueryField(fieldName: "userOrganizerId");
  static final QueryField USERCOACHID = QueryField(fieldName: "userCoachId");
  static final QueryField USERREFEREEID = QueryField(fieldName: "userRefereeId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: User.PLAYER,
      isRequired: false,
      ofModelName: (Player).toString(),
      associatedKey: Player.USER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: User.ORGANIZER,
      isRequired: false,
      ofModelName: (Organizer).toString(),
      associatedKey: Organizer.USER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: User.COACH,
      isRequired: false,
      ofModelName: (Coach).toString(),
      associatedKey: Coach.USER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: User.REFEREE,
      isRequired: false,
      ofModelName: (Referee).toString(),
      associatedKey: Referee.USER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PHONE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.USERNAME,
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.USERPLAYERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.USERORGANIZERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.USERCOACHID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.USERREFEREEID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}