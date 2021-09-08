/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:drycleaners/config/styling.dart';*/

import 'package:drycleaners/projectImports.dart';

///This class will provide Circular shapes for decoration
class CircleUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///Secondary circle
        Positioned(
          left: 180.w,
          bottom: 515.h,
          child: Container(
            width: 250.w,
            height: 250.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ProjectColors.dsecondary,
            ),
          ),
        ),

        ///Primary Circle
        Positioned(
          left: 253.w,
          bottom: 433.h,
          child: Container(
            width: 250.w,
            height: 250.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ProjectColors.dprimary,
            ),
          ),
        ),
      ],
    );
  }
}
