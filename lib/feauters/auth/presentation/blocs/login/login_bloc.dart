import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:broker_app/feauters/auth/domain/usecases/login_broker.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/login/login_event.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBroker loginBroker;
  LoginBloc(this.loginBroker) : super(LogIdle()) {
    on<LoginEvent>(loginButtonClicked);
  }

  FutureOr<void> loginButtonClicked(LoginEvent event, Emitter emit) async {
    emit(Logging());
    Params param = Params(email: event.email, password: event.password);
    final response = await loginBroker(param);
    response.fold((ifLeft) {
      emit(LogFailed());
    }, (ifRight) {
      emit(LogSucess());
    });
  }
}
