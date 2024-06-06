import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AlertBox extends StatelessWidget {
  @override
  
  final dynamic thisContext;
  AlertBox(
      {
      required this.thisContext});
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("You have reached the limit of 5 images. Please remove some if you want to add new pictures"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "okay",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        
      ],
    );
  }
}
