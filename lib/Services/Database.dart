/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drycleaners/Models/user.dart';*/

import 'package:drycleaners/projectImports.dart';

class DataBaseServices {
  DataBaseServices({required this.uid});
  final String uid;



  ///This variable will contain User Collection reference from Firebase Cloud_Storage
  ///CollectionReference has a type of map where its key is String and value is dynamic
  ///FirebaseFirestore.instance.collection('users'); will generate a collection named 'users'
  ///where all the User UID in the form of documents will be added if not present already.
  final CollectionReference<Map<String, dynamic>> userCollection =
  FirebaseFirestore.instance.collection('users');

  ///User data will be added in new doc where doc is UID of the newly registered user
  ///Values will be in the form of Map Datatype provided from RegistrationPage
  Future storeUserData(String fullName, String email, int phoneNumber,String url) async {

    return await userCollection.doc(uid).set({
      'URL': url,
      'FullName': fullName,
      'Email': email,
      'Phone-Number': phoneNumber
    });
  }

  ///This function will update value of URL field of the current user
  Future updateQRString(String path) async{
    return await userCollection.doc(uid).update(
        {'URL': path}
    );
  }

  ///Creating Stream of type UserData which is a defined class in lib->model folder
  ///snapshots will provide the data for the particular uid document and mapping them into
  ///UserData objects.
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
    /*Above return statement can also be return as
      return userCollection.doc(uid).snapshots().map((snapshot) {
        return UserData(
        fullName: snapshot.get('FullName'),
        email: snapshot.get('Email'),
        phoneNumber: snapshot.get('Phone-Number'),
        url: snapshot.get('URL')
        );
      });
    */
  }

  ///This function will convert the snapshot data into UserData objects
  ///which will become easy to access those data.
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        fullName: snapshot.get('FullName'),
        email: snapshot.get('Email'),
        phoneNumber: snapshot.get('Phone-Number'),
        url: snapshot.get('URL')
    );
  }

}
