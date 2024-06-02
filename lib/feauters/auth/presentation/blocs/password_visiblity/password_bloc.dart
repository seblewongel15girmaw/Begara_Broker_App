import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/password_visiblity/password_event.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/password_visiblity/password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState>{
  PasswordBloc():super(Hidden()){
    on<PasswordEvent>(
      passwordButtonClicked
    );
  }

  FutureOr<void> passwordButtonClicked(PasswordEvent event, Emitter emit) {
    if(event is ShowPassword){
      emit(Visible());
    }
    else{
      emit(Hidden());
    }
  }
}