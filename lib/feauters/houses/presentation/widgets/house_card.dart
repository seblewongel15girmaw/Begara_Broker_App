import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HouseCard extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              spreadRadius: 1,
              blurRadius: 12,
              offset: Offset(3, 3),
            ),
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              blurRadius: 12,
              offset: Offset(-3, -3),
            )]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 140,
              padding: const EdgeInsets.all(6.0),
              child: AnotherCarousel(
                      boxFit: BoxFit.cover,
                      autoplay: false,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: Duration(milliseconds: 800),
                      dotSize: 4.0,
                      dotIncreasedColor: Color(0xFF7E7E7E),
                      dotBgColor: Colors.transparent,
                      dotPosition: DotPosition.bottomCenter,
                      dotVerticalPadding: 10.0,
                      showIndicator: true,
                      indicatorBgPadding: 7.0,
                      images:
                        [ Image(image:NetworkImage("https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg"),
                        fit: BoxFit.cover,),
                          Image(image:NetworkImage("https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg"),
                            fit: BoxFit.cover,),
                          Image(image:NetworkImage("https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg"),
                            fit: BoxFit.cover,),
                        ]
                        ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){},
                    icon: Icon(Icons.edit, color: Colors.blueAccent,size: 18,)),
                IconButton(onPressed: (){},
                    icon:Icon(Icons.delete, color: Colors.red,size: 18,) )
              ],
            ),
          ),
        ],
      ),
    );
  }


}