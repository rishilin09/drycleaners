/*import 'package:drycleaners/Services/;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:drycleaners/config/styling.dart';
import 'package:provider/provider.dart';*/

import 'package:drycleaners/projectImports.dart';
import 'package:drycleaners/Screens/FinalPage.dart';

///This class will provide values for the SelectionPage class using ChangeNotifierProvider function
///which creates a provider of class PayingServices() in lib->Services->SelectionLogic.dart file
/// where all paying related methods and variables are declared.
class SelectionProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PayingServices(),
      child: SelectionPage(),
    );
  }
}

///SelectionProvider ==> Parent providing class for SelectionPage
///SelectionPage ==> SelectionProvider's Child that will catch provided values

///This class will catch the provided values from ChangeNotifierProvider which is
///defined is SelectionProvider class.
///This class will let users select how many clothes and which type of
///clothes they want to give for the service. This class will be update
///the state of the page frequently when user adds value (N.o of clothes)
///to TextField. Changes in values will be seen in the ElevatedButton Widget
class SelectionPage extends StatefulWidget {
  const SelectionPage();

  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  static bool isDryCleaning = false;

  ///TextEditingController to control the user input if empty.
  final _shirtValidate = TextEditingController();
  final _trouserValidate = TextEditingController();
  final _sareeValidate = TextEditingController();

  ///To Display error message
  String error = '';

