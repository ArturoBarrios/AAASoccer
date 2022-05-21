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
import 'AppSubscription.dart';
import 'Chat.dart';
import 'Coach.dart';
import 'Event.dart';
import 'Game.dart';
import 'GifContent.dart';
import 'Image.dart';
import 'League.dart';
import 'Location.dart';
import 'Message.dart';
import 'Organization.dart';
import 'Organizer.dart';
import 'Payment.dart';
import 'Player.dart';
import 'Rating.dart';
import 'Referee.dart';
import 'Team.dart';
import 'TextContent.dart';
import 'Tournament.dart';
import 'Training.dart';
import 'Tryout.dart';
import 'User.dart';
import 'Wager.dart';

export 'AppSubscription.dart';
export 'Chat.dart';
export 'Coach.dart';
export 'Event.dart';
export 'Game.dart';
export 'GifContent.dart';
export 'Image.dart';
export 'League.dart';
export 'Location.dart';
export 'Message.dart';
export 'Organization.dart';
export 'Organizer.dart';
export 'Payment.dart';
export 'Player.dart';
export 'Rating.dart';
export 'Referee.dart';
export 'Team.dart';
export 'TextContent.dart';
export 'Tournament.dart';
export 'Training.dart';
export 'Tryout.dart';
export 'User.dart';
export 'Wager.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "9326e238fab0bbbccbaf7faff2fe3913";
  @override
  List<ModelSchema> modelSchemas = [AppSubscription.schema, Chat.schema, Coach.schema, Event.schema, Game.schema, GifContent.schema, Image.schema, League.schema, Location.schema, Message.schema, Organization.schema, Organizer.schema, Payment.schema, Player.schema, Rating.schema, Referee.schema, Team.schema, TextContent.schema, Tournament.schema, Training.schema, Tryout.schema, User.schema, Wager.schema];
  static final ModelProvider _instance = ModelProvider();
  @override
  List<ModelSchema> customTypeSchemas = [];

  static ModelProvider get instance => _instance;
  
  ModelType getModelTypeByModelName(String modelName) {
    switch(modelName) {
      case "AppSubscription":
        return AppSubscription.classType;
      case "Chat":
        return Chat.classType;
      case "Coach":
        return Coach.classType;
      case "Event":
        return Event.classType;
      case "Game":
        return Game.classType;
      case "GifContent":
        return GifContent.classType;
      case "Image":
        return Image.classType;
      case "League":
        return League.classType;
      case "Location":
        return Location.classType;
      case "Message":
        return Message.classType;
      case "Organization":
        return Organization.classType;
      case "Organizer":
        return Organizer.classType;
      case "Payment":
        return Payment.classType;
      case "Player":
        return Player.classType;
      case "Rating":
        return Rating.classType;
      case "Referee":
        return Referee.classType;
      case "Team":
        return Team.classType;
      case "TextContent":
        return TextContent.classType;
      case "Tournament":
        return Tournament.classType;
      case "Training":
        return Training.classType;
      case "Tryout":
        return Tryout.classType;
      case "User":
        return User.classType;
      case "Wager":
        return Wager.classType;
      default:
        throw Exception("Failed to find model in model provider for model name: " + modelName);
    }
  }
}