/*import 'package:drycleaners/Models/user.dart';
import 'package:drycleaners/Screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:drycleaners/Services/Auth.dart';*/

import 'package:drycleaners/projectImports.dart';

void main() async {
  ///This will help to bind all the widgets used in the project
  WidgetsFlutterBinding.ensureInitialized();

  ///Functions related to Firebase will get initialize in the app
  await Firebase.initializeApp();

  ///Root of the Project
  runApp(MyApp());
}

///This class will be the root of the project and also has a MultiProvider widget for StreamProvider
///and ChangeNotifierProvider.StreamProvider will basically provide a stream of changes for the user
///like Signing In or Signing Out and will rebuild the whole app. ChangeNotifierProvider will provide
///updates to the state of the SelectionPage() in lib->Screens->SelectionPage.dart.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => StreamProvider<UserUID?>(
        create: (_) => AuthService().user,
        initialData: UserUID(uid: 'No User Found'),
        child: MaterialApp(
          title: 'Drycleaners',
          theme: ThemeData(fontFamily: 'Ubuntu'),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
      designSize: const Size(360, 640),
    );
  }
}