  ///To refresh the controller for new use. It will run at the end
  @override
  void dispose() {
    _shirtValidate.dispose();
    _trouserValidate.dispose();
    _sareeValidate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///This variable will help to determine which option was selected
    ///in the HomePage by passing the settings and arguments parameters while
    ///navigating from HomePage to SelectionPage
    final service = ModalRoute.of(context)!.settings.arguments;
    final counter = Provider.of<PayingServices>(context);

    ///Bool variable for checking if service selected in HomePage is DryCleaning or not
    isDryCleaning = (service == 'DryCleaning') ? true : false;

    return Scaffold(
      ///SingleChildScrollView will help to adapt the overflow of keyboard while inputing values
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: Stack(
            children: <Widget>[
              ///AppBar & Decoration
              chooseWidgetUI(),

              ///Title
              textTitle(),

              ///errorText
              errorText(),

              ///ItemBuild
              itemBuild(counter),
              //,_shirtValidate,_trouserValidate,_sareeValidate

              ///Pay Button
              payButton(counter)
              //,_shirtValidate,_trouserValidate,_sareeValidate
            ],
          ),
        ),
      ),
    );
  }

  ///Decoration of TextFormField
  InputDecoration textInputDecoration = InputDecoration(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(38, 98, 199, 1.0),
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(2.sp),
    ),
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(2
          .sp), //circular(10.0),  const SelectionProvider({Key? key}) : super(key: key);
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(0, 56, 255, 1.0),
        width: 3.0,
      ),
      borderRadius: BorderRadius.circular(2.sp),
    ),
  );

  ///Title
  Padding textTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 103.h, left: 17.w),
      child: Container(
        child: Text(
          Strings.noOfClothes,
          style: TextStyle(
            fontSize: 30.sp,
          ),
        ),
      ),
    );
  }

  Widget errorText() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 370.h),
      child: Container(
        child: Text(
          error,
          style: TextStyle(fontSize: 16.sp, color: Colors.red),
        ),
      ),
    );
  }

  ///Selection List
  ///This function will listen to changes provided by PayingServices class which is in lib->Services->SelectionLogic.dart file.
  ///Due to 'final counter = Provider.of<PayingServices>(context);' variable, values
  ///for each shirt, trousers and saree will get updated everytime as user changes
  ///values in TextFormField and stored in respective variables in PayingServices class.
  Widget itemBuild(counter) {
    //,shirtValidate,trouserValidate,sareeValidate
    return Stack(
      children: [
        itemChoose(436.h, ImageStrings.sareeImg, counter, _shirtValidate),
        itemChoose(320.h, ImageStrings.trousersImg, counter, _trouserValidate),
        itemChoose(213.h, ImageStrings.shirtImg, counter, _sareeValidate),
      ],
    );
  }

  Widget itemChoose(
      top, img, PayingServices counter, TextEditingController tController) {
    return Padding(
      padding: EdgeInsets.only(top: top), //213.h),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            //Image
            Image.asset(img),

            //Multiply text
            Text(
              'X',
              style: TextStyle(
                fontSize: 36.sp,
                foreground: Paint()
                  ..style = PaintingStyle.stroke

                  ///Giving Color to Borders of text 'X'
                  ..strokeWidth = 1.sp

                  ///Width of the Stroke
                  ..color = ProjectColors.primary,
              ),
            ),

            //InputFields
            SizedBox(
              width: 150.w,
              child: TextField(

                  ///TextFormField
                  controller: tController,
                  textAlign: TextAlign.center,
                  decoration: textInputDecoration,
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    switch (img) {
                      case ImageStrings.shirtImg:

                        ///This will change values for n.o of shirts
                        ///everytime when value is changed
                        counter.shirtCalculate(val, isDryCleaning);
                        break;

                      case ImageStrings.trousersImg:

                        ///This will change values for n.o of trousers
                        ///everytime when value is changed
                        counter.trousersCalculate(val, isDryCleaning);
                        break;

                      default:

                        ///This will change values for n.o of sarees
                        ///everytime when value is changed
                        counter.sareeCalculate(val, isDryCleaning);
                    }
                  } //onChanged(val,isDryCleaning),
                  ),
            )
          ]),
    );
  }

  ///Pay Button
  ///This function will listen to changes provided by PayingServices class which is in lib->Services->SelectionLogic.dart file.
  ///Due to 'final counter = Provider.of<PayingServices>(context);' variable, total value
  ///for all clothes will be displayed. Total value will keep on updating when user will change values.
  Widget payButton(PayingServices counter) {
    //,TextEditingController shirtValidate,TextEditingController trouserValidate,TextEditingController sareeValidate
    return Positioned(
      left: 150.w,
      top: 531.h,
      right: 37.w,
      child: SizedBox(
        width: 80.w,
        height: 90.h,
        child: ElevatedButton(
          onPressed: () {
            final bool shirtV = _shirtValidate.text.isEmpty;
            final bool trouserV = _trouserValidate.text.isEmpty;
            final bool sareeV = _sareeValidate.text.isEmpty;
            if (shirtV && trouserV && sareeV) {
              setState(() {
                error = 'At least give input to one item';
              });
            } else {
              ///Navigation to FinalPage()
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FinalPage(),
                      settings: RouteSettings(
                          arguments: Items(
                              isDryCleaning: isDryCleaning,
                              total: counter.totalPay,
                              itemDetails: [
                            ItemDetails(
                                quantity: counter.noOfShirts,
                                priceX: counter.shirtPriceX,
                                totalUnitPrice: counter.totalShirtPay),
                            ItemDetails(
                                quantity: counter.noOfTrousers,
                                priceX: counter.trousersPriceX,
                                totalUnitPrice: counter.totalTrousersPay),
                            ItemDetails(
                                quantity: counter.noOfSarees,
                                priceX: counter.sareePriceX,
                                totalUnitPrice: counter.totalSareePay)
                          ]))));
            }
          },
          style: ElevatedButton.styleFrom(
              primary: ProjectColors.dsecondary,
              side: BorderSide(width: 3.w, color: ProjectColors.dprimary),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.sp))),
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Pay Text
                Text(
                  'Pay',
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                ),

                //Total Value
                Text(
                  ///This variable will update total values
                  'Rs ${counter.totalPay}',
                  style: TextStyle(
                    fontSize: 25.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Page UI
  Stack chooseWidgetUI() {
    return Stack(
      children: [
        ///Secondary Circle
        Positioned(
          left: 239.w,
          bottom: 504.h,
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
          right: 235.w,
          top: 504.h,
          child: Container(
            width: 250.w,
            height: 250.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ProjectColors.primary,
            ),
          ),
        ),

        ///AppBar
        AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
            color: ProjectColors.primary,
            iconSize: 30.sp,
          ),
        ),
      ],
    );
  }
}
