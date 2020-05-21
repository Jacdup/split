
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/services/category_service.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/services/message_service.dart';
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

  List<String> categoriesFromDb = (snapshot.data['categories']).cast<String>();

      return User(uid: uid,
          name: snapshot.data['name'],
          email: snapshot.data['email'],
          phone: snapshot.data['phoneNumber'],
          categories: categoriesFromDb, //https://stackoverflow.com/questions/54851001/listdynamic-is-not-a-subtype-of-listoption
          surname: snapshot.data['surname'],
      );
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

//  getUserMessages(){
//    userCollection.document(uid).collection('messages').document()
//  }


  /* --------------------------------------------------------------------------
  Notifications
 * ---------------------------------------------------------------------------*/

  // Push notifications
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

  // Message notifications
  Future saveMessageToUserProfile(String messagePayload, String datePayload, String ownerUid, String itemName, String fromUid ) async {
    String messageDocRef = uuid.v4().toString();

    if (uid != null){

      var messageRef = userCollection.document(ownerUid).collection('messages').document(messageDocRef);

      return await messageRef.setData({
        'forItem' : itemName,
        'from' : fromUid,
        'message' : messagePayload,
        'dateRequested' : datePayload,
        'timeStamp' : FieldValue.serverTimestamp(),
      });
    }

  }

  List<Message> _messagesFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Message(
      message: doc.data['message'],
      uidFrom : doc.data['from'],
      dateSent : doc.data['timeStamp'].toString(),
      dateRequested: doc.data['dateRequested'],
      forItem : doc.data['forItem'],
      );
    }).toList();
  }

  Stream<List<Message>> get messages{
    return Firestore.instance.collection('users').document(uid).collection('messages').snapshots().map(_messagesFromSnapshot);
  }

  /* --------------------------------------------------------------------------
  Items
 * ---------------------------------------------------------------------------*/
  Future addItemRequestedData(String itemName, String description, String usageDate, List<String> categories, DateTime createdAt) async {
    String thisDocRef = uuid.v4().toString();

    return await itemRequestCollection.document(thisDocRef).setData({
      'itemName' : itemName,
      'description': description,
      'usageDate' : usageDate,
      'categories' : categories,
      'uid' : uid,
      'docRef' : thisDocRef,
      'createdAt' : createdAt,
    });
  }

  Future addItemAvailableData(String itemName, String description, String usageDate, List<String> categories, DateTime createdAt) async {
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
      'createdAt' : createdAt,
    });
  }


  Future deleteItem(String documentRef, bool type) async {

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

  Future contactItemOwner(String documentRef, String messagePayload, String datePayload, bool type) async {
    dynamic result;

    if (type){
      await itemAvailableCollection.document(documentRef).get().then((value) {
        result = value.data;
//        print(result['uid']);
      });
    }else{
      await itemRequestCollection.document(documentRef).get().then((value) {
        result = value.data;
      });
    }
    print('!!!!!!');
    print(uid);
    print(messagePayload);

//
//    await Firestore.instance.runTransaction((transaction) async{
//      if (type){
//        result = transaction.get(itemAvailableCollection.document(documentRef));
//      }else{
//        result = transaction.get(itemAvailableCollection.document(documentRef));
//      }
//    });

    String ownerUid = result["uid"]; // Uid of item owner
    String itemName = result["itemName"];
    print(ownerUid);
    await saveMessageToUserProfile(messagePayload, datePayload, ownerUid, itemName, uid); // Save message to user profile in database

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
        doc.data['createdAt'].toDate(),
      );
    }).toList();
  }

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
        doc.data['createdAt'].toDate(),
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

//  Future<List<ItemAvailable>> get itemsAvailable async{
//    final response = await itemAvailableCollection.getDocuments();
//
//    return ItemAvailable.itemAvailableListFromSnapshot(response.documents.asMap();)
//
//    return itemAvailableCollection.snapshots().map({
//      "categories":
//    })
//  }

}