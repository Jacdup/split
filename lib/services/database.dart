import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/services/message_service.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  final String uid;
  final String? itemID;
  DatabaseService({required this.uid, this.itemID});

  var uuid = Uuid();

  // collection reference
  final CollectionReference itemCollection = FirebaseFirestore.instance.collection('items'); // Creates a collection if there isn't one defined
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  /* --------------------------------------------------------------------------
  User stuff
 * ---------------------------------------------------------------------------*/
  Future updateUserData(String name, String surname, String phone, String email, List<String> categories) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'phoneNumber': phone,
      'surname': surname,
      'email': email,
    //  'categories': (categories).cast<String>(), // Really.
    });
  }


  User _getUserFromSnapshot(DocumentSnapshot snapshot) {
  //  List<String> categoriesFromDb = (snapshot.get('categories')).cast<String>();
    return User(
      uid: uid,
      name: snapshot.get('name'),
      email: snapshot.get('email'),
      phone: snapshot.get('phoneNumber'),
      //categories: categoriesFromDb, //https://stackoverflow.com/questions/54851001/listdynamic-is-not-a-subtype-of-listoption
      surname: snapshot.get('surname'),
    );
  }

  Stream<User?> get userData {
    return userCollection.doc(uid).get().then((snapshot) {
      try {
        return _getUserFromSnapshot(snapshot);
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  // The same as above but as a Future
  Future<User?> userMessageData(String? uid) {
    return userCollection.doc(uid).get().then((snapshot) {
      try {
        return _getUserFromSnapshot(snapshot);
      } catch (e) {
        print(e);
        return null;
      }
    });
  }

  /* --------------------------------------------------------------------------
  Notifications
 * ---------------------------------------------------------------------------*/

  // Push notifications
  Future saveDeviceToken(String? fcmToken) async {
    if (fcmToken != null) {
      //TODO: get user uid here
      var tokenRef = userCollection.doc(uid).collection('tokens').doc(fcmToken);

      return await tokenRef.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem,
      });
    }
  }

  // Message notifications
  Future saveMessageToUserProfile(String messagePayload, String datePayload, String ownerUid, String itemName, String? fromUid) async {
    String messageDocRef = uuid.v4().toString();
    final User? fromUser = await userMessageData(fromUid);
    final String? nameFrom = fromUser?.name;
    final String? surnameFrom = fromUser?.surname;
    final String? phoneFrom = fromUser?.phone;

    if (uid != null) {
      var messageRef = userCollection
          .doc(ownerUid)
          .collection('messages')
          .doc(messageDocRef);

      return await messageRef.set({
        'forItem': itemName,
        'from': fromUser?.uid,
        'nameFrom': nameFrom,
        'surnameFrom': surnameFrom,
        'phoneFrom': phoneFrom,
        'message': messagePayload,
        'dateRequested': datePayload,
        'timeStamp': FieldValue.serverTimestamp(),
        'hasRead': false,
      });
    }
  }

  List<Message> _messagesFromSnapshot(QuerySnapshot snapshot) {
    // Converts the FirebaseFirestore snapshot into a list of messages
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Message(
        message: data['message'],
        uidFrom: data['from'],
        nameFrom: data['nameFrom'],
        surnameFrom: data['surnameFrom'],
        phoneFrom: data['phoneFrom'],
        dateSent: data['timeStamp'].toDate(),
        dateRequested: data['dateRequested'],
        forItem: data['forItem'],
        hasRead: data.containsKey('hasRead') ? data['hasRead'] : false ,
      );
    }).toList();
  }

  Future setMessageReadStatus(String docRef) async {
    final CollectionReference messageCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('messages');
    return await messageCollection.doc(docRef).update({
      'hasRead': false,
    });
  }

  Future<String> getMessageDocRef(DocumentReference docRef) async {
    DocumentSnapshot docSnap = await docRef.get();
    var docID = docSnap.reference.id;
    return docID;
  }

  Stream<List<Message>> get messages {
    // var user = FirebaseFirestore.instance.collection('users').doc(uid).get();
     return FirebaseFirestore.instance
         .collection('users')
         .doc(uid)
         .collection('messages')
         .snapshots()
         .map(_messagesFromSnapshot);
  }

  /* --------------------------------------------------------------------------
  Items
 * ---------------------------------------------------------------------------*/
  Future addItemData(
      String itemName,
      String description,
      String usageDateStart,
      String usageDateEnd,
      List<String> categories,
      DateTime createdAt,
      double price,
      int pricePeriod) async {
    String thisDocRef = uuid.v4().toString();

    return await itemCollection.doc(thisDocRef).set({
      'itemName': itemName,
      'description': description,
      'startDate': usageDateStart,
      'endDate': usageDateEnd,
      'categories': categories,
      'uid': uid,
      'docRef': thisDocRef,
      'createdAt': createdAt,
      'currentlyNeeded': true,
      'price': price,
      'pricePeriod': pricePeriod,
    });
  }

  Future deleteItem(String documentRef) async {
    await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
        return myTransaction.delete(itemCollection.doc(documentRef));
    });
  }

  Future updateItem(Item? newItem, List<String> categories) async {
    dynamic response;
    response = itemCollection.doc(newItem?.docRef).update({
        'itemName': newItem?.itemName,
        'description': newItem?.description,
        'startDate': newItem?.startDate,
        'endDate': newItem?.endDate,
        'categories': categories,
        'createdAt': newItem?.createdAt,
        'price': newItem?.price,
        'pricePeriod': newItem?.pricePeriod,
      });
    return response;
  }

  Future updateItemAvailability(
      String documentRef, bool type, bool availability) async {
      dynamic response;
      response = itemCollection.doc(documentRef).update({'available': availability});
  }

  Future contactItemOwner(String documentRef, String messagePayload,
      String datePayload, bool type) async {
      dynamic result;

      await itemCollection.doc(documentRef).get().then((value) {
        result = value.data();
      });
    String ownerUid = result["uid"]; // Uid of item owner
    String itemName = result["itemName"];

    await saveMessageToUserProfile(messagePayload, datePayload, ownerUid,
        itemName, uid); // Save message to user profile in database
  }

  // requested item list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      try {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        var categories;
        return Item(
          // Expects only positional arguments
                // Check if 'categories' field exists
        //  List<String> categories = (data['categories'] != null) ? List<String>.from(data['categories']) : []; // Provide a default value if 'categories' is missing
          List<String>.from(data['categories']), //.cast<String>()
          data['itemName'] ?? '',
          data['startDate'] ?? '',
          data['endDate'] ?? '',
          data['description'] ?? '',
          data['uid'] ?? '',
          data['docRef'] ?? '',
          data['createdAt'] != null ? data['createdAt'].toDate() : null,
          data['currentlyNeeded'] ?? true,
          data['price'] ?? 0,
          data['pricePeriod'] ?? 0,
        );
      } catch (e) {
        print("Firestore error in getting the requested list:");
        print(e);
        return Item([], '', '', '', '', '', '', '' as DateTime, true, 0, 0);
      }
    }).toList();
  }

  // get item stream
  Stream<List<Item>>? get items {
    return itemCollection.snapshots().map(_itemListFromSnapshot); 
  }

  Future<UserContact?> get itemOwnerDetails async {
    UserContact? response;
    String? thisItemUid;

    thisItemUid = await itemCollection.doc(itemID).get().then((value) {
      try {
        return value.get('uid');
      } catch (e) {
        print(e);
        return null;
      }
    });

    // Fetch the user details of item owner
    response = await userCollection.doc(thisItemUid).get().then((value) {
      try {
        return UserContact.fromDoc(value);
      } catch (e) {
        return null;
      }
    });

    return response;
  }
}
