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
  final List<String> categories;
  final String uid;
  final String docRef;
  final DateTime createdAt;

  const Item(this.categories, this.itemName, this.date, this.description, this.uid, this.docRef, this.createdAt);

  Item.fromJson(Map<String, dynamic> json)
      : itemName = json['itemName'],
        date = json['date'],
        description = json['description'],
        categories = json['categories'],
        uid = json['uid'],
        docRef = json['docRef'],
        createdAt = json['createdAt'];

  // age = json['age'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['date'] = this.date;
    data['description'] = this.description;
    data['categories'] = this.categories;
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
  final List<String> categories;
  final String uid;
  final String docRef;
  final DateTime createdAt;

  const ItemAvailable(this.categories, this.itemName, this.date, this.description, this.uid, this.docRef, this.createdAt);

  ItemAvailable.fromJson(Map<String, dynamic> json)
      : itemName = json['itemName'],
        date = json['date'],
        description = json['description'],
        categories = json['categories'],
        uid = json['uid'],
        docRef = json['docRef'],
        createdAt = json['createdAt'];
  // age = json['age'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['date'] = this.date;
    data['description'] = this.description;
    data['categories'] = this.categories;
    data['uid'] = this.uid;
    data['docRef'] = this.docRef;
    //data['age'] = this.age;
    return data;
  }

}