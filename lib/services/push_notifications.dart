import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:twofortwo/services/database.dart';
//import 'database.dart';


class PushNotificationsManager {


  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//  final DatabaseService _db;
//  final Firestore _db = Firestore.instance;

  bool _initialized = false;

  Future<void> init(String uid) async {
    print("In here !!!!!!!!!!!");
    if (!_initialized) {

      // Initialize callbacks:
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");

          final snackbar = SnackBar(
            content: Text(message['notification']['title']),
            action: SnackBarAction(label: 'Go', onPressed: () => null,),// TODO: add action here, that user goes to specific screen
          );
//          Scaffold.of(context).showSnackBar(snackbar);
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
        onLaunch: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },

      );


      // For testing purposes print the Firebase Messaging token
      String fcmToken = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $fcmToken");
      print("!!!!!!!!!!!!!");

      // For iOS request permission first.
      if (Platform.isIOS) {
//        iosSubscription = _firebaseMessaging.onIosSettingsRegistered.listen((data) async {
//          var fcmToken = _getDeviceToken();
//          dynamic result = await DatabaseService(uid: uid).saveDeviceToken(fcmToken);
//        });
        _firebaseMessaging.requestNotificationPermissions();
      }else{
//        var fcmToken = _getDeviceToken();
        String fcmToken = await _firebaseMessaging.getToken(); //TODO, abstract this to function
        dynamic result = await DatabaseService(uid: uid).saveDeviceToken(fcmToken);
      }


      _initialized = true;
    }
  }

  String _getDeviceToken(){
//    print("FirebaseMessaging token: $fcmToken");
    print("Retrieving FCM token");
    _firebaseMessaging.getToken().then((String result) {
      return result;
    });
  }

}