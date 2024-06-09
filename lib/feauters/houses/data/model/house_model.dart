import 'dart:convert';

import 'package:broker_app/feauters/auth/data/model/location.dart';
import 'package:broker_app/feauters/houses/domain/entities/house.dart';

class HouseModel extends House {
  HouseModel({
    required int houseId,
    required LocationModel location,
    required double price,
    required int numberOfRooms,
    required String description,
  }) : super(
            houseId: houseId,
            location: location,
            price: price,
            numberOfRooms: numberOfRooms,
            description: description);
  factory HouseModel.fromJson(Map<String, dynamic> map) {
    return HouseModel(
        houseId: map["houseId"],
        location:LocationModel.fromJson(jsonDecode(map["location"])),
        price: map["price"].toDouble(),
        numberOfRooms: map["numberOfRooms"],
        description: map["description"]);
  }
}
