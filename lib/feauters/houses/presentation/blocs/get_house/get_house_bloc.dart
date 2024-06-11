
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
   response.fold((error){
    emit(HouseLoadFailed());
   }, (houses){
    emit(HouseLoadSuccess(houses));
   });
   
    
  }
}