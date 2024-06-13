import 'package:broker_app/feauters/auth/data/model/location.dart';
import 'package:broker_app/feauters/auth/domain/entities/broker.dart';

class BrokerModel extends Broker {
  BrokerModel({
    required int id,
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required String phoneNumber2,
    required LocationModel address,
    required String profilePic,
    required String idPic,
    required String gender,
  }) : super(
            address: address,
            id: id,
            fullName: fullName,
            email: email,
            password: password,
            phoneNumber: phoneNumber,
            phoneNumber2: phoneNumber2,
            profilePic: profilePic,
            idPic: idPic,
            gender: gender);
  factory BrokerModel.fromJson(Map<String, dynamic> map) {
    return BrokerModel(
        id: map["id"],
        fullName: map["full_name"],
        email: map["email"],
        password: map["password"],
        phoneNumber: map["phone_number"],
        phoneNumber2: map["phone_number_2"],
        address: map["address"],
        profilePic: map["profile_pic"],
        idPic: map["id_pic"],
        gender: map["gender"]);
  }
}
