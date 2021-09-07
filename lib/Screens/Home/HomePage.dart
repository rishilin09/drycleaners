/*import 'package:drycleaners/Screens/SelectionPage.dart';
import 'package:drycleaners/Services/Auth.dart';
import 'package:drycleaners/config/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:drycleaners/Screens/Home/DetailsPage.dart';*/

import 'package:drycleaners/projectImports.dart';

///This class is the HomePage for the Project
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ///Declarations and Initializations
  final AuthService _auth = AuthService();
  final List<String> servicesList = [
    'Ironing',
    'DryCleaning',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          ///Logo and Backgorund
          homeLogo(),

          ///HomeBar
          homeBar(),

          ///Services List
          services(),

        ],
      ),
    );
  }

  ///HomePage AppBar
  Padding homeBar() {
    return Padding(
      padding: EdgeInsets.only(right: 15.w), //EdgeInsets.only(top: 10.h,right: 18.w),
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: [

          ///Navigation to DetailsPage
          Column(
            children: [
              CircleAvatar(
                foregroundColor: ProjectColors.primary,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {
                    ///Navigation to DetailsPage
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage()));
                  },
                  icon: Icon(Icons.people_alt_rounded),
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: Text(
                  Strings.details,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          ///Space Between the two Columns
          SizedBox(
            width: 15.w,
          ),

          ///Signing Out From Current Account
          Column(
            children: [
              CircleAvatar(
                foregroundColor: ProjectColors.primary,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: Icon(Icons.logout),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  Strings.logout,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///Services design function
  FractionallySizedBox services() {
    return FractionallySizedBox(
      child: Container(
        child: Stack(
          children: [

            ///Services Text
            Positioned(
              top: 316.h,
              left: 13.w,
              child: Text(
                Strings.services,
                style: TextStyle(
                  fontSize: 30.sp,
                ),
              ),
            ),

            ///List of Services
            Padding(
              padding: EdgeInsets.only(top: 367.h),
              ///To build ListView of Services
              child: ListView.builder(
                  itemCount: servicesList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Theme(
                        data: ThemeData(
                          highlightColor: ProjectColors.dprimary,
                          fontFamily: 'Ubuntu',
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(20.h),
                          selectedTileColor: ProjectColors.primary,
                          onTap: () {
                            ///Navigation to SelectionPage() with selected list as a argument,
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectionProvider(),
                                settings: RouteSettings(
                                  arguments: servicesList[index],
                                ),
                              ),
                            );
                          },
                          title: Text(servicesList[index]),
                          leading: Container(
                            width: 40.w,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  (servicesList[index] == 'Ironing')
                                      ? ImageStrings.ironImg
                                      : ImageStrings.washingImg,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),

          ],
        ),
      ),
    );
  }

  ///HomeLogo Design
  Container homeLogo() {
    return Container(
      height: 294.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: gradientLayout,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90.h)),
      ),
      child: Stack(
        children: [

          ///Creating Circle
          Padding(
            padding: EdgeInsets.only(top: 55.h, bottom: 50.h), //50.h,
            child: Container(
              height: 250.w,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 50.h, bottom: 50.h),
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

          ///Adding Image into Circle
          Padding(
            padding: EdgeInsets.fromLTRB(117.w, 86.h, 122.w, 82.h),
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(ImageStrings.laundryimg,
                  cacheWidth: 160.h.toInt(), cacheHeight: 160.h.toInt()),
            ),
          ),

        ],
      ),
    );
  }

}
