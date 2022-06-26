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


/** This is an auto generated class representing the LeagueEvent type in your schema. */
@immutable
class LeagueEvent extends Model {
  static const classType = const _LeagueEventModelType();
  final String id;
  final Event? _event;
  final League? _league;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  Event get event {
    try {
      return _event!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  League get league {
    try {
      return _league!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const LeagueEvent._internal({required this.id, required event, required league, createdAt, updatedAt}): _event = event, _league = league, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory LeagueEvent({String? id, required Event event, required League league}) {
    return LeagueEvent._internal(
      id: id == null ? UUID.getUUID() : id,
      event: event,
      league: league);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LeagueEvent &&
      id == other.id &&
      _event == other._event &&
      _league == other._league;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("LeagueEvent {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("event=" + (_event != null ? _event!.toString() : "null") + ", ");
    buffer.write("league=" + (_league != null ? _league!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  LeagueEvent copyWith({String? id, Event? event, League? league}) {
    return LeagueEvent._internal(
      id: id ?? this.id,
      event: event ?? this.event,
      league: league ?? this.league);
  }
  
  LeagueEvent.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _event = json['event']?['serializedData'] != null
        ? Event.fromJson(new Map<String, dynamic>.from(json['event']['serializedData']))
        : null,
      _league = json['league']?['serializedData'] != null
        ? League.fromJson(new Map<String, dynamic>.from(json['league']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'event': _event?.toJson(), 'league': _league?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "leagueEvent.id");
  static final QueryField EVENT = QueryField(
    fieldName: "event",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Event).toString()));
  static final QueryField LEAGUE = QueryField(
    fieldName: "league",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (League).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "LeagueEvent";
    modelSchemaDefinition.pluralName = "LeagueEvents";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: LeagueEvent.EVENT,
      isRequired: true,
      targetName: "eventID",
      ofModelName: (Event).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: LeagueEvent.LEAGUE,
      isRequired: true,
      targetName: "leagueID",
      ofModelName: (League).toString()
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

class _LeagueEventModelType extends ModelType<LeagueEvent> {
  const _LeagueEventModelType();
  
  @override
  LeagueEvent fromJson(Map<String, dynamic> jsonData) {
    return LeagueEvent.fromJson(jsonData);
  }
}