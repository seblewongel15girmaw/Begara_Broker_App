
import 'dart:async';
import 'dart:convert';
import 'package:broker_app/feauters/houses/data/model/house_model.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/get_house/get_house_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_all_houses.dart';
import 'get_house_event.dart';

class GetHouseBloc extends Bloc<GetHouseEvent, GetHouseState> {
  GetAllHouses getAllHouses;

  GetHouseBloc(this.getAllHouses):super(Idle()){
    on<InitialEvent>(initialEvent);
  }

  FutureOr<void> initialEvent(InitialEvent event, Emitter emit) async{
    emit(Loading());
   var response= await getAllHouses(0);
print(response);
    // response.fold((ifLeft){
    //   response.fold(
    //         (ifLeft) {
    //       // Handle the failure case
    //       emit(HouseLoadFailed());
    //     },
    //         (ifRight) {
    //           List<HouseModel> houseList = ifRight.map((house) {
    //             if (house != null) {
    //               return HouseModel.fromJson(house);
    //             } else {
    //               // Provide a default HouseModel if house is null
    //               return HouseModel(id: 0, name: 'Unknown', address: 'Unknown');
    //             }
    //           }).toList();
    //           emit(HouseLoadSuccess(houseList));
    //
    //         },
    //   );
      // emit(HouseLoadSuccess(response);
    // }, (ifRight){
      emit(HouseLoadFailed());
    // });
  }
}