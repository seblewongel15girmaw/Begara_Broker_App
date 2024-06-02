
import '../../domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel({
    required String displayName,
    required double lat,
    required double long,
  }) : super(displayName: displayName, lat: lat, long: long);
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return LocationModel(
      displayName: json['display_name'],
      lat:json['lat'] is String? double.parse(json['lat']):json['lat'],
      long: json['lon'] is String? double.parse(json['lon']):json['lon'],
    );
  }
}
