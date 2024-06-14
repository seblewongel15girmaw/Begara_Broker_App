import 'package:broker_app/feauters/auth/domain/repository/broker_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/errors.dart';

class VerifyBroker{
  BrokerRepo brokerRepo;
  VerifyBroker(this.brokerRepo);

  Future<Either<Errors, String>> call(String otp) async{
      return await brokerRepo.verifyBroker(otp);
  }
}