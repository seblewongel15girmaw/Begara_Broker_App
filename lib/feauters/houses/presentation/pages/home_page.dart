
import 'package:broker_app/feauters/houses/presentation/blocs/get_house/get_house_bloc.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/get_house/get_house_event.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/get_house/get_house_state.dart';
import 'package:broker_app/feauters/houses/presentation/widgets/house_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/blocs/logout/logout.dart';

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
        backgroundColor: Color.fromRGBO(212, 175, 55,1),
          child: ListView(
              children:  [
                SizedBox(height: 90),
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/change-password");
                    // scaffoldKey.currentState!.openEndDrawer();
                  },

                  leading: Icon(Icons.key),
                  title: Text("Change Credentials", style: TextStyle(fontSize: 13)),
                ),

                BlocListener<LogoutBloc,LogOutState>(
                  listener: (context,state) {
                    if(state is LoggedOut)
                    {
                      Navigator.pushNamed(context, "/login");
                    }
                  },
                  child:  ListTile(
                    onTap: () {
                      BlocProvider.of<LogoutBloc>(context).add(LogoutEvent());
                    },
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    leading: Icon(Icons.logout),
                    title: Text("Sign Out", style: TextStyle(fontSize: 13)),
                                  ),
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
                         Navigator.of(context).pushNamed("/houseDetail", arguments: houses[index]);},
                    
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