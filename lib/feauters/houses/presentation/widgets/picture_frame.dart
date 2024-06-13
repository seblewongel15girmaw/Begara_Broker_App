import 'dart:io';

import 'package:broker_app/feauters/houses/presentation/widgets/alert_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../auth/presentation/blocs/image/image.dart';

class PictureFrame extends StatelessWidget {
  final newContext;
  bool onChange;
  XFile? finalImage;
  final List<XFile> images;
  final ValueNotifier<int> notifier;
  final size;
  PictureFrame(
      {required this.newContext,
      required this.onChange,
      required this.finalImage,
      required this.images,
      required this.notifier,
      required this.size});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Stack(
            children: [
              BlocConsumer<ImageBloc, ImageState>(listener: (context, state) {
                if (state is ImageSelected && onChange == false) {
                  finalImage = state.image;
                  images.add(state.image!);
                  notifier.value = images.length;
                }
              }, builder: (context, state) {
                return Container(
                  height: size.height * 0.30,
                  decoration: BoxDecoration(
                      image: state is ImageSelected
                          ? DecorationImage(
                              image: FileImage(File(state.image!.path)),
                              fit: BoxFit.fill)
                          : DecorationImage(image: AssetImage("asset/image_place_holder.png"),fit: BoxFit.fill),
                      border: Border.all(
                        width: 2,
                        color: Color.fromARGB(255, 187, 148, 48),
                      )),
                );
              }),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                    onPressed: () {
                      if (images.length < 5) {
                        onChange = false;
                        BlocProvider.of<ImageBloc>(context).add(ProfileClicked());
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertBox(thisContext: newContext);
                            });
                      }
                    },
                    icon: Icon(Icons.camera)),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                      onPressed: () {
                        if (finalImage != null) {
                          if (images.length > 1) {
                            images.remove(finalImage);
                            notifier.value = images.length;
                            onChange = true;
                            BlocProvider.of<ImageBloc>(context)
                                .add(ImageSelect(image: images[images.length - 1]));
                            finalImage = images[images.length - 1];
                          } else if (images.length == 1) {
                            images.remove(finalImage);
                            notifier.value = images.length;
                            onChange = true;
                            BlocProvider.of<ImageBloc>(context).add(CleanImage());
                            finalImage = null;
                          }
                        }
                      },
                      icon: Icon(Icons.close)))
            ],
          ),
        ),
        SizedBox(
              height: 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ValueListenableBuilder(
                  valueListenable: notifier,
                  builder: (context, value, child) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 187, 148, 48),
                            width: 1), // Added border
                      ),
                      width: size.width,
                      height: 60,
                      child: GridView.builder(
                          itemCount: 5,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            if (index < images.length) {
                              return GestureDetector(
                                onTap: () {
                                  onChange = true;
                                  finalImage = images[index];
                                  BlocProvider.of<ImageBloc>(context)
                                      .add(ImageSelect(image: images[index]));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            Color.fromARGB(255, 187, 148, 48),
                                        width: 2,
                                      ),
                                      image: DecorationImage(
                                          image: FileImage(
                                              File(images[index].path)),
                                          fit: BoxFit.fill)),
                                ),
                              );
                            } else {
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  width: 1,
                                  color: Color.fromARGB(255, 187, 148, 48), 
                                ),
                                image: DecorationImage(image: AssetImage("asset/image_place_holder.png"),fit: BoxFit.fill),),
                              );
                            }
                          }),
                    );
                  }),
            ),
      ],
    );
  }
}
