abstract class TwilioService {
  Future<void> init();
  Future<bool> sendSMS(String toNumber, String message);
  Future<bool> sendOTPSMS(String toNumber, String otp);
}
