/*import 'package:drycleaners/Screens/Authentication/LoginPage.dart';
import 'package:drycleaners/Screens/Authentication/RegisterPage.dart';
import 'package:flutter/material.dart';*/

import 'package:drycleaners/projectImports.dart';

///This class will be called if the stream is null.
///It will decide whether to toggle to LogInPage or to RegisterPage
///with the help of toggleView function. toggleView function changes states
///of boolean value 'showSignIn' whenever it is called. showSignIn is declared
///and initialized as true in this class, so that it will always navigate to
///login page whenever stream is null. If the value(state) of the 'showSignIn'
///gets change and if it yields as false then it will be navigate to RegisterPage.
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LogInPage(toggleView: toggleView);
    } else {
      return RegisterPage(toggleView: toggleView);
    }
  }
}
