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

///This Class will show RegisterPage for users if account is not been registered
class RegisterPage extends StatefulWidget {
  final Function toggleView;

  RegisterPage({required this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  ///Declarations and Initializations
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String fullName = '';
  String email = '';
  String password = '';
  final String url = 'No URL';
  int phoneNumber = 0;
  String error = '';
  bool loading = false;
  bool _passwordVisible = true;
  var qrcode;

  @override
  Widget build(BuildContext context) {
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
                      ///Image and Title
                      widgetUI(Strings.register, 50.h, 110.h, 110.w, 110.h,
                          ImageStrings.registerimg),

                      ///Circle UI design
                      CircleUI(),

                      ///Registration text
                      loginInText(),

                      ///Login button
                      registerButton(),

                      ///Register Form Design
                      registerBuild(),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  ///Building Registration form
  Stack registerBuild() {
    return Stack(
      children: [
        ///FullName TextFormField
        Padding(
          padding: EdgeInsets.only(top: 230.h, left: 27.w, right: 27.w),
          child: Container(
            width: 300.w,
            //height: 70.h,
            child: TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: Strings.fullName,
                  prefixIcon: ProjectIcons.fullNameIcon,
                  errorStyle: TextStyle(fontSize: 12.sp, height: 0.5.h)),
              validator: RequiredValidator(errorText: Strings.rFullName),
              onChanged: (val) {
                setState(() => fullName = val);
              },
            ),
          ),
        ),

        ///Email TextFormField
        Padding(
          padding: EdgeInsets.only(top: 310.h, left: 27.w, right: 27.w),
          child: Container(
            width: 300.w,
            //height: 70.h,
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
          padding: EdgeInsets.only(top: 390.h, left: 27.w, right: 27.w),
          child: Container(
            width: 300.w,
            //height: 70.h,
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

        ///PhoneNumber TextFormField
        Padding(
          padding: EdgeInsets.only(top: 470.h, left: 27.w, right: 27.w),
          child: Container(
            width: 300.w,
            //height: 70.h,
            child: TextFormField(
              decoration: textInputDecoration.copyWith(
                hintText: Strings.phoneNumber,
                prefixIcon: ProjectIcons.phoneNumberIcon,
                errorStyle: TextStyle(fontSize: 12.sp, height: 0.5.h),
              ),
              validator: MultiValidator([
                RequiredValidator(errorText: Strings.rPhoneNumber),
                LengthRangeValidator(
                    min: 10, max: 10, errorText: Strings.ePhoneNumber),
              ]),
              onChanged: (val) {
                setState(() => phoneNumber = int.parse(val));
              },
            ),
          ),
        ),

        ///Error Text
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: 445.h),
            child: Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.sp),
            ),
          ),
        ),
      ],
    );
  }

  ///Register Button
  Positioned registerButton() {
    return Positioned(
      top: 550.h,
      left: 123.w,
      child: Container(
        alignment: Alignment.center,
        child: ElevatedButton.icon(
          onPressed: () => registerProcess(),
          icon: ProjectIcons.loginIcon,
          label: Text(Strings.register),
          style: ElevatedButton.styleFrom(
            primary: ProjectColors.buttonColor,
          ),
        ),
      ),
    );
  }

  ///LoginPage Toggle
  Positioned loginInText() {
    return Positioned(
      top: 590.h,
      left: 27.w,
      right: 27.w,
      child: Container(
        child: TextButton(
          onPressed: () => widget.toggleView(),
          child: Text(Strings.signIn),
        ),
      ),
    );
  }

  ///Registration Process
  ///This function will validate all the TextFormFields with help of '_formkey.currentState!.validate()'.
  ///Since we declared the key globally for all the FormFields it will check the currentState of each and
  ///every field combined. If the validation comes out to be true then state of loading variable will be
  ///changed to True and the registration process will be carried out by calling '_auth.registerWithEmailAndPassword'
  ///function which takes email,password,fullName and URL as the parameters. Since it is a await function it
  ///will wait for the process to be completed to proceed further. If the result of the function is null then
  ///error message will be thrown and the state of the loading will be set to false again. If it is not null
  ///then user will get register in FireBase and the 'AuthService().user' in main.dart file will start to
  ///stream UserUID object values which contains UID of the user. Wrapper() widget will catch the provided
  ///values and since user is not null it will redirect to HomePage() widget.
  registerProcess() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      dynamic result = await _auth.registerWithEmailAndPassword(
          email, password, fullName, phoneNumber, url);
      if (result == null) {
        setState(() {
          error = 'Please supply a valid details';
          loading = false;
        });
      }
    }
  }
}
