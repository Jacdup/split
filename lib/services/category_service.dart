
import 'dart:collection';

import 'package:flutter/cupertino.dart';

class CategoryService extends ChangeNotifier {

static const List<String> categories = [
  'Sport & Leisure',
  'Home & Garden',
  'Electronics',
  'Automobile',
  'Books',
  'Boardgames',
  'Clothes',
  'Other',
];

final List<String> _userCategories = new List<String>.from(categories) ;
//CategoryService({this.userCategories});


List<String> get userCategories => _userCategories;

List<String> get allCategories => categories;



//Future<void> method() async {
//  try {// TODO business logic
//  } catch (e) {
//  print(e.toString());
//  rethrow;
//  } finally {
//  updateWith(_userCategories);
//  }
//}
void updateWith(List<String> newCategories) {
  _userCategories.clear();
  _userCategories.addAll(newCategories);
  notifyListeners();
}

}