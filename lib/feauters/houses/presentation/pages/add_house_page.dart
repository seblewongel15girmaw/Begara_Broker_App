import 'package:broker_app/core/util/validators.dart';
import 'package:broker_app/feauters/auth/presentation/widgets/custom_text_field.dart';
import 'package:broker_app/feauters/auth/presentation/widgets/location_bar.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/create_house/create_house_bloc.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/create_house/create_house_event.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/create_house/create_house_state.dart';
import 'package:broker_app/feauters/houses/presentation/widgets/custom_text_area.dart';
import 'package:broker_app/feauters/houses/presentation/widgets/picture_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../auth/domain/entities/location.dart';

class AddHousePage extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  List<XFile> images = [];
  XFile? finalImage = null;
  Location? address;
  final TextEditingController numberRooms = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final newContext = context;
    bool onChange = false;
    final size = MediaQuery.of(context).size;
    final ValueNotifier<int> _notifier = ValueNotifier<int>(0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(212, 175, 55,1),
        title: Text("Add house"),
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
                size: size),
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
                      width: size.width,
                      choosenLocation: null),
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
                    BlocProvider.of<CreateHouseBloc>(context).add(
                        CreateHouseEvent(
                            location: address!,
                            price: double.parse(price.text),
                            numberOfRoom: int.parse(numberRooms.text),
                            description: description.text,
                            images: images));
                  }
                },
                child: BlocConsumer<CreateHouseBloc,CreateHouseState>(
                  listener: (context,state){
                    if(state is CreateHouseSuccess){
                      Navigator.pushNamed(context, "/homePage");
                    }
                  },
                  builder: (context,state) {
                    
                    return Container(
                      height: 50,
                      color: Color.fromARGB(255, 187, 148, 48),
                      child: Center(
                        child: state is CreatingHouse?CircularProgressIndicator():state is CreateHouseSuccess? Text("Success"): Text("Add House"),
                      ),
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
}
