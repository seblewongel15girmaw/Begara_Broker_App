import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget{
  final TextEditingController description;
  CustomTextArea({required this.description});
  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: description,
                maxLines: 4,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  hintStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w100),
                  hintText: 'Give description about the house',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.grey), // Set border color for enabled state
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 187, 148,
                            48)), // Set border color for focused state
                  ),
                ),
              ),
            );
  }

}