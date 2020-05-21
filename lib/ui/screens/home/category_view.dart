import 'package:flutter/material.dart';
import 'package:twofortwo/main.dart';
import 'package:twofortwo/services/category_service.dart';
import 'file:///C:/Users/19083688/Desktop/Apps/twofortwo/lib/services/button_presses.dart';
import '../../../utils/screen_size.dart';
import '../../../utils/service_locator.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/shared/loading.dart';
//TODO: this should save categories specific to the user on the hard disk

class ChooseCategory extends StatefulWidget {
//  ChooseCategory({Key key}) : super(key: key);
  // final String title;
  final dynamic itemDetails;

  ChooseCategory({this.itemDetails, Key key}) : super(key: key);

  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  //int _counter = 0;

  var storageService = locator<LocalStorageService>();
  final List<String> _selectedCategories = [];
  final _biggerFont = const TextStyle(fontSize: 24.0);

  @override
  Widget build(BuildContext context) {
    final FUser user =
        Provider.of<FUser>(context); // Firestore user (contains uid, email)

    double cardHeight =
        screenHeight(context, dividedBy: (CategoryService().categories.length / 2));

    //    bool alreadySaved = false;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
//    return loading ? Loading() :

    return ValueListenableBuilder( // listens to value of loading
      valueListenable: loading,
      builder: (context, value, child){
      return value ? Loading() :  Scaffold(
              appBar: AppBar(
//              automaticallyImplyLeading: false,
                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                //title: Text(widget.title),
                title: Text('Choose Categories'), centerTitle: true,
              ),

              body: Column(
                children: <Widget>[
                  new Expanded(
                    child: GridView.count(
                      childAspectRatio: 1.1,
//                  primary: false,
                      padding: const EdgeInsets.all(10),
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      children: List.generate(CategoryService().categories.length, (index) {
//                      alreadySaved = _selectedCategories.contains(categories[index]);
                        return Center(
                          child: _buildCard(CategoryService().categories[index], cardHeight),
                        );
//                      );
                      }),
                    ),
                  ),
//                    SizedBox(height: screenHeight(context, dividedBy: 40)),
//                Container(
//                  width: screenWidth(context),
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    boxShadow: [
//                      BoxShadow(
//                        color: Colors.grey.withOpacity(0.8),
//                        spreadRadius: 5,
//                        blurRadius: 10,
//                        offset: Offset(0, 3), // changes position of shadow]
//                      ),
//                    ],
//                  ),
//                  child: Container(
//                    margin: EdgeInsets.fromLTRB(
//                        screenWidth(context, dividedBy: 4), 0,
//                        screenWidth(context, dividedBy: 4),0),
//                    child: ButtonWidget(
//                      icon: Icons.arrow_forward,
//                      onPressed: () async {
//                        _onButtonPress(user.uid);
//                      },
//                    ),
//                  ),
//                ),
                ],
              ),
          floatingActionButton: FloatingActionButton.extended(
            elevation: 8.0,
            onPressed: () {
//              print('!!!!!!!!!!');
//              print(widget.itemDetails);
//              print(widget.itemDetails.itemName);
              if (widget.itemDetails == null){ // Came from signup or drawer menu (or error in addItem validator)
                ButtonPresses().onUpdateCategories(context, user.uid, _selectedCategories);
              }else{
                if (widget.itemDetails.docRef == '1'){ // Requested item
                  ButtonPresses().onSelectRequestedItemCategories(widget.itemDetails.uid, widget.itemDetails, _selectedCategories);
                }else{ // Available item
                  ButtonPresses().onSelectAvailableItemCategories(widget.itemDetails.uid, widget.itemDetails, _selectedCategories);
                }
              }
              Navigator.pop(context);
//              _onButtonPress(user.uid);
            },
            icon: Icon(Icons.done),
            label: Text('Select', style: _biggerFont,),
            backgroundColor: customYellow1,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              );
  }
    );

  }

  Widget _buildCard(String category, double cardHeight) {
    // bool alreadySaved = false;
    //if (_selectedCategories.categories != null){
    final bool alreadySaved = _selectedCategories.contains(category);
    // }//else{
    // final bool
    //  }

    return Container(
      //padding: EdgeInsets.only(top:40),
      //color: Colors.cyan,
      //padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
      width: screenWidth(context, dividedBy: 2, reducedBy: 0),
//      height: cardHeight,
//      height: screenHeightExcludingToolbar(context, dividedBy: 6), //TODO: this causes pixel overflowing error
      // color: Colors.cyan,

      child: Card(
        color: customBlue5,
        elevation: 4.0,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 5,
                color: alreadySaved ? customYellow2 : Colors.transparent,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: InkWell(
            splashColor: customBlue2.withAlpha(70),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  _selectedCategories.remove(category);
                } else {
                  _selectedCategories.add(category);
                }
              });
            },
            child: Center(
              child: Container(
                  margin: const EdgeInsets.all(10.0),
//                padding: EdgeInsets.all(15.0),
                  child: Text(category, style: _biggerFont)),
            ),
          ),
        ),
      ),
    );
  } // _buildCard

//  _onButtonPress(String uid) async {
//    setState(() {
//      loading = true;
//    });
//    dynamic result =
//        await DatabaseService(uid: uid).updateCategory(_selectedCategories);
//
////                      storageService.hasSignedUp = true;
////                      storageService.category = _selectedCategories;
////                      print(_selectedCategories);
////                      print(storageService.category);
//
//    if (result == null) {
//      setState(() {
//        Fluttertoast.showToast(
//            msg: 'Successfully updated categories.',
//            toastLength: Toast.LENGTH_LONG,
//            gravity: ToastGravity.CENTER,
//            fontSize: 20.0);
////                  error = 'Could not sign in, please check details';
//        loading = false;
//      });
//    } else {
//      Fluttertoast.showToast(
//          msg: 'Hmm. Something went wrong.',
//          toastLength: Toast.LENGTH_LONG,
//          gravity: ToastGravity.CENTER,
//          fontSize: 20.0);
//    }
//    Navigator.pop(context);
//  }
}
