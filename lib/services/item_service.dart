class BorrowList {
  final String date;
  final String description;
  final String itemName;
  final String category;
  final String uid;

  const BorrowList(this.category, this.itemName, this.date, this.description, this.uid);
}

class Item {

  final String date;
  final String description;
  final String itemName;
  final String category;
  final String uid;
  final String docRef;

  const Item(this.category, this.itemName, this.date, this.description, this.uid, this.docRef);

  Item.fromJson(Map<String, dynamic> json)
      : itemName = json['itemName'],
        date = json['date'],
        description = json['description'],
        category = json['category'],
        uid = json['uid'],
        docRef = json['docRef'];

  // age = json['age'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['date'] = this.date;
    data['description'] = this.description;
    data['category'] = this.category;
    data['uid'] = this.uid;
    data['docRef'] = this.docRef;
    //data['age'] = this.age;
    return data;
  }

}

class ItemAvailable {

  final String date;
  final String description;
  final String itemName;
  final String category;
  final String uid;
  final String docRef;

  const ItemAvailable(this.category, this.itemName, this.date, this.description, this.uid, this.docRef);

  ItemAvailable.fromJson(Map<String, dynamic> json)
      : itemName = json['itemName'],
        date = json['date'],
        description = json['description'],
        category = json['category'],
        uid = json['uid'],
        docRef = json['docRef'];
  // age = json['age'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['date'] = this.date;
    data['description'] = this.description;
    data['category'] = this.category;
    data['uid'] = this.uid;
    data['docRef'] = this.docRef;
    //data['age'] = this.age;
    return data;
  }

}