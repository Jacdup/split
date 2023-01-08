import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:twofortwo/services/database.dart';


class PushNotificationsManager {


  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//  final DatabaseService _db;
//  final Firestore _db = Firestore.instance;

  bool _initialized = false;

  Future<void> init(String uid) async {
//    print("In here !!!!!!!!!!!");
    if (!_initialized) {

      // Initialize callbacks:
      // TODO: I copied this code from https://stackoverflow.com/questions/65056272/how-to-configure-firebase-messaging-with-latest-version-in-flutter
      // It should still be customised to split usecase
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        print("onResume: $message");
        // Navigator.pushNamed(context, '/message',
        //     arguments: MessageArguments(message, true));
      });
//       _firebaseMessaging.configure(
//         onMessage: (Map<String, dynamic> message) async {
//           print("onMessage: $message");
//
// //          final snackbar = SnackBar(
// //            content: Text(message['notification']['title']),
// //            action: SnackBarAction(label: 'Go', onPressed: () => null,),// TODO: add action here, that user goes to specific screen
// //          );
// //          Scaffold.of(context).showSnackBar(snackbar);
//         },
//         onResume: (Map<String, dynamic> message) async {
//           print("onResume: $message");
//         },
//         onLaunch: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//       },
//
//       );


      // For testing purposes print the Firebase Messaging token
//      String fcmToken = await _firebaseMessaging.getToken();
//      print("FirebaseMessaging token: $fcmToken");
//      print("!!!!!!!!!!!!!");

      // For iOS request permission first.
      if (Platform.isIOS) {
//        iosSubscription = _firebaseMessaging.onIosSettingsRegistered.listen((data) async {
//          var fcmToken = _getDeviceToken();
//          dynamic result = await DatabaseService(uid: uid).saveDeviceToken(fcmToken);
//        });
        _firebaseMessaging.requestPermission();
      }else{
//        var fcmToken = _getDeviceToken();
//      print("!!!!!!!!!!!!");
        String fcmToken = await _firebaseMessaging.getToken(); //TODO, abstract this to function
        _firebaseMessaging.subscribeToTopic("itemsRequested"); // All users subscribed to this topic. TODO: option to unsubscribe in profile
//        _firebaseMessaging.subscribeToTopic("users/$uid/messages");

        await DatabaseService(uid: uid).saveDeviceToken(fcmToken);
      }


      _initialized = true;
    }
  }


}