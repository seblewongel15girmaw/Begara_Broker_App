import 'package:image_picker/image_picker.dart';

abstract class SelectEvent {
  
}

class ProfileClicked extends SelectEvent{}
class IdClicked extends SelectEvent{}
class CleanImage extends SelectEvent{}

class ImageSelect extends SelectEvent{
  final XFile image;
  ImageSelect({required this.image});
}