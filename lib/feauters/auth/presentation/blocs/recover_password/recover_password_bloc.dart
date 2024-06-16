import 'dart:async';
import 'package:broker_app/feauters/auth/presentation/blocs/recover_password/recover_password_event.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/recover_password.dart';
import 'recover_password_state.dart';

class RecoverPasswordBloc extends Bloc<RecoveryEmail, RecoverPasswordState>{
  final RecoverPassword recoverPassword;
  RecoverPasswordBloc(this.recoverPassword):super(Idle()){
    on<RecoveryEmail>(_recoverPassword);
  }

  FutureOr<void> _recoverPassword(RecoveryEmail event, Emitter emit) async{
    emit(RecoveringPassword());
    Params param=Params(email: event.email);
    final response= await recoverPassword(param);
    response.fold((l) => emit(RecoverFailed()), (r) => emit(SuccessfulyRecovered()));
  }
}