///For streaming User UID
class UserUID {
  final String uid;
  UserUID({required this.uid});
}

///For Streaming User Data
class UserData {
  final String fullName;
  final String email;
  final int phoneNumber;
  final String url;

  UserData({required this.fullName,required this.email,required this.phoneNumber,required this.url});
}