
import 'package:dartz/dartz.dart';

import '../../../../core/error/errors.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/location.dart';
import '../repository/broker_repository.dart';

class GetLocations extends UseCase<List<Location>, Params>{
  BrokerRepo brokerRepo;
  GetLocations(this.brokerRepo);
  @override
  Future<Either<Errors, List<Location>>> call(Params param) async{
    return await brokerRepo.getLocations(param.query);
  }
  
}

class Params {
  String query;
  Params(this.query);
}