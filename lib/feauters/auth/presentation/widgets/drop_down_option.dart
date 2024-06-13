import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<dynamic> items;

  String? header;
  String? value;
  String? hintText;
  String? temp;
  IconData? leadIcon;
  String? initalSelection;
  final Function(String?)? onChanged;
  CustomDropdownButton(
      {Key? key,
      this.header,
      required this.items,
      required this.value,
      required this.hintText,
      required this.onChanged,
      required this.initalSelection,
      this.leadIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: DropdownMenu<String>(
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 187, 148,
                        48)), // Set border color for focused state
              ),
            ),
            initialSelection: initalSelection,
            menuStyle: MenuStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 245, 220, 158)),
            ),
            menuHeight: 250,
            leadingIcon: Icon(
              leadIcon,
              color: const Color.fromARGB(255, 187, 148, 48),
            ),
            width: screenWidth * 0.5,
            hintText: hintText!,
            dropdownMenuEntries: _buildDropdownItems(items),
            onSelected: onChanged),
      ),
    );
  }

  List<DropdownMenuEntry<String>> _buildDropdownItems(
      List<dynamic> dropdownValues) {
    return dropdownValues.map((item) {
      String key = item is Map
          ? item.keys.first
          : item; // Assuming each map has only one key
      return DropdownMenuEntry<String>(
        value: key,
        label: key,
      );
    }).toList();
  }
}
