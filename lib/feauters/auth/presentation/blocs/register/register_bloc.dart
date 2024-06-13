import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:broker_app/feauters/auth/domain/usecases/register_broker.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/register/register_event.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBroker registerBroker;
  RegisterBloc(this.registerBroker) : super(IdleRegister()) {
    on<RegisterEvent>(registerButtonClicked);
  }

  FutureOr<void> registerButtonClicked(RegisterEvent event, Emitter emit) async{
    if(event.profilePic==null){
      emit(ProfileNotSelected());
    }
    else{
    emit(Registering());
    Params param = Params(
        fullName: event.fullName,
        password: event.password,
        email: event.email,
        phoneNumber: event.phoneNumber,
        address: event.address,
        phoneNumber2: event.phoneNumber2,
        profilePic: event.profilePic!,
        idPic: event.idPic!,
        gender: event.gender);
    final response= await registerBroker(param);
    response.fold((ifLeft){
      emit(RegisterFailed());
    }, (ifRight){
      emit(RegisterSuccess());
    });
  }
}
}
