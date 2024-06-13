import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/image/image.dart';

class UploadImageButton extends StatelessWidget {
  XFile? idImage;
  final Function(BuildContext, dynamic) listener;
  void Function()? onPressed;
  UploadImageButton(
      {super.key,
      required this.idImage,
      required this.onPressed,
      required this.listener});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageBloc, ImageState>(
      listener: (context, state) => listener(context, state),
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width, 50),
              backgroundColor: state is IdSelected? Color.fromARGB(255, 240, 222, 177): Color.fromARGB(255, 187, 148, 48),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(0), // Adjust the value as needed
              ),
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Icons.upload), Text(state is IdSelected?state.image!.name : "Upload Id")],
            ),
          ),
        );
      },
    );
  }
}
