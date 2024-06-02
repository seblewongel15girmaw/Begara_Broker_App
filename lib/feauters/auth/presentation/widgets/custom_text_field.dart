import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
  final TextEditingController textController;
  final String label;
  final FormFieldValidator<String>? validator;
  CustomTextField({required this.textController, required this.label, required this.validator});
  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: validator,
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: label,
                      hintStyle: TextStyle(color: Color.fromARGB(255, 187, 148, 48)), // Set hint text color to amber
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Add padding for the entered text
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey), // Set border color for enabled state
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 187, 148, 48)), // Set border color for focused state
                      ),
                    ),
                  ),
                );
  }

}