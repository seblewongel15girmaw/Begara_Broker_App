import 'package:image_picker/image_picker.dart';

abstract class IdState{}

class IdleId extends IdState{}

class IdSuccess extends IdState{
  XFile? image;
  IdSuccess({required this.image});
}