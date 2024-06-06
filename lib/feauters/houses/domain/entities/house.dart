import 'package:broker_app/feauters/auth/domain/entities/location.dart';
import 'package:equatable/equatable.dart';

class House extends Equatable{
  final int id;
  final Location location;
  final double price;
  final int numberOfRooms;
  final String description;
  const House({
    required this.id,
    required this.location,
    required this.price,
    required this.numberOfRooms,
    required this.description,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props =>[
    location,price,numberOfRooms,description,id
  ];
  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "location":location.toJson(),
      "price": price,
      "numberOfRoom": numberOfRooms,
      "description": description,
    };
  }
}