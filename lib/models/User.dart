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


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final Player? _player;
  final Organizer? _organizer;
  final Coach? _coach;
  final Referee? _referee;
  final String? _name;
  final String? _phone;
  final String? _email;
  final String? _username;
  final String? _birthdate;
  final String? _gender;
  final String? _address;
  final String? _status;
  final int? _last_login;
  final int? _last_updated;
  final String? _locationID;
  final List<Location>? _locations;
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
  
  Player? get player {
    return _player;
  }
  
  Organizer? get organizer {
    return _organizer;
  }
  
  Coach? get coach {
    return _coach;
  }
  
  Referee? get referee {
    return _referee;
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
  
  String? get birthdate {
    return _birthdate;
  }
  
  String? get gender {
    return _gender;
  }
  
  String? get address {
    return _address;
  }
  
  String? get status {
    return _status;
  }
  
  int? get last_login {
    return _last_login;
  }
  
  int? get last_updated {
    return _last_updated;
  }
  
  String get locationID {
    try {
      return _locationID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<Location>? get locations {
    return _locations;
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
  
  const User._internal({required this.id, player, organizer, coach, referee, name, phone, email, username, birthdate, gender, address, status, last_login, last_updated, required locationID, locations, createdAt, updatedAt, userPlayerId, userOrganizerId, userCoachId, userRefereeId}): _player = player, _organizer = organizer, _coach = coach, _referee = referee, _name = name, _phone = phone, _email = email, _username = username, _birthdate = birthdate, _gender = gender, _address = address, _status = status, _last_login = last_login, _last_updated = last_updated, _locationID = locationID, _locations = locations, _createdAt = createdAt, _updatedAt = updatedAt, _userPlayerId = userPlayerId, _userOrganizerId = userOrganizerId, _userCoachId = userCoachId, _userRefereeId = userRefereeId;
  
  factory User({String? id, Player? player, Organizer? organizer, Coach? coach, Referee? referee, String? name, String? phone, String? email, String? username, String? birthdate, String? gender, String? address, String? status, int? last_login, int? last_updated, required String locationID, List<Location>? locations, String? userPlayerId, String? userOrganizerId, String? userCoachId, String? userRefereeId}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      player: player,
      organizer: organizer,
      coach: coach,
      referee: referee,
      name: name,
      phone: phone,
      email: email,
      username: username,
      birthdate: birthdate,
      gender: gender,
      address: address,
      status: status,
      last_login: last_login,
      last_updated: last_updated,
      locationID: locationID,
      locations: locations != null ? List<Location>.unmodifiable(locations) : locations,
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
      _player == other._player &&
      _organizer == other._organizer &&
      _coach == other._coach &&
      _referee == other._referee &&
      _name == other._name &&
      _phone == other._phone &&
      _email == other._email &&
      _username == other._username &&
      _birthdate == other._birthdate &&
      _gender == other._gender &&
      _address == other._address &&
      _status == other._status &&
      _last_login == other._last_login &&
      _last_updated == other._last_updated &&
      _locationID == other._locationID &&
      DeepCollectionEquality().equals(_locations, other._locations) &&
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
    buffer.write("birthdate=" + "$_birthdate" + ", ");
    buffer.write("gender=" + "$_gender" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("status=" + "$_status" + ", ");
    buffer.write("last_login=" + (_last_login != null ? _last_login!.toString() : "null") + ", ");
    buffer.write("last_updated=" + (_last_updated != null ? _last_updated!.toString() : "null") + ", ");
    buffer.write("locationID=" + "$_locationID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("userPlayerId=" + "$_userPlayerId" + ", ");
    buffer.write("userOrganizerId=" + "$_userOrganizerId" + ", ");
    buffer.write("userCoachId=" + "$_userCoachId" + ", ");
    buffer.write("userRefereeId=" + "$_userRefereeId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? id, Player? player, Organizer? organizer, Coach? coach, Referee? referee, String? name, String? phone, String? email, String? username, String? birthdate, String? gender, String? address, String? status, int? last_login, int? last_updated, String? locationID, List<Location>? locations, String? userPlayerId, String? userOrganizerId, String? userCoachId, String? userRefereeId}) {
    return User._internal(
      id: id ?? this.id,
      player: player ?? this.player,
      organizer: organizer ?? this.organizer,
      coach: coach ?? this.coach,
      referee: referee ?? this.referee,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      username: username ?? this.username,
      birthdate: birthdate ?? this.birthdate,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      status: status ?? this.status,
      last_login: last_login ?? this.last_login,
      last_updated: last_updated ?? this.last_updated,
      locationID: locationID ?? this.locationID,
      locations: locations ?? this.locations,
      userPlayerId: userPlayerId ?? this.userPlayerId,
      userOrganizerId: userOrganizerId ?? this.userOrganizerId,
      userCoachId: userCoachId ?? this.userCoachId,
      userRefereeId: userRefereeId ?? this.userRefereeId);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _player = json['player']?['serializedData'] != null
        ? Player.fromJson(new Map<String, dynamic>.from(json['player']['serializedData']))
        : null,
      _organizer = json['organizer']?['serializedData'] != null
        ? Organizer.fromJson(new Map<String, dynamic>.from(json['organizer']['serializedData']))
        : null,
      _coach = json['coach']?['serializedData'] != null
        ? Coach.fromJson(new Map<String, dynamic>.from(json['coach']['serializedData']))
        : null,
      _referee = json['referee']?['serializedData'] != null
        ? Referee.fromJson(new Map<String, dynamic>.from(json['referee']['serializedData']))
        : null,
      _name = json['name'],
      _phone = json['phone'],
      _email = json['email'],
      _username = json['username'],
      _birthdate = json['birthdate'],
      _gender = json['gender'],
      _address = json['address'],
      _status = json['status'],
      _last_login = (json['last_login'] as num?)?.toInt(),
      _last_updated = (json['last_updated'] as num?)?.toInt(),
      _locationID = json['locationID'],
      _locations = json['locations'] is List
        ? (json['locations'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Location.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _userPlayerId = json['userPlayerId'],
      _userOrganizerId = json['userOrganizerId'],
      _userCoachId = json['userCoachId'],
      _userRefereeId = json['userRefereeId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'player': _player?.toJson(), 'organizer': _organizer?.toJson(), 'coach': _coach?.toJson(), 'referee': _referee?.toJson(), 'name': _name, 'phone': _phone, 'email': _email, 'username': _username, 'birthdate': _birthdate, 'gender': _gender, 'address': _address, 'status': _status, 'last_login': _last_login, 'last_updated': _last_updated, 'locationID': _locationID, 'locations': _locations?.map((Location? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'userPlayerId': _userPlayerId, 'userOrganizerId': _userOrganizerId, 'userCoachId': _userCoachId, 'userRefereeId': _userRefereeId
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField PLAYER = QueryField(
    fieldName: "player",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Player).toString()));
  static final QueryField ORGANIZER = QueryField(
    fieldName: "organizer",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Organizer).toString()));
  static final QueryField COACH = QueryField(
    fieldName: "coach",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Coach).toString()));
  static final QueryField REFEREE = QueryField(
    fieldName: "referee",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Referee).toString()));
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField PHONE = QueryField(fieldName: "phone");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField BIRTHDATE = QueryField(fieldName: "birthdate");
  static final QueryField GENDER = QueryField(fieldName: "gender");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField LAST_LOGIN = QueryField(fieldName: "last_login");
  static final QueryField LAST_UPDATED = QueryField(fieldName: "last_updated");
  static final QueryField LOCATIONID = QueryField(fieldName: "locationID");
  static final QueryField LOCATIONS = QueryField(
    fieldName: "locations",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Location).toString()));
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.BIRTHDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.GENDER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ADDRESS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.STATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.LAST_LOGIN,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.LAST_UPDATED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.LOCATIONID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.LOCATIONS,
      isRequired: false,
      ofModelName: (Location).toString(),
      associatedKey: Location.USERID
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