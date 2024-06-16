
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/validators.dart';
import '../blocs/change_password/change_password.dart';
import '../widgets/alert_box.dart';
import '../widgets/custom_password_field.dart';
import '../widgets/success_message.dart';

class ChangePasswordPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:AppBar(
        title: Text("Change Password"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor:Color.fromRGBO(244, 196, 48,0.9) , // Make the app bar transparent
          elevation: 0,
        ),
      body: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
          builder: (context, state) {
        if (state is !ChangePasswordSuccess) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Change Password",
                style: TextStyle(
                    color: Color.fromRGBO(244, 196, 48, 0.9),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        CustomPasswordField(
                        textController: passwordController,
                        label: "Enter old Password",
                        validator: passwordValidator),
                        CustomPasswordField(
                        textController: newPasswordController,
                        label: "Enter new Password",
                        validator: passwordValidator),
                        CustomPasswordField(
                            textController: repasswordController,
                            label: "Confirm new Password",
                            validator: (value) {
                              repasswordValidator(value, newPasswordController.text);
                            }),
                      ],
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                  onTap: () {
                    final newContext = context;
                    if (formKey.currentState!.validate()) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertBox(
                                newPasswordController: newPasswordController,
                                repasswordController: repasswordController,
                                passwordController: passwordController,
                                thisContext: newContext);
                          });
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 250,
                    decoration: BoxDecoration(
                      color: state is ChangePasswordFailed
                          ? Colors.red
                          : Color.fromRGBO(244, 196, 48, 0.9),
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: Center(
                      child: state is ChangingPassword
                          ? CircularProgressIndicator()
                          : Text(
                              "Update Password",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ))
            ],
          );
        } else {
          return Center(
            child: SuccessMessage(
              message: "Password successfuly changed",
              navigateMessage: "Continue your journey",
            ),
          );
        }
      }),
    );
  }
}
