import 'package:broker_app/feauters/auth/domain/repository/broker_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/errors.dart';
import '../../../../core/usecase/usecase.dart';

class LogOutUser extends UseCase<int,Params>{
  BrokerRepo brokerRepo;
  LogOutUser(this.brokerRepo);

  @override
  Future<Either<Errors, int>> call(Params param) async{
   return await brokerRepo.logoutUser();
  }
  
}

class Params {

}