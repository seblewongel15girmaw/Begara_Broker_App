import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/location.dart';

abstract class BrokerEvent{}

class RegisterEvent extends BrokerEvent {
  String fullName;
  String password;
  String email;
  String phoneNumber;
  String phoneNumber2;
  Location address;
  XFile? profilePic;
  XFile? idPic;
  String gender;
  RegisterEvent(
      {required this.fullName,
      required this.address,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.phoneNumber2,
      required this.profilePic,
      required this.idPic,
      required this.gender});
}

class SentOTPEvent extends BrokerEvent{
  String otp;
  SentOTPEvent(this.otp);
}