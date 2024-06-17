import 'dart:async';

import 'package:broker_app/feauters/houses/domain/usecases/delete_house.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/remove_house/remove_house_event.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/remove_house/remove_house_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoveHouseBloc extends Bloc<RemoveHouseEvent,RemoveHouseState>{
  DeleteHouse deleteHouse;
  RemoveHouseBloc({required this.deleteHouse}):super(IdleRemoveHouse()){
    on<RemoveHouseEvent>(_removeHouse);
  }

  FutureOr<void> _removeHouse(RemoveHouseEvent event, Emitter emit) async{
    emit(RemovingHouse());
    Params param= Params(id: event.id);
    final response= await deleteHouse(param);
    response.fold((ifLeft){
      print("the error is here not gonna lie");
      emit(RemovingHouseFailed());
    }, (ifRight){
      print("not gonna lie that was a massive success");
      emit(RemovingHouseSuccess());
    });
  }
}