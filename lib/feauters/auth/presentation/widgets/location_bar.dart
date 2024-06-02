import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/location.dart';
import '../blocs/location/locations.dart';

class LocationBar extends StatelessWidget {
  Timer? _debounce;
  final width;
  TextEditingController _controller = TextEditingController();
  final void Function(Location location) getLocation;
  final choosenLocation;
  LocationBar(
      {required this.getLocation,
      required this.width,
      required this.choosenLocation});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on_outlined),
                  prefixIconColor: Colors.amber,
                  hintText:
                      choosenLocation == null ? 'Address...' : choosenLocation,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.grey), // Set border color for enabled state
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.amber), // Set border color for focused state
                  ),
                ),
                onChanged: (query) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();

                  if (query.isEmpty) {
                    BlocProvider.of<LocationBloc>(context).add(ClearSearch());
                  } else {
                    _debounce = Timer(const Duration(milliseconds: 300), () {
                      BlocProvider.of<LocationBloc>(context)
                          .add(SearchEvent(query: query));
                    });
                  }
                },
              ),
            ),
          ),
          if (state is LoadLocations)
            Container(
              constraints: BoxConstraints(
                maxHeight: 200, // Limit the height of the dropdown
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.separated(
                itemCount: state.locations.length,
                separatorBuilder: (context, index) => Divider(
                    height: 1, color: const Color.fromARGB(255, 236, 231, 231)),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.location_on_outlined),
                    title: Text(state.locations[index].displayName),
                    onTap: () {
                      _controller.text = state.locations[index].displayName;
                      getLocation(state.locations[index]);
                      print(state.locations[index].displayName);
                      BlocProvider.of<LocationBloc>(context).add(ClearSearch());
                    },
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: index == 0 ? Radius.circular(8.0) : Radius.zero,
                        bottom: index == state.locations.length - 1
                            ? Radius.circular(8.0)
                            : Radius.zero,
                      ),
                    ),
                  );
                },
              ),
            ),
          if (state is NoMatch)
            Container(
              constraints: BoxConstraints(
                maxHeight: 50, // Limit the height of the dropdown
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.location_off_outlined,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "No matches found",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )
                ]),
              ),
            )
        ],
      );
    });
  }
}
