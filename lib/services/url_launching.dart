import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchWhatsapp {

  final String phoneNumber;
  final String message;

  LaunchWhatsapp({required this.phoneNumber, required this.message});

  launchWhatsApp() async {
    String phoneNumberWithCountryCode = "+27" + phoneNumber;
    var whatsappUri = Uri(
        scheme: 'whatsapp',
        host: 'send',
        path: '',
        queryParameters: {'phone': phoneNumberWithCountryCode, 'text': message == null ? '' : message});
    // print(httpsUri); // https://example.com/page/?search=blue&limit=10
    var whatsappUrl = "whatsapp://send?phone=$phoneNumberWithCountryCode&text=${message == null ? '' : message}";
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      AlertDialog(title: Text('Error'), content: Text("Trouble getting to Whatsapp. Please make sure you have it installed."),);
      throw 'Could not launch $whatsappUrl';
    }
  }
}