/*import 'dart:ui';
import 'package:flutter/material.dart';*/
import 'package:flutter/cupertino.dart';
import 'package:drycleaners/projectImports.dart';

class ProjectColors {
  ProjectColors._();

  static Color primary = Color.fromRGBO(12, 85, 226, 1.0);
  static Color secondary = Color.fromRGBO(2, 209, 225, 0.8);
  static Color dprimary = Color.fromRGBO(12, 85, 226, 0.6);
  static Color dsecondary = Color.fromRGBO(2, 209, 225, 0.7);
  static Color buttonColor = Color.fromRGBO(33, 71, 196, 1.0);
}

class Strings {
  Strings._();

  static const title = 'DryCleaners';
  static const login = 'Login';
  static const invoice = 'Invoice';
  static const logout = 'LogOut';
  static const register = 'Register';
  static const details = 'Details';
  static const upload = 'Upload';
  static const email = 'Email';
  static const password = 'Password';
  static const fullName = 'FullName';
  static const phoneNumber = 'Phone Number';
  static const registration = 'Not a User? Create Account';
  static const signIn = 'Already a User?';
  static const fPassword = 'Forgot Password?';
  static const rEmail = 'Email is Required';
  static const rPassword = 'Password is Required';
  static const rPhoneNumber = 'PhoneNumber is Required';
  static const rFullName = 'FullName is required';
  static const eEmail = 'Enter valid email';
  static const ePassword = 'Enter a password between 8 and 15 characters';
  static const ePhoneNumber = 'Enter a 10-digit Number';
  static const services = 'Services offered';
  static const noOfClothes = 'Enter the no of the clothes';
  static const download = 'Download';
  static const successOrder = 'Your order has been placed successfully';
  static const barcodeUploaded = 'Your Barcode has been successfully uploaded';
  static const downloadInvoice = 'Download your Invoice';
  static const successRegister = 'You have successfully been register!!!';
  static const barcode = 'This is your Generated Barcode';
  static const orderPlaced = 'Order Placed for ';
  static const invoiceNumber = 'Invoice Number';
}

class ImageStrings {
  ImageStrings._();

  static const laundryimg = 'assets/images/laundry.png';
  static const loginimg = 'assets/images/login.svg';
  static const registerimg = 'assets/images/register.svg';
  static const confirmedimg = 'assets/images/confirmed.svg';
  static const ironImg = 'assets/images/iron.png';
  static const washingImg = 'assets/images/washing.png';
  static const shirtImg = 'assets/images/shirt.png';
  static const trousersImg = 'assets/images/trousers.png';
  static const sareeImg = 'assets/images/saree.png';
  static const saree1Img = 'assets/images/saree1.png';
  static const profileDetailsImg = 'assets/images/profileDetails.svg';
}

class ProjectIcons {
  ProjectIcons._();

  static const loginIcon = Icon(Icons.login);
  static const emailIcon = Icon(Icons.email_outlined);
  static const prefixPasswordIcon = Icon(Icons.vpn_key_outlined);
  static const fullNameIcon = Icon(Icons.people_alt_rounded);
  static const phoneNumberIcon = Icon(Icons.phone);
  static const popIcon = Icon(Icons.arrow_back_ios_rounded);
  static const downloadIcon = Icon(Icons.download_rounded);
  static const detailsIcon = Icon(Icons.people_alt_rounded);
  static const logOutIcon = Icon(Icons.logout);
  static const uploadIcon = Icon(Icons.arrow_circle_up);

}

LinearGradient gradientLayout = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      ProjectColors.primary,
      ProjectColors.secondary,
    ]);
