import "package:broker_app/feauters/auth/presentation/widgets/custom_button.dart";
import "package:flutter/material.dart";
import "package:flutter_otp_text_field/flutter_otp_text_field.dart";

class VerificationScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Verification Code", style: TextStyle(fontSize: 24)),
              SizedBox(height: 17,),
              Text("please enter the verification code", style: TextStyle(fontSize: 12, color: Colors.grey),),
              Text("we sent you via SMS", style:TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(height: 30,),
              OtpTextField(
                numberOfFields: 6,
                borderColor: Color(0xFF512DA8),
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode){
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text("Verification Code"),
                          content: Text('Code entered is $verificationCode'),
                        );
                      }
                  );
                }, // end onSubmit
              ),
              SizedBox(height: 60,),
              CustomButton(text: "Submit", color: Colors.yellow)
            ],
          ),
        ),
      ),
    );
  }

}