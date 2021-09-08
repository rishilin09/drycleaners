/*import 'package:drycleaners/Models/user.dart';
import 'package:drycleaners/Screens/Authentication/Authenticate.dart';
import 'package:drycleaners/Screens/Home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';*/

import 'package:drycleaners/projectImports.dart';

///This class will catch the provided values from StreamProvider in main.dart file
///and will check if the user is null. If it is null then it will navigate to Authenticate.dart file
///through Authenticate function else if it is not null that means user has either been newly Register or
///Signed In. It will then Navigate to Homepage through HomePage function
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
