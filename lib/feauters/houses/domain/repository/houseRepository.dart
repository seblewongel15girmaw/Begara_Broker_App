import 'package:broker_app/core/error/errors.dart';
import 'package:broker_app/feauters/houses/domain/entities/house.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../auth/domain/entities/location.dart';

abstract class Houserepository{
  Future<Either<Errors,int>> postHouse(Location location, double price, int numberOfRoom, String description,List<XFile>images);
  Future<Either<Errors,int>> editHouse(int houseId,Location location, double price, int numberOfRoom, String description,List<XFile>images);
  Future<Either<Errors,List<House>>> getAllHouses(int brokerId);
  Future<Either<Errors,House>> getHouse(int houseId);
  Future<Either<Errors,int>> deleteHouse(int houseId);
  Future<Either<Errors,int>> changeHouseStatus(int houseId);

}