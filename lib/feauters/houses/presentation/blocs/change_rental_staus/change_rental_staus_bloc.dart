import 'dart:async';
import 'package:broker_app/feauters/houses/domain/usecases/change_house_status.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/change_rental_staus/change_rental_status_event.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/change_rental_staus/change_rental_status_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeRentalStausBloc extends Bloc<ChangeRentalStatusEvent,ChangeRentalStatusState>{
  ChangeHouseStatus changeHouseStatus;
  ChangeRentalStausBloc(this.changeHouseStatus):super(IdleChangeRentalStatus()){
    on<ChangeRentalStatusEvent>(_changeRentalStatus);
  }

  FutureOr<void> _changeRentalStatus(ChangeRentalStatusEvent event, Emitter emit) async{
    emit(ChangingRentalStatus());
    Params param= Params(id: event.id);
    final response= await changeHouseStatus(param);
    response.fold((ifLeft){
      emit(ChangeRentalStatusFailed());
    }, (right){
      emit(ChangeRentalStatusSuccess());
    });
     }
}