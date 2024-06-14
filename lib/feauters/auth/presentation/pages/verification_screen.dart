import "package:broker_app/feauters/auth/presentation/blocs/register/register_bloc.dart";
import "package:broker_app/feauters/auth/presentation/blocs/register/register_event.dart";
import "package:broker_app/feauters/auth/presentation/blocs/register/register_state.dart";
import "package:broker_app/feauters/auth/presentation/widgets/custom_button.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_otp_text_field/flutter_otp_text_field.dart";

class VerificationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          print(state);
          if(state is VerificationSuccess){
              Navigator.pushNamed(context, "/homePage");
          }
          else if(state is VerificationFailed){
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("Verification Failed"),
                        content: Text('Please try again'),
                      );
                    }
                );
          }
        },
              builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Verification Code", style: TextStyle(fontSize: 24)),
                SizedBox(height: 17,),
                Text("please enter the verification code",
                  style: TextStyle(fontSize: 12, color: Colors.grey),),
                Text("we sent you via SMS",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 30,),
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: Color(0xFF512DA8),
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    print(verificationCode);
                    BlocProvider.of<RegisterBloc>(context).add(SentOTPEvent(verificationCode));

                  }, // end onSubmit
                ),
                SizedBox(height: 60,),
                // GestureDetector(
                //   onTap: (){
                //
                //   },
                //     child: CustomButton(text: "Submit", color: Colors.yellow))
              ],
            );
          }),
        ),
      ),
    );
  }
}

