import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/change_password.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent,ChangePasswordState>{
  final ChangePassword changePassword;
  ChangePasswordBloc(this.changePassword):super(Idle()){
    on<ChangePasswordEvent>(_changePasswordClicked);
  }

  FutureOr<void> _changePasswordClicked(ChangePasswordEvent event, Emitter emit) async{
    emit(ChangingPassword());
    Params param= Params(oldPassword: event.oldPassword, newPassword: event.newPassword);
    final response= await changePassword(param);
    response.fold((l) => emit(ChangePasswordFailed()), (r) => (emit(ChangePasswordSuccess())));
  }
}