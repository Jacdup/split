import 'package:flutter/material.dart';
import 'package:twofortwo/routing_constants.dart';
import 'package:twofortwo/service_locator.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import 'package:twofortwo/screen_size.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  List<String> _locations = ['Stellenbosch', 'Rustenburg', 'buenos aires']; // Option 2
  String _selectedLocation; // Option 2

  final userName = TextEditingController();
  final userSurname = TextEditingController();
  final userEmail = TextEditingController();
  final userPhone = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userName.dispose();
    userSurname.dispose();
    userEmail.dispose();
    userPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[400],
        floatingActionButton: FloatingActionButton(onPressed: () {
          locator<LocalStorageService>().hasSignedUp = true;
         // var userInput = myController.text;
         // print('userinput = $userInput');

          //Navigator.pop(context);
          Navigator.pushReplacementNamed(context, CategoryRoute);
          //dispose();// TODO: Where to dispose?
          //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeViewRoute));
        }),
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top: 100 ),
            //height: screenHeight(context, dividedBy: 1, reducedBy: 200) ,
            width: screenWidth(context,dividedBy: 1.5),
            child: Column(
              children: [
                TextField(
                  controller: userName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: userSurname,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Surname',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: userEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: userPhone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                ),
                SizedBox(height: 20),
                //createDropDown(context),
                DropdownButton(
                  hint: Text('Please choose a location'), // Not necessary for Option 1
                  value: _selectedLocation,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLocation = newValue;
                    });
                  },
                  items: _locations.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                )
              ], // Children
            ),
          ),
        ));
  }


}

