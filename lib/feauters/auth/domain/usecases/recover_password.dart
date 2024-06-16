import 'package:broker_app/feauters/auth/domain/repository/broker_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/errors.dart';
import '../../../../core/usecase/usecase.dart';

class RecoverPassword implements UseCase<int,Params>{
BrokerRepo brokerRepo;
RecoverPassword(this.brokerRepo);

  @override
  Future<Either<Errors, int>> call(Params param) async{
    return await brokerRepo.recoverPassword(param.email);
  }

}

class Params {
  String email;
  Params({required this.email});
}