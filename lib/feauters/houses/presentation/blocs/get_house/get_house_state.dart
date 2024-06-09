import '../../../data/model/house_model.dart';

abstract class GetHouseState {}

class Idle extends GetHouseState{}

class Loading extends GetHouseState{}

class HouseLoadSuccess extends GetHouseState{
  List<HouseModel> houses;
  HouseLoadSuccess(this.houses);
}

class HouseLoadFailed extends GetHouseState{}

