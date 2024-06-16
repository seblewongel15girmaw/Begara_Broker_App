import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/validators.dart';
import '../blocs/recover_password/recover_password.dart';
import '../widgets/success_message.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
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
      body: BlocBuilder<RecoverPasswordBloc, RecoverPasswordState>(
          builder: (context, state) {
        if (state is !SuccessfulyRecovered) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: Offset(2,2),
                      blurRadius: 7,
                      spreadRadius:1
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-2,-2),
                        blurRadius: 7,
                        spreadRadius:1
                    )
                  ]
                ),
                child: Icon(
                  Icons.help,
                  size: 120,
                  color: Color.fromRGBO(244, 196, 48, 0.9),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Forgot password?",
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Please enter the email you registered with",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    validator: emailValidator,
                    controller: emailController,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(

                    backgroundColor: state is Idle
                        ? Colors.amber.shade50
                        : state is RecoveringPassword
                            ? Colors.grey
                            : Colors.red,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<RecoverPasswordBloc>(context)
                          .add(RecoveryEmail(email: emailController.text));
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 40,
                    child: state is Idle
                        ? Center(child: Text("submit"))
                        : state is RecoverFailed
                            ? Center(child: Text("Submit"))
                            : CircularProgressIndicator(),
                  ))
            ],
          );
        } else {
          return SuccessMessage(
            message:
                "Your password has been recovered. Please login using your new password",
            navigateMessage: "Return back to login page",
          );
        }
      }),
    );
  }
}
