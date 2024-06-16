import 'dart:async';

import 'package:broker_app/feauters/houses/domain/usecases/edit_house.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/edit_house/edit_house_event.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/edit_house/edit_house_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditHouseBloc extends Bloc<EditHouseEvent, EditHouseState> {
  EditHouse editHouse;
  EditHouseBloc(this.editHouse) : super(IdleEditHouse()) {
    on<EditHouseEvent>(_editHouse);
  }

  FutureOr<void> _editHouse(EditHouseEvent event, Emitter emit) async{
    emit(EditingHouse());
    print("length of images is ${event.images.length}");
    Params param = Params(
        description: event.description,
        location: event.location,
        houseId: event.houseId,
        numberOfRoom: event.numberOfRoom,
        images: event.images,
        price: event.price);
  final response= await editHouse(param);
  response.fold((ifLeft){
    emit(EditingHouseFailed());
  }, (ifRight){
    emit(EditingHouseSuccess());
  });
  }

}
