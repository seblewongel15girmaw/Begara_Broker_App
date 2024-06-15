import 'dart:io';

import 'package:broker_app/core/util/validators.dart';
import 'package:broker_app/feauters/auth/domain/entities/location.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/image/id_image.dart/id_image_bloc.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/image/id_image.dart/id_image_event.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/image/id_image.dart/id_image_state.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/login/login_bloc.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/login/login_state.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/register/register_bloc.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/register/register_event.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/register/register_state.dart';
import 'package:broker_app/feauters/auth/presentation/pages/login_page.dart';
import 'package:broker_app/feauters/auth/presentation/widgets/custom_password_field.dart';
import 'package:broker_app/feauters/auth/presentation/widgets/custom_text_field.dart';
import 'package:broker_app/feauters/auth/presentation/widgets/drop_down_option.dart';
import 'package:broker_app/feauters/auth/presentation/widgets/location_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../blocs/image/profile_image.dart/image.dart';
import '../widgets/upload_button.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  bool profileSelected = false;
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController phoneNumber2 = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController repassword = TextEditingController();
  Location? address;
  XFile? image;
  XFile? image2;

  String? gender;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          "Register",
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Color.fromARGB(255, 187, 148, 48),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: BlocConsumer<ImageBloc, ImageState>(
                  listener: (context, state) {
                if (state is ImageSelected) {
                  image = state.image;
                }
              }, builder: (context, state) {
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: profileSelected
                          ? Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: FileImage(File(image!.path)),
                                      fit: BoxFit.fill)),
                            )
                          : Icon(
                              Icons.account_circle,
                              size: 100,
                              color: Color.fromARGB(255, 187, 148, 48),
                            ),
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_alt_rounded,
                          size: 20, color: Colors.black),
                      onPressed: () {
                        profileSelected = true;
                        BlocProvider.of<ImageBloc>(context)
                            .add(ProfileClicked());
                      },
                    )
                  ],
                );
              }),
            ),
            BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
              if (state is ProfileNotSelected) {
                return Text(
                  "Profile must be selected!",
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return SizedBox(
                  height: 0,
                );
              }
            }),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account, sign in "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  child: Text(
                    "here",
                    style: TextStyle(
                      color: Color.fromARGB(255, 187, 148, 48),
                      decoration: TextDecoration.underline,
                      decorationColor: Color.fromARGB(255, 187, 148, 48),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                        textController: fullName,
                        label: "Full Name",
                        validator: nameValidator),
                    CustomTextField(
                        textController: email,
                        label: "Email",
                        validator: emailValidator),
                    CustomDropdownButton(
                      initalSelection: null,
                      leadIcon: Icons.note_alt_sharp,
                      hintText: "Choose gender",
                      header: "Gender",
                      items: ["Male","Female",],
                      value: gender,
                      onChanged: (newValue) {
                        gender = newValue!;
                      },
                    ),
                    CustomTextField(
                        textController: phoneNumber,
                        label: "Phone Number 1",
                        validator: phoneNumberValidator),
                    CustomTextField(
                        textController: phoneNumber2,
                        label: "Phone Number 2",
                        validator: phoneNumberValidator),
                    LocationBar(
                        getLocation: (location) {
                          address = location;
                        },
                        width: size.width,
                        choosenLocation: null),
                    CustomPasswordField(
                        textController: password,
                        label: "Enter Password",
                        validator: passwordValidator),
                    CustomPasswordField(
                        textController: repassword,
                        label: "Confirm Password",
                        validator: (value) {
                          repasswordValidator(value, password.text);
                        }),
                    UploadImageButton(
                        idImage: image2,
                        onPressed: () {
                          BlocProvider.of<IdImageBloc>(context).add(IdClicked());
                        },
                        listener: (context, state) {
                          if (state is IdSuccess) {
                            image2 = state.image;
                          }
                        },
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterBloc>(context).add(
                              RegisterEvent(
                                  fullName: fullName.text,
                                  address: address!,
                                  email: email.text,
                                  password: password.text,
                                  phoneNumber: phoneNumber.text,
                                  phoneNumber2: phoneNumber2.text,
                                  profilePic: image,
                                  idPic: image2,
                                  gender: gender!));
                        }
                      },
                      child: BlocConsumer<RegisterBloc, RegisterState>(
                          listener: (context, state) {
                        if (state is RegisterSuccess) {
                          Navigator.pushNamed(context, "/login");
                        }
                      }, builder: (context, state) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            color: state is RegisterFailed
                                ? Colors.red
                                : State is Registering
                                    ? Colors.grey
                                    : Color.fromARGB(255, 187, 148, 48),
                            height: 40,
                            child: Center(
                              child: state is RegisterFailed
                                  ? Text("Retry")
                                  : Text("Submit"),
                            ),
                          ),
                        );
                      }),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
