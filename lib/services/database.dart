import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/services/user_service.dart';
//import 'dart:math';

import 'package:uuid/uuid.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this. uid});

//  var itemCount = 0;
  var uuid = Uuid();

  // collection reference
  final CollectionReference itemRequestCollection = Firestore.instance.collection('itemsRequested'); // Creates a collection if there isn't one defined
  final CollectionReference itemAvailableCollection = Firestore.instance.collection('itemsAvailable');
  final CollectionReference userCollection = Firestore.instance.collection('users');

 /* --------------------------------------------------------------------------
  User stuff
 * ---------------------------------------------------------------------------*/
  Future updateUserData(String name, String surname, String phone, String email, List<dynamic> categories) async {
    return await userCollection.document(uid).setData({
      'name':name,
      'phoneNumber':phone,
      'surname' : surname,
//      'location': location,
      'email' : email,
      'categories' : categories,
    });
  }

  Future updateCategory(List<String> categories) async{
    return await userCollection.document(uid).updateData({
      'categories': categories,
    });
  }


  User _getUserFromSnapshot(DocumentSnapshot snapshot){
  var userData = snapshot.data; // This itself is a map
//  print(userData);
//    return snapshot.data.map((snapshot) {
      return User(uid: uid,
          name: userData['name'],
          email: userData['email'],
          phone: userData['phoneNumber'],
          categories: userData['categories'],
          surname: userData['surname'],
      );
//    });
  }

  Stream<User> get userData{
    return userCollection.document(uid).snapshots().map(_getUserFromSnapshot);
  }

  // get user snapshot
//  Future<User> get user async {
//    return _getUserFromSnapshot(await userCollection.document(uid).get());
////    userCollection.document(uid).get().then((DocumentSnapshot ds){
////      return _getUserFromSnapshot(ds);
////    }).catchError((e) => print('Error retrieving user data'));
////    return null;
////    return (userCollection.document(uid).snapshots().map(_getUserFromSnapshot)); // Get single document snapshot
//  }


  /* --------------------------------------------------------------------------
  Item stuff
 * ---------------------------------------------------------------------------*/
  Future updateItemData(String itemName, String description, String usageDate, String category) async {

    return await itemRequestCollection.document(uuid.v4().toString()).setData({
      'itemName' : itemName,
      'description': description,
      'usageDate' : usageDate,
      'category' : category,
      'uid' : uid,
    });
  }

  Future updateItemAvailableData(String itemName, String description, String usageDate, String category) async {
//    itemCount = itemCount + 1; // Using sequential indexing atm
//    var rng = new Random();
    return await itemAvailableCollection.document(uuid.v4().toString()).setData({
      'itemName' : itemName,
      'description': description,
      'usageDate' : usageDate,
      'category' : category,
      'uid' : uid,
    });
  }



  // requested item list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Item( // Expects only positional arguments
        doc.data['category'],
        doc.data['itemName'] ,
        doc.data['usageDate'] ,
        doc.data['description'],
        doc.data['uid'],
      );
    }).toList();
  }

  // requested item list from snapshot
  List<ItemAvailable> _itemAvailableListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return ItemAvailable( // Expects only positional arguments
        doc.data['category'],
        doc.data['itemName'] ,
        doc.data['usageDate'] ,
        doc.data['description'],
        doc.data['uid'],
      );
    }).toList();
  }

  // get requested item stream
  Stream<List<Item>> get itemsRequested{
    return itemRequestCollection.snapshots().map(_itemListFromSnapshot);
  }

  // get available item stream
  Stream<List<ItemAvailable>> get itemsAvailable{
    return itemAvailableCollection.snapshots().map(_itemAvailableListFromSnapshot);
  }

}