import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/change_password/change_password.dart';

class AlertBox extends StatelessWidget {
  @override
  final TextEditingController newPasswordController;
  final TextEditingController repasswordController;
  final TextEditingController passwordController;
  final dynamic thisContext;
  AlertBox(
      {required this.newPasswordController,
      required this.repasswordController,
      required this.passwordController,
      required this.thisContext});
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure you want to change the password?"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<ChangePasswordBloc>(thisContext).add(
                ChangePasswordEvent(
                    newPasswordController.text, passwordController.text));
                    Navigator.of(context).pop();
          },
          child: Text(
            "OK",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ],
    );
  }
}
