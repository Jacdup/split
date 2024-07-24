import 'package:firebase_auth/firebase_auth.dart'
    as fAuth; // Of course I have to do this now, since User is ambiguous
import 'package:twofortwo/services/category_service.dart';
import 'package:twofortwo/services/database.dart';
import 'package:twofortwo/services/user_service.dart';

class AuthService {
  final fAuth.FirebaseAuth _auth = fAuth.FirebaseAuth.instance;

  // create user obj based on User
  FUser _userFromUser(
    fAuth.User? user,
  ) {
    if (user == null) {
      return FUser(uid: "");
    }
    return FUser(uid: user.uid, email: user.email);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      fAuth.UserCredential result = await _auth.signInAnonymously();
      fAuth.User? user = result.user;
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // auth change user stream
  Stream<FUser> get user {
    return _auth
        .authStateChanges()
        .map((fAuth.User? user) => _userFromUser(user));
  }

  // sign in with email & password
  Future signIn(String email, String password) async {
    try {
      fAuth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      fAuth.User? user = result.user;

      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String name, String surname, String email,
      String phone, String password) async {
    // TODO: name, phone, etc.
    try {
      fAuth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      fAuth.User? user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData(
          name,
          surname,
          phone,
          email,
          CategoryService().allCategories); //setter TODO: update userdetails categories

      return _userFromUser(user);
    } catch (e) {
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
