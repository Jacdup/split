
import 'package:flutter/cupertino.dart';

class CategoryService extends ChangeNotifier {

final List<String> categories = [
  'Sport & Leisure',
  'Home & Garden',
  'Electronics',
  'Automobile',
  'Books',
  'Boardgames',
  'Clothes',
  'Other',
];

final List<String> _userCategories = [] ;
//CategoryService({this.userCategories});


List<String> get userCategories => _userCategories;



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