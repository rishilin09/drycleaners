/*import 'package:drycleaners/Models/user.dart';
import 'package:drycleaners/Services/Database.dart';
import 'package:drycleaners/SharedWidgets/CircleUI.dart';
import 'package:drycleaners/Services/QrProcessing.dart';
import 'package:drycleaners/SharedWidgets/Qrcode.dart';
import 'package:drycleaners/SharedWidgets/UI.dart';
import 'package:drycleaners/config/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';*/

import 'package:drycleaners/projectImports.dart';

///This page will show Details of the current User like FullName Email and PhoneNumber and QRCode
class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final QrProcessing qr = QrProcessing();
  final GlobalKey _key = GlobalKey();
  bool isuploaded = false;

  @override
  Widget build(BuildContext context) {
    ///Accessing Current User Details
    final user = Provider.of<UserUID?>(context);

    ///Building User Details from StreamBuilder function of type UserData which will build the page with
    ///details of the user. UID of the current user is been accessed from the user variable which is been
    ///initialized with Provider class which provides a stream of current user-UID having type UserUID?.
    return StreamBuilder<UserData>(
        stream: DataBaseServices(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ///Current User Data is accessed from Cloud_Storage
            UserData? userData = snapshot.data;

            ///FullName is retrieved
            String fullName = userData!.fullName;

            ///Email is retrieved
            String email = userData.email;

            ///PhoneNumber is been retrieved and is been converted to string
            String phoneNumber = (userData.phoneNumber).toString();

            ///String is been created for creation of Barcode
            final qrcode =
                'FullName:$fullName\nEmail:$email\nPhone-Number:$phoneNumber';

            ///List of Maps having key as String Datatype and value as dynamic datatype.
            ///This variable will be useful in the creation of design for user details.
            final List<Map<String, dynamic>> _details = [
              {
                'Title': Strings.fullName,
                'Icon': ProjectIcons.fullNameIcon,
                'SubTitle': fullName,
              },
              {
                'Title': Strings.email,
                'Icon': ProjectIcons.emailIcon,
                'SubTitle': email,
              },
              {
                'Title': Strings.phoneNumber,
                'Icon': ProjectIcons.phoneNumberIcon,
                'SubTitle': phoneNumber,
              }
            ];

            return Scaffold(
              body: Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight,
                child: Stack(
                  children: <Widget>[
                    ///Circle UI
                    CircleUI(),

                    ///AppBar
                    AppBar(
                      backgroundColor: Colors.transparent,
                      //automaticallyImplyLeading: false,
                      elevation: 0.0,
                      leading: pop(),
                    ),

                    ///Image and Title
                    widgetUI(Strings.details, 60.h, 100.h, 0.w, 100.h,
                        ImageStrings.profileDetailsImg),

                    ///User Details
                    cardDetails(_details),

                    ///User Barcode
                    barcodeCard(qrcode, fullName, user),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                color: ProjectColors.primary,
              ),
              child: SpinKitWanderingCubes(
                color: Colors.white,
                size: 50.h,
              ),
            );
          }
        });
  }

  ///Pop Page
  Padding pop() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: IconButton(
        onPressed: () {
          ///Navigation back to HomePage
          Navigator.pop(context);
        },
        icon: ProjectIcons.popIcon,
        color: ProjectColors.primary,
        iconSize: 30.sp,
      ),
    );
  }

  ///Barcode Image
  Container barcodeCard(qrcode, fullName, user) {
    return Container(
      margin: EdgeInsets.only(top: 423.h, bottom: 5.h),
      height: 225.h,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(5.sp),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp),
            side: BorderSide(width: 2.sp, color: ProjectColors.primary)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ///RepaintBoundary will help to convert User Barcode to Imageformat which further will be uploaded
            RepaintBoundary(
              key: _key,

              ///This function will create QRCode image.
              child: qrImage(qrcode, 150.sp),
            ),

            ///Your Barcode Text
            Text(
              Strings.barcode,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: ProjectColors.primary,
              ),
            ),

            ///Upload Barcode Image
            SizedBox(
              height: 30.h,
              child: isuploaded
                  ? const SizedBox.shrink()
                  : ElevatedButton.icon(
                      onPressed: () async {
                        ///QRImage with user details will be uploaded to Firebase Storage
                        await qr.uploadImage(fullName, _key);

                        ///URL of the QRImage will be retrieved
                        final url = await qr.qrURL(fullName);

                        ///URL will be stored in respective document of the user
                        await DataBaseServices(uid: user!.uid)
                            .updateQRString(url);

                        setState(() {
                          isuploaded = true;
                        });

                        ///Text Creation for SnackBar
                        final snackBar = SnackBar(
                          content: const Text(Strings.barcodeUploaded),
                          backgroundColor: Colors.black,
                        );

                        ///SnackBar Creation
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: ProjectIcons.uploadIcon,
                      label: Text(
                        Strings.upload,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  ///Listview.builder will build a list for all details of the current user with the help of _details variable
  ///which was initialized before.
  Container cardDetails(details) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 180.h),
      child: ListView.builder(
        itemCount: details.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(4.sp),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.sp),
                side: BorderSide(width: 2.sp, color: ProjectColors.primary)),
            child: Container(
              height: 65.h,
              child: ListTile(
                leading: details[index]['Icon'],

                ///Icon
                title: Text(
                  details[index]['Title'],

                  ///Title
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: ProjectColors.primary,
                  ),
                ),
                subtitle: Text(
                  details[index]['SubTitle'],

                  ///SubTitle
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
