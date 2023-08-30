import 'package:soccermadeeasy/commands/event_command.dart';

import 'network/types/either.dart';
import 'network/types/failure.dart';
import 'network/types/server_failure.dart';
import 'network/util/api_util.dart';
import 'network_models/base_update_response_model.dart';

class EventCommandImpl {
  Future<Either<Failure, BaseUpdateResponseModel?>> updateSocialMedia({
    required final String type,
    required final String url,
    required final String eventId,
    required final String userId,
  }) async =>
      mapApiResponse<BaseUpdateResponseModel, void, BaseUpdateResponseModel?>(
        request: EventCommand().updateSocialMedia(
          type: type,
          url: url,
          eventId: eventId,
          userId: userId,
        ),
        mapData: (final content) {
          return content?.data != null
              ? Right(
                  content,
                )
              : const Left(ServerFailure(message: 'Something went wrong!'));
        },
      );
}
