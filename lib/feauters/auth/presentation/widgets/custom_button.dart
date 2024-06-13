import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  String text;
  Color color;
  CustomButton({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
   return Container(
     width: 200,
     height: 30,
     decoration: BoxDecoration(
       border: Border.all(
         color: Colors.white70
       ),
       boxShadow: [
         BoxShadow(
             color: Colors.white,
         offset: Offset(-3,-3),
         blurRadius: 10,
         spreadRadius: 1
         ),
       BoxShadow(
         color: Colors.grey.shade400,
         offset: Offset(3,3),
         spreadRadius: 1,
         blurRadius: 10
       )
       ],
       color: color,
         borderRadius: BorderRadius.all(Radius.circular(5))
     ),
     child: Center(child: Text(text, style: TextStyle(fontSize: 16),)),
   );
  }
}