import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/logout_user.dart';
import 'logout_event.dart';
import 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent,LogOutState>{
  LogOutUser logOutUser;
  LogoutBloc(this.logOutUser):super(LoggedIn()){
    on<LogoutEvent>(_logoutClicked);
  }

  FutureOr<void> _logoutClicked(LogoutEvent event, Emitter emit) async{
    Params param= Params();
    final response= await logOutUser(param);
    response.fold((ifLeft){
      emit(LogoutFailed());
    }, (ifRight){
      emit(LoggedOut());
    });
    
  }
}