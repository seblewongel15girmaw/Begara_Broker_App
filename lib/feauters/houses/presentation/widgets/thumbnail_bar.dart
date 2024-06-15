import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../auth/presentation/blocs/image/profile_image.dart/image.dart';

class ThumbnailBar extends StatelessWidget{
  final newContext;
    bool onChange;
    XFile? finalImage;
    final List<XFile> images;
    final ValueNotifier<int> notifier;
    final size;

    ThumbnailBar(
      {required this.newContext,
      required this.onChange,
      required this.finalImage,
      required this.images,
      required this.notifier,
      required this.size});
  @override
  Widget build(BuildContext context) {
    
    return Padding(
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
                                )),
                              );
                            }
                          }),
                    );
                  }),
            );
  }

}