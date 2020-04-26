import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twofortwo/services/item_service.dart';
//import 'dart:math';

import 'package:uuid/uuid.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this. uid});

//  var itemCount = 0;
  var uuid = Uuid();

  // collection reference
  final CollectionReference itemCollection = Firestore.instance.collection('items'); // Creates a collection if there isn't one defined
  final CollectionReference userCollection = Firestore.instance.collection('users');


  Future updateUserData(String name, String surname, String phone, String location) async {
    return await userCollection.document(uid).setData({
      'name':name,
      'phoneNumber':phone,
      'location': location,
    });
  }

  Future updateItemData(String itemName, String description, String usageDate, String category) async {
//    itemCount = itemCount + 1; // Using sequential indexing atm
//    var rng = new Random();
    return await itemCollection.document(uuid.v4().toString()).setData({
      'itemName' : itemName,
      'description': description,
      'usageDate' : usageDate,
      'category' : category,
    });
  }

  // item list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Item( // Expects only positional arguments
        doc.data['category'],
        doc.data['itemName'] ,
        doc.data['usageDate'] ,
        doc.data['description'],
      );
    }).toList();
  }

  // get user stream
  Stream<QuerySnapshot> get user {
    return userCollection.snapshots();
  }

  // get item stream
  Stream<List<Item>> get items{
    return itemCollection.snapshots().map(_itemListFromSnapshot);
  }

}