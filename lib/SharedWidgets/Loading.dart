/*import 'package:drycleaners/config/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';*/

import 'package:drycleaners/projectImports.dart';

///This class will build loading page after User Signs In or User gets newly register
class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradientLayout,
      ),
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.h,
        ),
      ),
    );
  }
}