import 'package:drycleaners/Screens/FinalPage.dart';
import 'package:drycleaners/SharedWidgets/CircleDiagonal.dart';
import 'package:drycleaners/projectImports.dart';

class TransactionPage extends StatelessWidget {

  final List<Map<String, dynamic>> paymentMethods = [
    {'method': 'Net Banking', 'image': ImageStrings.netBanking},
    {'method': 'Debit or Credit cards', 'image': ImageStrings.card},
    {'method': 'UPI', 'image': ImageStrings.upi},
    {'method': 'Cash', 'image': ImageStrings.cash},
  ];

  @override
  Widget build(BuildContext context) {

    final items = ModalRoute.of(context)!.settings.arguments as Items;
    final total = items.total;

    return Scaffold(
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: Stack(
          children: <Widget>[
            CircleDiagonal(leftRight: 250.w, topBottom: 530.h),
            buildPageTexts(total),
            texts(Strings.selectPayMethod, 16.sp, 160.h, 20.w),
            buildAppBar(context),
            payMethod(items),
          ],
        ),
      ),
    );
  }

  Container payMethod(Items items) {
    return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 165.h),
            child: ListView.builder(
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 85.h,
                    child: Card(

                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: ProjectColors.primary, width: 0.5),
                          borderRadius: BorderRadius.circular(5)),
                      child: Theme(
                        data: ThemeData(
                          highlightColor: ProjectColors.dprimary,
                          fontFamily: 'Ubuntu',
                        ),
                        child: ListTile(

                          contentPadding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 15.h),
                          selectedTileColor: ProjectColors.primary,
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FinalPage(),
                                    settings: RouteSettings(
                                        arguments: [items, paymentMethods[index]['method']]
                                    )
                                )
                            );
                          },
                          title: Text(
                              paymentMethods[index]['method']
                          ),
                          leading: Container(
                            width: 60.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    paymentMethods[index]['image']),
                              ),
                            ),
                          ),
                          trailing: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15.sp),
                                  bottomRight: Radius.circular(15.sp)),
                              color: ProjectColors.primary,
                            ),
                            width: 10.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
  }

  Column buildPageTexts(double total) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(alignment: Alignment.center,child: texts('PAY',20.sp,50.h,0.w)),
              Align(alignment: Alignment.center,child: texts('Rs $total',40.sp,20.h,0.w)),
            ],
          );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: ProjectIcons.popIcon,
              color: ProjectColors.primary,
              iconSize: 30.sp,
            ),
          );
  }

  Widget texts(text, fSize, top, left) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: left),
      child: Text(
        text,
        style: TextStyle(fontSize: fSize, fontWeight: FontWeight.bold),
      ),
    );
  }

}
