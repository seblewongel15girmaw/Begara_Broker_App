import 'package:equatable/equatable.dart';

class Location extends Equatable{
  final String displayName;
  final double lat;
  final double long;
  Location({required this.displayName, required this.lat, required this.long});
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    displayName,lat,long
  ];
  Map <String,dynamic> toJson(){
    return {"display_name":displayName,
            "lat":lat,
            "lon":long};
  }
}