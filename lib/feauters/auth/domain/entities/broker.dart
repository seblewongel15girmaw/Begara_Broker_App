import 'package:equatable/equatable.dart';

import 'location.dart';

class Broker extends Equatable {
  final int id;
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final String phoneNumber2;
  final Location address;
  final String profilePic;
  
  const Broker(
      { required this.id,
        required this.fullName,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.phoneNumber2,
      required this.address,
      required this.profilePic,
      });

  @override
  // TODO: implement props
  List<Object?> get props {
    return [
      id,
      phoneNumber,
      phoneNumber2,
      address,
    
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "full_name": fullName,
      "email": email,
      "password": password,
      "phone_number": phoneNumber,
      "phone_number2": phoneNumber2,
      "address": address.toJson(),
    };
  }
}
