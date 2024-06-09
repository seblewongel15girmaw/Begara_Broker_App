import 'package:broker_app/core/error/errors.dart';
import 'package:broker_app/feauters/houses/domain/entities/house.dart';
import 'package:broker_app/feauters/houses/domain/repository/houseRepository.dart';
import 'package:dartz/dartz.dart';

class GetAllHouses{
Houserepository houserepository;

GetAllHouses(this.houserepository);

Future<Either<Errors, List<House>>> call(int id) async{
  return await houserepository.getAllHouses(id);
}
}