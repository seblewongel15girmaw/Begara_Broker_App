import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'image_event.dart';
import 'image_state.dart';

class ImageBloc extends Bloc<SelectEvent,ImageState> {
  ImageBloc():super(Idle()){
    on<ProfileClicked>(selectImageClicked);
    
  }

  FutureOr<void> selectImageClicked(SelectEvent event, Emitter emit) async{
   final picker = ImagePicker(); 
   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
   if(pickedFile!=null){
    
   emit(ImageSelected(pickedFile));
  
   }}
  

  
}