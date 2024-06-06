import 'dart:async';

import 'package:broker_app/feauters/houses/domain/usecases/post_house.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/create_house/create_house_event.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/create_house/create_house_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class CreateHouseBloc extends Bloc<CreateHouseEvent, CreateHouseState> {
  PostHouse postHouse;
  CreateHouseBloc(this.postHouse) : super(IdleHouse()) {
    on<CreateHouseEvent>(_createHouseClicked);
  }

  FutureOr<void> _createHouseClicked(CreateHouseEvent event, Emitter emit) async{
    emit(CreatingHouse());
    Params param = Params(
        location: event.location,
        price: event.price,
        numberOfRoom: event.numberOfRoom,
        description: event.description,
        images: event.images);
    final response= await postHouse(param);
    response.fold((ifLeft){
      emit(CreateHouseFailure());
    }, (ifRight){
      emit(CreateHouseSuccess());
    });
  
  }
}
