import 'package:firebase_auth/firebase_auth.dart';
import 'package:twofortwo/services/category_service.dart';
import 'package:twofortwo/services/database.dart';
import 'package:twofortwo/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;



  // create user obj based on FirebaseUser
  FUser _userFromFirebaseUser(User firebaseUser, ) {
//    return await DatabaseService(uid: user.uid).user;
    return firebaseUser != null
        ? FUser(
            uid: firebaseUser.uid,
            email: firebaseUser.email)
        : null;
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // auth change user stream
  Stream<FUser> get user {
//    dynamic userAll = DatabaseService(uid: user.).user;
    return _auth.authStateChanges()
        .map((User firebaseUser) => _userFromFirebaseUser(firebaseUser));
//        .map(_userFromFirebaseUser()); // This does the same as above
//        .map(FirebaseUser);
  }

  // sign in with email & password
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User firebaseUser = result.user;

//      dynamic userAll = await DatabaseService(uid: user.uid).user;
//      userAll.then((SplitUser result){
//        userAll = result;
//
//        print(userAll.name);
//      });
//      return userAll;

      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String name, String surname, String email, String phone,  String password) async {
    // TODO: name, phone, etc.
    try{
        UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       User firebaseUser = result.user;
//       List<String> initialCategories = CategoryService().categories;
//       List<String> temp = ['Sport'];
       // create a new document for the user with the uid
        await DatabaseService(uid: firebaseUser.uid).updateUserData(name, surname, phone, email, CategoryService().categories); //setter TODO: update userdetails categories
//        dynamic userAll = await DatabaseService(uid: user.uid).user; //getter

//        return userAll;
       return _userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e.toString());
      return null;
    }

  }

  // sign out
  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
