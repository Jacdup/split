import 'package:twofortwo/services/user_service.dart';

class Message{

  final String message;
  final String uidFrom;
  final String nameFrom;
  final String surnameFrom;
  final String phoneFrom;
  final DateTime dateSent;
  final String dateRequested;
  final String forItem;
  final bool hasRead;

  Message({this.message, this.uidFrom, this.nameFrom, this.surnameFrom, this.phoneFrom, this.dateSent, this.forItem, this.dateRequested, this.hasRead});



}