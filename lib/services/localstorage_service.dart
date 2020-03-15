import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageService {

  static const String UserKey = 'user';//TODO
  static const String CategoryKey = 'category';
  static LocalStorageService _instance;
  static SharedPreferences _preferences;
  static const String SignedUpKey = 'signedUp';
  static const String LoggedInKey = 'loggedIn';


  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    _preferences.clear();

    return _instance;
  }

  List<String> _getStringListFromDisk(String key){
    //var value  = _preferences.get(key);
    List<String> value = _preferences.getStringList(key);
   // print('(TRACE) LocalStorageService:_getStringListFromDisk. key: $key value: $value');
    return value;
  }

  dynamic _getFromDisk(String key) {
    var value  = _preferences.get(key);
    //print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void saveStringToDisk(String key, String content){
    //print('(TRACE) LocalStorageService:_saveStringToDisk. key: $key value: $content');
    _preferences.setString(UserKey, content);
  }

// updated _saveToDisk function that handles all types
  void _saveToDisk<T>(String key, T content){
    //print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if(content is String) {
      _preferences.setString(key, content);
    }
    if(content is bool) {
      _preferences.setBool(key, content);
    }
    if(content is int) {
      _preferences.setInt(key, content);
    }
    if(content is double) {
      _preferences.setDouble(key, content);
    }
    if(content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  /* Getter */
  User get user {
    var userJson = _getFromDisk(UserKey);
    if (userJson == null) {
      return null;
    }

    return User.fromJson(json.decode(userJson));
  }

/* Setter */
  set user(User userToSave) {
    saveStringToDisk(UserKey, json.encode(userToSave.toJson()));
  }

  /* Getter */
  List<String> get category {
    //var userJson = _getFromDisk(UserKey);
   // var cate1 = _getStringListFromDisk(CategoryKey) ?? List<String>();

    final List<String> cate = _getStringListFromDisk(CategoryKey) ?? List<String>();
    if (cate == null) {
      return null;
    }

    return cate; // Already in the format (not Json)

  }
  /* Setter for category */
   set category(List<String> categoriesToSave) {
    _saveToDisk(CategoryKey, (categoriesToSave)); // Not saving this in a Json at the moment
  }

  bool get hasSignedUp => _getFromDisk(SignedUpKey) ?? false;
  set hasSignedUp(bool value) => _saveToDisk(SignedUpKey, value);

  bool get hasLoggedIn => _getFromDisk(LoggedInKey) ?? false;
  set hasLoggedIn(bool value) => _saveToDisk(LoggedInKey, value);
  }

class User { //TODO: should this be here, and not in user_service.dart?


  final String name;
  final String surname;
  final int age;

  User({this.name, this.surname, this.age});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        surname = json['surname'],
        age = json['age'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['age'] = this.age;
    return data;
  }
}

class Category{
  // Have to make this a json, otherwise there is no way to use a getter/setter

 /* List categories = [
    'Sport',
    'Camping',
    'Household',
    'Automobile',
    'Books',
    'Boardgames'
  ];*/
  List categories;

  Category({this.categories});

//
//  Category.fromJson(Map<String, dynamic> json)
//      : categories = json['categories'];
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['categories'] = this.categories;

   // return data;
  //}

}








