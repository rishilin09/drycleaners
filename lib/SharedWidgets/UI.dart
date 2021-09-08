/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';*/

import 'package:drycleaners/projectImports.dart';

///This widget will be UI widget used in LoginPage, RegisterPage and in DetailsPage
Widget widgetUI(pageTitle, textTop, top, right, imgH, imgStr) {
  return Stack(
    children: <Widget>[
      ///Text for the Page
      Padding(
        padding: EdgeInsets.only(top: textTop, left: 32.w),
        //60.h-DetailsPage //50.h-Login and Register
        child: Container(
          child: Text(
            pageTitle,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36.sp,
            ),
          ),
        ),
      ),

      ///SVG Image for Page
      Padding(
        padding: EdgeInsets.only(top: top, right: right),
        child: Container(
          height: imgH,
          width: 285.w,
          child: SvgPicture.asset(imgStr //ImageStrings.loginimg,
              ),
        ),
      ),
    ],
  );
}
