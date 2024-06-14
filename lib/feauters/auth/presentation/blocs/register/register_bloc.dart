import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:broker_app/feauters/auth/domain/usecases/register_broker.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/register/register_event.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/register/register_state.dart';

import '../../../domain/usecases/verifyBroker.dart';

class RegisterBloc extends Bloc<BrokerEvent, RegisterState> {
  RegisterBroker registerBroker;
  VerifyBroker verifyBroker;
  RegisterBloc(this.registerBroker, this.verifyBroker) : super(IdleRegister()) {
    on<RegisterEvent>(registerButtonClicked);
    on<SentOTPEvent>(sentOTP);
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

FutureOr<void> sentOTP(SentOTPEvent event, Emitter emit) async{
  emit(RegisterSuccess());
  final res= await verifyBroker(event.otp);
  print("this is in the sentotp event");
  print(res);
  res.fold((ifLeft){
    emit(VerificationFailed());
  },
  (ifRight){
    emit(VerificationSuccess());
  });
}
}
