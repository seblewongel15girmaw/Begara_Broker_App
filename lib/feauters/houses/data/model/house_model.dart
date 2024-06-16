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
    required List<ImageEntity> Images,
    required int rentalStatus,
  }) : super(
            houseId: houseId,
            location: location,
            price: price,
            numberOfRooms: numberOfRooms,
            Images: Images,
            description: description,
            rentalStatus: rentalStatus);
  factory HouseModel.fromJson(Map<String, dynamic> map) {

    List<dynamic> imagesJson = map['Images'] ?? [];
    List<ImageEntity> images = imagesJson.map((imageJson) => ImageEntity.fromJson(imageJson)).toList();

    return HouseModel(
        houseId: map["houseId"],
        location:LocationModel.fromJson(jsonDecode(map["location"])),
        price: map["price"].toDouble(),
        numberOfRooms: map["numberOfRoom"],
        Images: images,
        description: map["description"],
        rentalStatus: map["rental_status"]);
  }
}
