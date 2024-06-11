import 'package:broker_app/feauters/auth/domain/entities/location.dart';
import 'package:equatable/equatable.dart';

class House extends Equatable{
  final int houseId;
  final Location location;
  final double price;
  final int numberOfRooms;
  final String description;
  final List<ImageEntity> Images;

  const House({
    required this.houseId,
    required this.location,
    required this.price,
    required this.numberOfRooms,
    required this.description,
    required this.Images
  });
  
  @override
  List<Object?> get props =>[
    location,price,numberOfRooms,description,houseId, Images
  ];
  Map<String, dynamic> toJson() {
    return {
      "houseId":houseId,
      "location":location.toJson(),
      "price": price,
      "numberOfRoom": numberOfRooms,
      "description": description,
      "Images":Images
    };
  }
}


class ImageEntity extends Equatable {
  final int imageId;
  final String imageUrl;

  const ImageEntity({required this.imageId, required this.imageUrl});

  @override
  List<Object?> get props => [imageId, imageUrl];


  factory ImageEntity.fromJson(Map<String, dynamic> json){
    return ImageEntity(imageId: json["imageId"], imageUrl: json["imageUrl"]);
  }
}