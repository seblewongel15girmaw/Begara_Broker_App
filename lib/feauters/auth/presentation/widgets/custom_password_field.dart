import 'package:broker_app/feauters/auth/presentation/blocs/password_visiblity/password_bloc.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/password_visiblity/password_event.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/password_visiblity/password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController textController;
  final String label;
  final FormFieldValidator<String>? validator;
  CustomPasswordField(
      {required this.textController,
      required this.label,
      required this.validator});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(builder: (context, state) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          obscureText: state is Hidden ? true : false,
          validator: validator,
          controller: textController,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                if (state is Hidden) {
                  BlocProvider.of<PasswordBloc>(context).add(ShowPassword());
                } else {
                  BlocProvider.of<PasswordBloc>(context).add(HidePassword());
                }
              },
              icon: Icon(
                  state is Hidden ? Icons.visibility: Icons.visibility_off, color: Color.fromARGB(255, 187, 148, 48),),
            ),
            hintText: label,
            hintStyle:
                TextStyle(color: Color.fromARGB(255, 187, 148, 48)), // Set hint text color to amber
            contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0), // Add padding for the entered text
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey), // Set border color for enabled state
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.amber), // Set border color for focused state
            ),
          ),
        ),
      );
    });
  }
}
