import 'package:url_launcher/url_launcher.dart';

class LaunchWhatsapp {

  final String phoneNumber;
  final String message;

  LaunchWhatsapp({this.phoneNumber, this.message});

  launchWhatsApp() async {
    String phoneNumberWithCountryCode = "+27" + phoneNumber;
    var whatsappUrl = "whatsapp://send?phone=$phoneNumberWithCountryCode&text=${message == null ? '' : message}";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}