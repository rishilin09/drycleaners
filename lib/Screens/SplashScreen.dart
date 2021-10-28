/*import 'dart:async';
import 'package:drycleaners/Screens/Wrapper.dart';
import 'package:drycleaners/config/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';*/

import 'package:drycleaners/projectImports.dart';

///This class is a SplashScreen which will seen for 5 seconds when the app gets started
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  ///initState() will run only once in the whole widget tree of SplashScreen class.
  ///It is very similar to Java start() which runs only once in the whole program.
  @override
  void initState() {
    super.initState();
    _timer = Timer(
        Duration(seconds: 5),

        ///pushReplacement will push the provided Widget('Wrapper()') in the
        ///replacement of the previous Widget('SplashScreen()') and context will also
        ///get shifted.
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Wrapper())));
  }

  ///dispose() method will be run at last when the context is shifted or being killed.
  ///It is very similar to Java destroy() which runs at the end of the program.
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        decoration: BoxDecoration(
          gradient: gradientLayout,
        ),
        child: Stack(
          children: <Widget>[
            //Wandering Cubes Animation
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(51.w, 425.h, 52.w, 110.h),
                child: SpinKitChasingDots(
                  color: Colors.white,
                  size: 50.w,
                ),
              ),
            ),

            //Title
            Center(
              widthFactor: 2.57,
              heightFactor: 4.1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(51.w, 389.h, 52.w, 210.h),
                child: Container(
                  child: Text(
                    Strings.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36.sp,
                      //fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ),

            //Circle
            Center(
              heightFactor: 2.5,
              widthFactor: 2.5,
              child: Padding(
                padding: EdgeInsets.fromLTRB(55.w, 120.h, 55.w, 270.h),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 4.w,
                    ),
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            //Logo image
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(105.w, 170.h, 105.w, 320.h),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/laundry.png'),
                    fit: BoxFit.fitWidth,
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
