import 'package:image_picker/image_picker.dart';

import '../../../../auth/domain/entities/location.dart';

class EditHouseEvent {
  Location location;
  double price;
  int numberOfRoom;
  String description;
  List<XFile> images;
  int houseId;
  EditHouseEvent(
      {required this.houseId,
      required this.location,
      required this.price,
      required this.numberOfRoom,
      required this.description,
      required this.images});
}
