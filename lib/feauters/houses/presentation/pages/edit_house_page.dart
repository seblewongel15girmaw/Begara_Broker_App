import 'package:broker_app/core/util/validators.dart';
import 'package:broker_app/feauters/auth/presentation/widgets/custom_text_field.dart';
import 'package:broker_app/feauters/auth/presentation/widgets/location_bar.dart';
import 'package:broker_app/feauters/houses/data/model/house_model.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/create_house/create_house_bloc.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/create_house/create_house_event.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/create_house/create_house_state.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/edit_house/edit_house_bloc.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/edit_house/edit_house_event.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/edit_house/edit_house_state.dart';
import 'package:broker_app/feauters/houses/presentation/widgets/custom_text_area.dart';
import 'package:broker_app/feauters/houses/presentation/widgets/picture_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../auth/domain/entities/location.dart';
import '../../domain/entities/house.dart';

class EditHousePage extends StatelessWidget {
  final House house;
  EditHousePage(this.house);
  final formkey = GlobalKey<FormState>();
  List<XFile> images = [];
  XFile? finalImage = null;
  Location? address;
  final TextEditingController numberRooms = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    images=house.Images.map((images)=>XFile(images.imageUrl)).toList();
    finalImage=images.last;
    numberRooms.text=house.numberOfRooms.toString();
    price.text=house.price.toString();
    description.text= house.description;
    address= house.location;
    final newContext = context;
    bool onChange = false;
    final size = MediaQuery.of(context).size;
    final ValueNotifier<int> _notifier = ValueNotifier<int>(0);
    return LayoutBuilder(
      builder: (context,constraints) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(212, 175, 55,1),
            title: Text("Edit house"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                PictureFrame(
                    newContext: newContext,
                    onChange: onChange,
                    finalImage: finalImage,
                    images: images,
                    notifier: _notifier,
                    size: constraints),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      LocationBar(
                          getLocation: (location) {
                            address = location;
                          },
                          width: constraints.maxWidth,
                          choosenLocation: house.location.displayName),
                      CustomTextField(
                          textController: numberRooms,
                          label: "Number Of Rooms",
                          validator: ageValidator),
                      CustomTextField(
                          textController: price,
                          label: "Price",
                          validator: budgetValidator),
                      CustomTextArea(description: description),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<EditHouseBloc>(context).add(
                            EditHouseEvent(
                                houseId: house.houseId,
                                location: address!,
                                price: double.parse(price.text),
                                numberOfRoom: int.parse(numberRooms.text),
                                description: description.text,
                                images: images));
                      }
                    },
                    child: BlocConsumer<EditHouseBloc,EditHouseState>(
                      listener: (context,state){
                        if(state is EditingHouseSuccess){
                          Navigator.pushNamed(context, "/homePage");
                        }
                      },
                      builder: (context,state) {
                        return Column(
                          children: [
                            Container(
                              height: 50,
                              color: Color.fromARGB(255, 187, 148, 48),
                              child: Center(
                                child: state is EditingHouse?CircularProgressIndicator():Text("Edit House"),
                              ),
                            ),
                            SizedBox(height: 5,),
                            state is EditingHouseFailed? Center(child: Text("edit house failed", style: TextStyle(color: Colors.red),),) :
                            SizedBox(height: 0,)
                          ],
                        );
                      }
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
