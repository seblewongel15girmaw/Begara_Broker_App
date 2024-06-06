import 'package:broker_app/feauters/auth/data/model/location.dart';
import 'package:broker_app/feauters/houses/domain/entities/house.dart';

class HouseModel extends House {
  HouseModel({
    required int id,
    required LocationModel location,
    required double price,
    required int numberOfRooms,
    required String description,
  }) : super(
            id: id,
            location: location,
            price: price,
            numberOfRooms: numberOfRooms,
            description: description);
  factory HouseModel.fromJson(Map<String, dynamic> map) {
    return HouseModel(
        id: map["id"],
        location:LocationModel.fromJson(map["location"]),
        price: map["price"],
        numberOfRooms: map["numberOfRooms"],
        description: map["description"]);
  }
}
