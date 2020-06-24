import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class BorrowList {
  final String date;
  final String description;
  final String itemName;
  final String category;
  final String uid;

  const BorrowList(this.category, this.itemName, this.date, this.description, this.uid);
}

class Item { // Requested item

//  final String date;
  final String description;
  final String itemName;
  final List<String> categories;
  final String uid;
  final String docRef;
  final DateTime createdAt;
  final String startDate;
  final String endDate;
  final bool currentlyNeeded;

  const Item(this.categories, this.itemName, this.startDate, this.endDate, this.description, this.uid, this.docRef, this.createdAt, this.currentlyNeeded);

  Item.fromJson(Map<String, dynamic> json)
      : itemName = json['itemName'],
        startDate = json['startDate'],
        endDate = json['endDate'],
//        date = json['date'],
        description = json['description'],
        categories = json['categories'],
        uid = json['uid'],
        docRef = json['docRef'],
        createdAt = json['createdAt'],
        currentlyNeeded = json['currentlyNeeded'];

  // age = json['age'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
//    data['date'] = this.date;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['description'] = this.description;
    data['categories'] = this.categories;
    data['uid'] = this.uid;
    data['docRef'] = this.docRef;
    data['currentlyNeeded'] = this.currentlyNeeded;
    //data['age'] = this.age;
    return data;
  }



}

class ItemAvailable {

  final String description;
  final String itemName;
  final List<String> categories;
  final String uid;
  final String docRef;
  final DateTime createdAt;
  final String startDate;
  final String endDate;
  final bool available;

  const ItemAvailable(this.categories, this.itemName, this.startDate, this.endDate, this.description, this.uid, this.docRef, this.createdAt, this.available);

  ItemAvailable.fromJson(Map<String, dynamic> json)
      : itemName = json['itemName'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        description = json['description'],
        categories = json['categories'],
        uid = json['uid'],
        docRef = json['docRef'],
        createdAt = json['createdAt'],
        available = json['available'];
  // age = json['age'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['description'] = this.description;
    data['categories'] = this.categories;
    data['uid'] = this.uid;
    data['docRef'] = this.docRef;
    data['available'] = this.available;
    //data['age'] = this.age;
    return data;
  }

  // requested item list from snapshot
//   itemAvailableListFromSnapshot(QuerySnapshot snapshot){
//    return snapshot.documents.map((doc){
////      print('!!!!!!!!');
////      print(doc.data['category'].runtimeType);
//      return ItemAvailable( // Expects only positional arguments
//        categories: List<String>.from(doc.data['categories']), //.cast<String>(),
//        itemName: doc.data['itemName'] ,
//        date: doc.data['usageDate'] ,
//        description: doc.data['description'],
//        uid: doc.data['uid'],
//        docRef: doc.data['docRef'],
//        createdAt: doc.data['createdAt'].toDate(),
//      );
//    }).toList();
//  }


}

class ItemsAvailableModel{
  Stream<List<ItemAvailable>> stream;
  bool hasMore;

  bool _isLoading;
  List<Map> _data;
  StreamController<List<Map>> _controller;

  ItemsAvailableModel(){
    _data = List<Map>();
    _controller = StreamController<List<Map>>.broadcast();
    _isLoading = false;
//    stream = _controller.stream.map((List<Map> itemsData){
////      return itemsData.map((Map itemData );
////      return itemAvailable.from)
//    });

}





}