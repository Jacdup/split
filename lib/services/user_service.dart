

// At the beginning, the user details should be obtained with the storage service
// After that, the user should be accessed by this method
// This method should store a copy of the user details, without continually fetching from the storage service

class User {

  final String uid;
  final String name;
  final String surname;
  final String phone;
  final String email;
  final List<dynamic> categories;

//  User.fromMap(Map<String, dynamic> data)
//      : uid = data["uid"],
//       name = data["name"],
//        email = data['email'],
//        surname = data['surname'],
//        phone = data['phone'],
//        categories = (data['categories']).cast<String>();
//
//  User.fromSnapshot(DocumentSnapshot snapshot)
//      :
////        documentID = snapshot.documentID,
//        uid = snapshot['uid'],
//        name = snapshot['name'],
//        surname = snapshot['surname'],
//        phone = snapshot['phoneNumber'],
//        email = snapshot['email'],
//        categories = List<String>.from(snapshot['categories']);
//}
//        reviewers = List.from(data['reviewers']);

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



