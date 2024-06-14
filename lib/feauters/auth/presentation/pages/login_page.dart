import 'package:broker_app/core/util/validators.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/login/login_bloc.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/login/login_event.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/login/login_state.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/password_visiblity/password_bloc.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/password_visiblity/password_event.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/password_visiblity/password_state.dart';
import 'package:broker_app/feauters/auth/presentation/widgets/custom_password_field.dart';
import 'package:broker_app/feauters/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController email= TextEditingController();
  final TextEditingController password= TextEditingController();
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              color:  Color.fromARGB(255, 187, 148, 48),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to Begara App',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Find your perfect roommate with ease!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    
                  ],
                ),
              ),
            ),
          ),
         SizedBox(height: 20,),
          Form(
            key:_formKey,
              child: Column(
            children: [
              CustomTextField(textController: email, label:"Email", validator: emailValidator),
              CustomPasswordField(textController: password, label:"Password", validator: passwordValidator),
              SizedBox(
                height: 30,
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Haven't registered yet?, sign up "),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, "/register");
                  },
                  child: Text(
                    "here",
                    style: TextStyle(
                        color: Color.fromARGB(255, 187, 148, 48),
                        decoration: TextDecoration.underline,
                        decorationColor:  Color.fromARGB(255, 187, 148, 48), ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  if (_formKey.currentState!.validate()){
                    BlocProvider.of<LoginBloc>(context).add(LoginEvent(email: email.text, password: password.text));
                  }
                },
                child: BlocConsumer<LoginBloc,LoginState>(
                  listener: (context, state) {
                    if (state is LogSucess){
                      print("there is the success blud");
                      Navigator.pushNamed(context, "/homePage");
                    }
                  },
                  builder: (context,state) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        color: state is LogFailed? Colors.red: State is Logging? Colors.grey:  Color.fromARGB(255, 187, 148, 48),
                        height: 40,
                        child: Center(
                          child: state is LogFailed? Text("Retry") : Text("Submit"),
                        ),
                      ),
                    );
                  }
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    var secondControlPoint = Offset(size.width / 4 * 3, size.height - 90);
    var secondEndPoint = Offset(size.width, size.height - 60);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}