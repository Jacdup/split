
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
  final double price;
  final int pricePeriod;

  const Item(this.categories, this.itemName, this.startDate, this.endDate, this.description, this.uid, this.docRef, this.createdAt, this.currentlyNeeded, this.price, this.pricePeriod);

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
        price = json['price'],
        pricePeriod = json['pricePeriod'],
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
    data['price'] = this.price;
    data['pricePeriod'] = this.pricePeriod;
    data['currentlyNeeded'] = this.currentlyNeeded;
    //data['age'] = this.age;
    return data;
  }
}