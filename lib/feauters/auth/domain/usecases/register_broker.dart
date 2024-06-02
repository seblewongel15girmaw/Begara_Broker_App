import 'package:broker_app/core/error/errors.dart';
import 'package:broker_app/core/usecase/usecase.dart';
import 'package:broker_app/feauters/auth/domain/entities/location.dart';
import 'package:broker_app/feauters/auth/domain/repository/broker_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

class RegisterBroker extends UseCase<int,Params>{
  BrokerRepo brokerRepo;
  RegisterBroker(this.brokerRepo);

  @override
  Future<Either<Errors, int>> call(Params param) async{
    return await brokerRepo.registerBroker(param.fullName, param.password, param.email, param.phoneNumber, param.phoneNumber2, param.address, param.profilePic);
  }

}

class Params {
  String fullName;
  String password;
  String email;
  String phoneNumber;
  String phoneNumber2;
  Location address;
  XFile profilePic;
  Params({required this.fullName, required this.password, required this.email, required this.phoneNumber, required this.address, required this.phoneNumber2,required this.profilePic});
}