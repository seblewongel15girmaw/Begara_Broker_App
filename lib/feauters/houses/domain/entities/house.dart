import 'package:broker_app/feauters/auth/domain/entities/location.dart';
import 'package:equatable/equatable.dart';

class House extends Equatable{
  final int houseId;
  final Location location;
  final double price;
  final int numberOfRooms;
  final String description;
  const House({
    required this.houseId,
    required this.location,
    required this.price,
    required this.numberOfRooms,
    required this.description,
  });
  
  @override
  List<Object?> get props =>[
    location,price,numberOfRooms,description,houseId
  ];
  Map<String, dynamic> toJson() {
    return {
      "houseId":houseId,
      "location":location.toJson(),
      "price": price,
      "numberOfRoom": numberOfRooms,
      "description": description,
    };
  }
}