
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/services/user_service.dart';

import 'package:uuid/uuid.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this. uid});

  var uuid = Uuid();

  // collection reference
  final CollectionReference itemRequestCollection = Firestore.instance.collection('itemsRequested'); // Creates a collection if there isn't one defined
  final CollectionReference itemAvailableCollection = Firestore.instance.collection('itemsAvailable');
  final CollectionReference userCollection = Firestore.instance.collection('users');

 /* --------------------------------------------------------------------------
  User stuff
 * ---------------------------------------------------------------------------*/
  Future updateUserData(String name, String surname, String phone, String email, List<String> categories) async {
    return await userCollection.document(uid).setData({
      'name':name,
      'phoneNumber':phone,
      'surname' : surname,
      'email' : email,
      'categories' : (categories).cast<String>(), // Really.
    });
  }

  Future updateCategory(List<String> categories) async{
    return await userCollection.document(uid).updateData({
      'categories': (categories).cast<String>(),
    });
  }


  User _getUserFromSnapshot(DocumentSnapshot snapshot){
//  var userData = snapshot.data; // This itself is a map
//  List<String> categoriesFromDb = List<String>.from(snapshot.data['categories']);
//    categoriesFromDb = snapshot.data['categories'].map<ItemCount>((item) {
//      return ItemCount.fromMap(item);
//    }).toList();
//    User thisUser = User.fromMap(snapshot.data);
//    print(thisUser.uid);
//
//    return thisUser;
//  return User.fromSnapshot(snapshot);

  List<String> categoriesFromDb = (snapshot.data['categories']).cast<String>();
//      print('!!!!!!!!');
//      print(userData['surname'].runtimeType);
//      print(snapshot.data['categories'].runtimeType);
//      print((categoriesFromDb).runtimeType);
//    return snapshot.data.map((snapshot) {
      return User(uid: uid,
          name: snapshot.data['name'],
          email: snapshot.data['email'],
          phone: snapshot.data['phoneNumber'],
          categories: categoriesFromDb, //https://stackoverflow.com/questions/54851001/listdynamic-is-not-a-subtype-of-listoption
          surname: snapshot.data['surname'],
      );
//    });
  }
//
//  Stream<User> get userData{
//    return userCollection.document(uid).snapshots().map<User>(_getUserFromSnapshot);
//  }

  Stream<User> get userData{
    return userCollection.document(uid).get().then((snapshot){
      try{
        return _getUserFromSnapshot(snapshot);
      }catch(e){
        print(e);
        return null;
      }
    }).asStream();
  }


  /* --------------------------------------------------------------------------
  Push Notifications
 * ---------------------------------------------------------------------------*/

  Future saveDeviceToken(String fcmToken) async {

    if (fcmToken != null){
      //TODO: get user uid here
      var tokenRef = userCollection.document(uid).collection('tokens').document(fcmToken);

     return await tokenRef.setData({
        'token': fcmToken,
        'createdAt' : FieldValue.serverTimestamp(),
        'platform' : Platform.operatingSystem,
      });


    }

  }


  /* --------------------------------------------------------------------------
  Items
 * ---------------------------------------------------------------------------*/
  Future addItemRequestedData(String itemName, String description, String usageDate, List<String> categories) async {
    String thisDocRef = uuid.v4().toString();

    return await itemRequestCollection.document(thisDocRef).setData({
      'itemName' : itemName,
      'description': description,
      'usageDate' : usageDate,
      'categories' : categories,
      'uid' : uid,
      'docRef' : thisDocRef,
    });
  }

  Future addItemAvailableData(String itemName, String description, String usageDate, List<String> categories) async {
//    itemCount = itemCount + 1; // Using sequential indexing atm
//    var rng = new Random();
  String thisDocRef = uuid.v4().toString();

    return await itemAvailableCollection.document(thisDocRef).setData({
      'itemName' : itemName,
      'description': description,
      'usageDate' : usageDate,
      'categories' : categories,
      'uid' : uid,
      'docRef' : thisDocRef,
    });
  }


  Future deleteItem(String documentRef, bool type) async {

//    dynamic result;

    await Firestore.instance.runTransaction((Transaction myTransaction) async {
      if (type){
        return await myTransaction.delete(itemAvailableCollection.document(documentRef));
      }else{
        return await myTransaction.delete(itemRequestCollection.document(documentRef));
      }
    });

//    if (result == null){
//      await Firestore.instance.runTransaction((Transaction myTransaction) async {
//
//      });
//    }




//    return await itemAvailableCollection.document(documentRef).delete(); // Easier, but not best practice.
  }



  // requested item list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){

      return Item( // Expects only positional arguments
        List<String>.from(doc.data['categories']), //.cast<String>()
        doc.data['itemName'] ,
        doc.data['usageDate'] ,
        doc.data['description'],
        doc.data['uid'],
        doc.data['docRef'],
      );
    }).toList();
  }

  // requested item list from snapshot
  List<ItemAvailable> _itemAvailableListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
//      print('!!!!!!!!');
//      print(doc.data['category'].runtimeType);
      return ItemAvailable( // Expects only positional arguments
        List<String>.from(doc.data['categories']), //.cast<String>(),
        doc.data['itemName'] ,
        doc.data['usageDate'] ,
        doc.data['description'],
        doc.data['uid'],
        doc.data['docRef'],
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