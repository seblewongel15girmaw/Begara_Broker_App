import 'package:broker_app/core/error/errors.dart';
import 'package:broker_app/core/usecase/usecase.dart';
import 'package:broker_app/feauters/auth/domain/repository/broker_repository.dart';
import 'package:dartz/dartz.dart';

class LoginBroker extends UseCase<int,Params>{
  BrokerRepo brokerRepo;
  LoginBroker(this.brokerRepo);

  @override
  Future<Either<Errors, int>> call(param) async{
    return await brokerRepo.loginBroker(param.email, param.password);
  }
  
}

class Params {
  String email;
  String password;
  Params({required this.email, required this.password});
}