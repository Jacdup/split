

// At the beginning, the user details should be obtained with the storage service
// After that, the user should be accessed by this method
// This method should store a copy of the user details, without continually fetching from the storage service

import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  final String uid;
  final String name;
  final String surname;
  final String phone;
  final String email;
  final List<dynamic> categories;

  User({this.uid, this.name, this.surname, this.email, this.phone, this.categories}) : super();


//  User.fromJson(Map<String, dynamic> json)
//      : uid = json['uid'],
//        name = json['name'],
//        email = json['email'],
//        surname = json['surname'],
//        phone = json['phone'],
//        categories = (json['categories']).cast<String>();
//  // age = json['age'];
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['uid'] = this.uid;
//    data['name'] = this.name;
//    data['email'] = this.email;
//    data['surname'] = this.surname;
//    data['phone'] = this.phone;
//    data['categories'] = (this.categories).cast<String>();
//    //data['age'] = this.age;
//    return data;
//  }
}

class UserContact{
  final String name;
  final String surname;
  final String email;
  final String phone;

  UserContact({this.name, this.phone, this.email, this.surname});


  factory UserContact.fromDoc(DocumentSnapshot snapshot){
    return UserContact(
      name: snapshot.data['name'],
      surname: snapshot.data['surname'],
      email: snapshot.data['email'],
      phone: snapshot.data['phoneNumber'],
    );
  }


}

class FUser {

  final String uid;
  final String email;

  FUser({this.uid, this.email,});

  FUser.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'];
  // age = json['age'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['email'] = this.email;
    //data['age'] = this.age;
    return data;
  }
}



