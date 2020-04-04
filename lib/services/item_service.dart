class BorrowList {
  final String date;
  final String description;
  final String itemName;
  final String category;

  const BorrowList(this.category, this.itemName, this.date, this.description);
}

class Item {

  final String date;
  final String description;
  final String itemName;
  final String category;

  const Item(this.category, this.itemName, this.date, this.description);

  Item.fromJson(Map<String, dynamic> json)
      : itemName = json['itemName'],
        date = json['date'],
        description = json['description'],
        category = json['category'];

  // age = json['age'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['date'] = this.date;
    data['description'] = this.description;
    data['category'] = this.category;
    //data['age'] = this.age;
    return data;
  }
}