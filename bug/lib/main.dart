import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      home: StreamProvider<User>.value(
          value: userData1,
          builder: (context, snapshot) {
            return MyHomePage(title: 'Demo Error');
          }
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    final User userData = Provider.of<User>(context).runtimeType == User
        ? Provider.of<User>(context)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$userData.name',
            ),
          ],
        ),
      ),
    );
  }
}

User _getUserFromSnapshot(DocumentSnapshot snapshot){

  List<String> categoriesFromDb = (snapshot.data['categories']).cast<String>(); // Cast does not work

  return User(uid: '8GX2aGVn0GTrwLMxSZgx6STdnnA3',
    name: snapshot.data['name'],
    email: snapshot.data['email'],
    phone: snapshot.data['phoneNumber'],
    categories: categoriesFromDb,
    surname: snapshot.data['surname'],
  );

}

  Stream<User> get userData1{
    return Firestore.instance.collection('users').document('8GX2aGVn0GTrwLMxSZgx6STdnnA3')
        .get().then((snapshot){
      try{
//        var result = User.fromSnapshot(snapshot);
//        List<String> categories1 = result.categories.cast<String>();
        return User.fromSnapshot(snapshot);
      }catch(e){
        print(e);
        return null;
      }
    }).asStream();
  }



class User {

  final String uid;
  final String name;
  final String surname;
  final String phone;
  final String email;
  final List<String> categories;

  User({this.uid, this.name, this.surname, this.email, this.phone, this.categories})
      : super();

  User.fromSnapshot(DocumentSnapshot snapshot)
  // snapshot.data is a Map<String, dynamic>
      :
//        documentID = snapshot.documentID,
        uid = snapshot.data['uid'],
        name = snapshot.data['name'],
        surname = snapshot.data['surname'],
        phone = snapshot.data['phoneNumber'],
        email = snapshot.data['email'],
        categories = List<String>.from(snapshot['categories']);
}


