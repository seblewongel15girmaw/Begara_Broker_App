import 'package:flutter/material.dart';

class SuccessMessage extends StatelessWidget {
  @override
  String message;
  String navigateMessage;
  SuccessMessage({required this.message, required this.navigateMessage});
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            curve: Curves.easeIn,
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(seconds: 1),
            builder: (context, value, child) {
              return Transform(
                transform: Matrix4.rotationY(
                    2 * value * 3.141592653589793238), // π for a half rotation
                alignment: Alignment.center,
                child: child,
              );
            },
            child: Icon(
              Icons.check_circle,
              color: Color.fromRGBO(244, 196, 48, 0.9),
              size: 120,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/login");
              },
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Container(
                  padding: EdgeInsets.all(
                      16.0), // Add padding to ensure text isn't touching the borders
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      navigateMessage,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center, // Ensures text is centered
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
