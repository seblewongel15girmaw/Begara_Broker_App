import 'package:broker_app/core/error/errors.dart';
import 'package:broker_app/core/usecase/usecase.dart';
import 'package:broker_app/feauters/auth/domain/entities/location.dart';
import 'package:broker_app/feauters/houses/domain/repository/houseRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

class EditHouse extends UseCase<int, Params> {
  Houserepository houserepository;
  EditHouse(this.houserepository);

  @override
  Future<Either<Errors, int>> call(Params param) async {
    return await houserepository.editHouse(param.houseId, param.location,
        param.price, param.numberOfRoom, param.description, param.images);
  }
}

class Params {
  int houseId;
  Location location;
  double price;
  int numberOfRoom;
  String description;
  List<XFile> images;
  Params(
      {required this.houseId,
      required this.location,
      required this.price,
      required this.numberOfRoom,
      required this.description,
      required this.images});
}
