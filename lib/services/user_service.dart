import 'localstorage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// At the beginning, the user details should be obtained with the storage service
// After that, the user should be accessed by this method
// This method should store a copy of the user details, without continually fetching from the storage service

class UserService {
  final String userName;

  const UserService({ this.userName}) : super();


}

class User {

  final String uid;
  final String name;
//  final String surname;
  final String phone;
  final String email;

  User({this.uid, this.name, this.email, this.phone});

  User.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        name = json['name'],
        email = json['email'],
//        surname = json['surname'],
        phone = json['phone'];
  // age = json['age'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
//    data['surname'] = this.surname;
    data['phone'] = this.phone;
    //data['age'] = this.age;
    return data;
  }
}



