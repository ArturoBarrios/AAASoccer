import 'package:soccermadeeasy/commands/event_command.dart';

import 'network/types/either.dart';
import 'network/types/failure.dart';
import 'network/types/server_failure.dart';
import 'network/util/api_util.dart';
import 'network_models/add_social_media_apps_request.dart';
import 'network_models/base_update_response_model.dart';

class EventCommandImpl {
  Future<Either<Failure, BaseUpdateResponseModel?>> updateSocialMedia(
          {required final AddSocialMediaAppsRequest body}) async =>
      mapApiResponse<BaseUpdateResponseModel, void, BaseUpdateResponseModel?>(
        request: EventCommand().updateSocialMedia(body: body),
        mapData: (final content) {
          return content?.data != null
              ? Right(
                  content,
                )
              : const Left(ServerFailure(message: 'Something went wrong!'));
        },
      );
}
