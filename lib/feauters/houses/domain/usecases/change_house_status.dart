import 'package:broker_app/core/error/errors.dart';
import 'package:broker_app/core/usecase/usecase.dart';
import 'package:broker_app/feauters/houses/domain/repository/houseRepository.dart';
import 'package:dartz/dartz.dart';

class ChangeHouseStatus extends UseCase<int,Params>{
  Houserepository houserepository;
  ChangeHouseStatus({required this.houserepository});
  @override
  Future<Either<Errors, int>> call(Params param) async{
    return await houserepository.changeHouseStatus(param.id);
  }

}

class Params {
  final int id;
  Params({required this.id});
}