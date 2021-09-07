/*import 'package:drycleaners/Models/user.dart';
import 'package:drycleaners/Services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';*/

import 'package:drycleaners/projectImports.dart';

class AuthService{

  ///This variable will provide instance for FireBase from which
  ///we can access various functions provided by firebase_auth.dart file
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///Creation of userUID Object
  ///This function will create UserUID object with value as UID and will stream it
  ///if the user provided is not null.
  ///If user is null then null value will stream
  UserUID? _userFromFirebase(User? user){
    return user != null ? UserUID(uid: user.uid) : null;
  }

  ///Stream is created with the type UserUID? which is a class
  ///created in lib->models folder. So we are returning changes in
  ///the state of user that is SignIn or SignOut and converting that
  ///value as a UserUID object by mapping it.
  Stream<UserUID?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }
  /*
    Above function can also be return as
    Stream<UserUID?> get user {
      return _auth.authStateChanges().map((User? user){
        return user != null ? UserUID(uid: user.uid) : null;
      });
    }
  */

  ///SignIn with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ///Register with provided email and password
  Future registerWithEmailAndPassword(String email, String password, String fullName, int phoneNumber, String url) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      ///This function will be called from Database.dart file and will create a new document
      ///for the newly registered user with uid as its document and that document will
      ///contain values for FullName, Email PhoneNumber and URL of the current user provided
      ///during RegistrationPage() Widget.
      await DataBaseServices(uid: user!.uid)
          .storeUserData(fullName,email,phoneNumber,url);

      ///When the user details will get stored, stream will start sending UID as UserUID object and Wrapper()
      ///widget will catch that stream and will navigate to HomePage() widget since it is not null.
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ///Signing Out as Current User
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}