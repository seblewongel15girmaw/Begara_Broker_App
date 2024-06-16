
import 'package:broker_app/feauters/auth/domain/repository/broker_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/errors.dart';
import '../../../../core/usecase/usecase.dart';

class ChangePassword implements UseCase<int,Params>{
  final  BrokerRepo brokerRepo;
  ChangePassword(this.brokerRepo);
  @override
  Future<Either<Errors, int>> call(Params param) async{
    return await brokerRepo.changePassword(param.oldPassword,param.newPassword);
  }

}

class Params {
  String oldPassword;
  String newPassword;
  Params({required this.oldPassword,required this.newPassword});
}