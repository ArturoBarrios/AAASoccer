import 'package:get_it/get_it.dart';
import 'package:soccermadeeasy/data/services/twilio/twilio_service.dart';
import 'package:soccermadeeasy/data/services/twilio/twilio_service_impl.dart';

final getIt = GetIt.instance;

Future<void> diInit() async {
  getIt.registerSingletonAsync<TwilioService>(() async {
    final twilioService = TwilioServiceImpl();
    await twilioService.init();
    return twilioService;
  });
}
