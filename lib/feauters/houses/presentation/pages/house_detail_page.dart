import "package:another_carousel_pro/another_carousel_pro.dart";
import "package:broker_app/feauters/houses/domain/entities/house.dart";
import "package:flutter/material.dart";
import 'dart:io';


class HouseDetail extends StatelessWidget{
  late  House houseModel;
  HouseDetail({super.key, required this.houseModel});

  @override
  Widget build(BuildContext context) {
    var location= houseModel.location.displayName.split("/")[0];
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    BuildContext newContext= context;
    return Scaffold(
      body: SafeArea(
          child: Container(
            height: height,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom:Radius.circular(70)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        )
                      ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(bottom:Radius.circular(70)),
                    child: Container(
                      height: height/2,
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
                          images: houseModel.Images.map((image){
                            return Image(
                              image:FileImage(File(image.imageUrl)),
                              fit: BoxFit.cover,);},
                          ).toList()
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
                          color: Colors.black
                      ),
                      child: IconButton(icon:Icon(Icons.arrow_circle_left_outlined), color: Colors.white,
                        onPressed: () { Navigator.of(context).pushNamed("/homePage"); },),
                    )) ,
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width:width,
                    height: height/2,
                    decoration: BoxDecoration(

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 35,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: [
                              SizedBox(width: 17,),
                              Expanded(child: Text(location, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, ))),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: [
                              SizedBox(width: 17,),
                              Expanded(
                                  child: Text(houseModel.description,style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, ), )),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: [
                              SizedBox(width: 17,),
                              Text('${houseModel.price.toString()} ETB' , style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, ),),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: [
                              SizedBox(width: 17,),
                              Text('${houseModel.numberOfRooms.toString()} rooms ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, ),),
                            ],
                          ),
                        ),
                      SizedBox(height: 30,),
                      ElevatedButton(onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(300, 30),

                            backgroundColor: Colors.blueGrey, // Change the background color here
                          ),
                          child: Text("Edit House", style: TextStyle(color: Colors.white))),
                        SizedBox(height: 10,),

                        ElevatedButton(onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(300, 30),
                              backgroundColor: Colors.redAccent, // Change the background color here
                            ),
                            child: Text("Delete House", style: TextStyle(color: Colors.white),)),
                      ]
                        )
                  ),
                )
              ],
            ),
          )
      ),
    );
  }}

