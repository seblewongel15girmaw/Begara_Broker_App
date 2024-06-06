import 'package:broker_app/core/error/errors.dart';
import 'package:broker_app/core/usecase/usecase.dart';
import 'package:broker_app/feauters/houses/domain/repository/houseRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../auth/domain/entities/location.dart';

class PostHouse extends UseCase<int,Params>{
  Houserepository houserepository;
  PostHouse(this.houserepository);
  @override
  Future<Either<Errors, int>> call(Params param) async{
   return await houserepository.postHouse(param.location, param.price, param.numberOfRoom, param.description, param.images );
  }

}

class Params {
  List<XFile> images;
  Location location;
  double price;
  int numberOfRoom;
  String description;
  Params({required this.location, required this.price, required this.numberOfRoom, required this.description, required this.images});

}