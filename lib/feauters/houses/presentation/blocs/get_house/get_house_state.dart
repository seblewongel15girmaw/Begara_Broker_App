import 'package:broker_app/feauters/houses/domain/entities/house.dart';

import '../../../data/model/house_model.dart';

abstract class GetHouseState {}

class Idle extends GetHouseState{}

class Loading extends GetHouseState{}

class HouseLoadSuccess extends GetHouseState{
  List<House> houses;
  HouseLoadSuccess(this.houses);
}

class HouseLoadFailed extends GetHouseState{}

