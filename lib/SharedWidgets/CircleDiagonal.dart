import 'package:drycleaners/projectImports.dart';

class CircleDiagonal extends StatelessWidget {

  final double leftRight;
  final double topBottom;

  CircleDiagonal({required this.leftRight, required this.topBottom});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///Secondary Circle
        Positioned(
          left: leftRight,//239.w,
          bottom: topBottom,//504.h,
          child: Container(
            width: 250.w,
            height: 250.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ProjectColors.secondary,
            ),
          ),
        ),

        ///Primary Circle
        Positioned(
          right: leftRight,//235.w,
          top: topBottom,//504.h,
          child: Container(
            width: 250.w,
            height: 250.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ProjectColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
