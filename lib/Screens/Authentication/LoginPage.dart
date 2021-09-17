/*import 'package:drycleaners/Services/Auth.dart';
import 'package:drycleaners/SharedWidgets/CircleUI.dart';
import 'package:drycleaners/SharedWidgets/Loading.dart';
import 'package:drycleaners/SharedWidgets/UI.dart';
import 'package:drycleaners/SharedWidgets/TextFormFieldUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:drycleaners/config/styling.dart';*/

import 'package:drycleaners/projectImports.dart';
import 'package:form_field_validator/form_field_validator.dart';

///This Class will show LoginPage for users if account is already been registered
class LogInPage extends StatefulWidget {
  final Function toggleView;

  LogInPage({required this.toggleView});

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  ///Declarations and Initializations
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String error = '';
  bool _passwordVisible = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    ///Error Text modifications
    final midPoint = error.isNotEmpty ? error.lastIndexOf('Internet') : 0;
    String invalidError = error.isNotEmpty ? error.substring(0,midPoint) : '';
    String connectionError = error.isNotEmpty ? error.substring(midPoint,error.length) : '';

    ///If loading yields to be true then it will be redirected to Loading function in Loading.dart file
    ///else if it is false then Login Page will be displayed. This will happen when user has inputted
    ///some wrong values and it doesn't get authorized.
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight,
                child: Form(
                  key: _formkey,
                  child: Stack(
                    children: <Widget>[
                      ///Circle design UI
                      CircleUI(),

                      ///Image and Title
                      widgetUI(Strings.login, 50.h, 140.h, 0.w, 170.h,
                          ImageStrings.loginimg),

                      ///Login UI design
                      loginBuild(invalidError,connectionError),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Stack loginBuild(invalidError,connectionError) {
    return Stack(
      children: [
        ///Email TextFormField
        Padding(
          padding: EdgeInsets.only(top: 330.h, left: 27.w, right: 27.w),
          child: Container(
            width: 300.w,
            child: TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: Strings.email,
                  prefixIcon: ProjectIcons.emailIcon,
                  errorStyle: TextStyle(fontSize: 12.sp, height: 0.5.h)),
              validator: MultiValidator([
                RequiredValidator(errorText: Strings.rEmail),
                EmailValidator(errorText: Strings.eEmail),
              ]),
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
          ),
        ),

        ///Password TextFormField
        Padding(
          padding: EdgeInsets.only(top: 410.h, left: 27.w, right: 27.w),
          child: Container(
            width: 300.w,
            child: TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: Strings.password,
                  prefixIcon: ProjectIcons.prefixPasswordIcon,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    icon: Icon(_passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  errorStyle: TextStyle(fontSize: 12.sp, height: 0.5.h)),
              validator: MultiValidator([
                RequiredValidator(errorText: Strings.rPassword),
                MinLengthValidator(8, errorText: Strings.ePassword),
              ]),
              obscureText: _passwordVisible,
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
          ),
        ),

        ///Login button
        Positioned(
          top: 520.h,
          left: 133.w,
          child: ElevatedButton.icon(
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                setState(() => loading = true);
                dynamic result =
                    await _auth.signInWithEmailAndPassword(email, password);
                if (result == null) {
                  setState(() {
                    error = 'Username/Password is incorrect or Internet Connection might not be initialized';
                    loading = false;
                  });
                }
              }
            },
            icon: ProjectIcons.loginIcon,
            label: Text(Strings.login),
            style: ElevatedButton.styleFrom(
              primary: ProjectColors.buttonColor,
            ),
          ),
        ),

        ///Error Text
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: 480.h),
            child: Column(
              children: [
                Text(
                  invalidError,
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
                Text(
                  connectionError,
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ),

        ///Registration Toggle
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
              top: 530.h,
            ),
            child: TextButton(
              onPressed: () => widget.toggleView(),
              child: Text(Strings.registration),
            ),
          ),
        ),
      ],
    );
  }
}
