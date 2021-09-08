import 'package:drycleaners/projectImports.dart';

///InputDecoration for TextFormField used in Project
InputDecoration textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  //Color.fromRGBO(105, 159, 245, 0.3),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromRGBO(38, 98, 199, 1.0),
      width: 2.0,
    ),
  ),

  border: OutlineInputBorder(
    borderRadius: BorderRadius.zero, //circular(10.0),
  ),

  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
    color: Color.fromRGBO(0, 56, 255, 1.0),
    width: 3.0,
  )),
);
