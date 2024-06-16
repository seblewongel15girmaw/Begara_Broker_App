import "package:another_carousel_pro/another_carousel_pro.dart";
import "package:broker_app/feauters/houses/domain/entities/house.dart";
import "package:broker_app/feauters/houses/presentation/blocs/change_rental_staus/change_rental_status_event.dart";
import "package:broker_app/feauters/houses/presentation/blocs/change_rental_staus/change_rental_status_state.dart";
import "package:broker_app/feauters/houses/presentation/blocs/change_rental_staus/change_rental_staus_bloc.dart";
import "package:broker_app/feauters/houses/presentation/blocs/remove_house/remove_house_bloc.dart";
import "package:broker_app/feauters/houses/presentation/blocs/remove_house/remove_house_event.dart";
import "package:broker_app/feauters/houses/presentation/blocs/remove_house/remove_house_state.dart";
import "package:flutter/material.dart";
import 'dart:io';

import "package:flutter_bloc/flutter_bloc.dart";

class HouseDetail extends StatelessWidget {
  late House houseModel;
  HouseDetail({super.key, required this.houseModel});

  @override
  Widget build(BuildContext context) {
    var location = houseModel.location.displayName.split("/")[0];
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    BuildContext newContext = context;
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: height,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(70)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(70)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: height / 2,
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
                          images: houseModel.Images.map(
                            (image) {
                              return Image(
                                image: FileImage(File(image.imageUrl)),
                                fit: BoxFit.cover,
                                opacity: houseModel.rentalStatus==1?AlwaysStoppedAnimation(0.5):null,
                              );
                            },
                          ).toList()),
                    ),
                    houseModel.rentalStatus==1? Icon(Icons.lock,size: 30,color: Colors.amber[400],):SizedBox(height: 0,),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(20)),
                      color: Colors.black),
                  child: IconButton(
                    icon: Icon(Icons.arrow_circle_left_outlined),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pushNamed("/homePage");
                    },
                  ),
                )),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                  width: width,
                  height: height / 2,
                  decoration: BoxDecoration(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 17,
                              ),
                              Expanded(
                                  child: Text(location,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 17,
                              ),
                              Expanded(
                                  child: Text(
                                houseModel.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 17,
                              ),
                              Text(
                                '${houseModel.price.toString()} ETB',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 17,
                              ),
                              Text(
                                '${houseModel.numberOfRooms.toString()} rooms ',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/edit-house",
                                  arguments: houseModel);
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(300, 30),

                              backgroundColor: Colors
                                  .blueGrey, // Change the background color here
                            ),
                            child: Text("Edit House",
                                style: TextStyle(color: Colors.white))),
                        SizedBox(
                          height: 10,
                        ),
                        BlocConsumer<ChangeRentalStausBloc,ChangeRentalStatusState>(
                          listener: (context,state){
                            if(state is ChangeRentalStatusSuccess){
                              Navigator.of(context).pushNamed("/homePage");
                            }
                          },
                          builder: (context,state) {
                            return Column(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<ChangeRentalStausBloc>(context).add(ChangeRentalStatusEvent(id: houseModel.houseId));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(300, 30),
                                
                                      backgroundColor: Colors
                                          .blueGrey, // Change the background color here
                                    ),
                                    child: state is ChangingRentalStatus? CircularProgressIndicator(): houseModel.rentalStatus==0?Text("House is not avaliable",
                                        style: TextStyle(color: Colors.white)):Text("House is avaliable",
                                        style: TextStyle(color: Colors.white))),
                              SizedBox(
                                height: 2,
                              ),
                              state is ChangeRentalStatusFailed
                                  ? Center(
                                      child: Text(
                                        "Unable to change house rental status",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    )
                              ],
                            );
                          }
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BlocConsumer<RemoveHouseBloc, RemoveHouseState>(
                            listener: (context, state) {
                          if (state is RemovingHouseSuccess) {
                            Navigator.pushNamed(context, "/homePage");
                          }
                        }, builder: (context, state) {
                          return Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    print(houseModel.houseId);
                                    BlocProvider.of<RemoveHouseBloc>(context)
                                        .add(RemoveHouseEvent(
                                            id: houseModel.houseId));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(300, 30),
                                    backgroundColor: Colors
                                        .redAccent, // Change the background color here
                                  ),
                                  child: state is RemovingHouse
                                      ? CircularProgressIndicator()
                                      : Text(
                                          "Delete House",
                                          style: TextStyle(color: Colors.white),
                                        )),
                              SizedBox(
                                height: 10,
                              ),
                              state is RemovingHouseFailed
                                  ? Center(
                                      child: Text(
                                        "House deletion failed",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    )
                            ],
                          );
                        }),
                      ])),
            )
          ],
        ),
      )),
    );
  }
}
