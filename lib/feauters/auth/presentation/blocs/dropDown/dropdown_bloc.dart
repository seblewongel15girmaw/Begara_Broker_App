import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dropdown_event.dart';
import 'dropdown_state.dart';

class DropDownBloc extends Bloc<DropDownEvent,DropDownState>{
  DropDownBloc():super(Idle()){
    on<DropDownEvent>(_dropDownEventHandler);
  }

  FutureOr<void> _dropDownEventHandler(DropDownEvent event, Emitter emit) {
    emit(Selected());
  }
}