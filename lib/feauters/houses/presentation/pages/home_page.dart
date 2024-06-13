
import 'package:broker_app/feauters/houses/presentation/blocs/get_house/get_house_bloc.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/get_house/get_house_event.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/get_house/get_house_state.dart';
import 'package:broker_app/feauters/houses/presentation/widgets/house_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetHouseBloc>(context).add(InitialEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text("House List"),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(212, 175, 55,1),

      ),
      drawer: Drawer(
        backgroundColor: Colors.white70,
          child: ListView(
              children:  [
                SizedBox(height: 35),

                SizedBox(height: 25,),
                ListTile(

                  leading: Icon(Icons.settings),
                  title: Text("Setting", style: TextStyle(fontSize: 13),),
                ),

                ListTile(

                  leading: Icon(Icons.color_lens),
                  trailing: Icon(Icons.toggle_off_outlined),
                  title: Text("Theme", style: TextStyle(fontSize: 13)),
                ),
                ListTile(

                  leading: Icon(Icons.help),
                  title: Text("Help", style: TextStyle(fontSize: 13)),
                ),
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/change-password");
                    // scaffoldKey.currentState!.openEndDrawer();
                  },

                  leading: Icon(Icons.key),
                  title: Text("Change Credentials", style: TextStyle(fontSize: 13)),
                ),

                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/give-feedback");
                    // scaffoldKey.currentState!.openEndDrawer();
                  },

                  leading: Icon(Icons.feedback_sharp),
                  title: Text("Feedback and rate", style: TextStyle(fontSize: 13)),
                ),

              ])),
          body: BlocBuilder<GetHouseBloc, GetHouseState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is HouseLoadSuccess){
            print(state.houses);
            var houses=state.houses;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14.0,
                    mainAxisSpacing: 14.0,
                    mainAxisExtent: 150
                  ),
                itemCount: houses.length,
                  itemBuilder: (context, index){
                    return GestureDetector
                      (onTap: (){
                        Navigator.of(context).pushNamed("/houseDetail", arguments: houses[index]);
                    },
                        child: HouseCard(house:houses[index])
                    );
                  }
              ),
            );
          }
          else{
            return Center(child: Text("error"));
          }
          }
    ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, "/add-house");
            },
            backgroundColor:Color.fromRGBO(244, 196, 48,0.9),
            child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

}