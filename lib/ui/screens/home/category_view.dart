import 'package:flutter/material.dart';
import 'package:twofortwo/main.dart';
import 'package:twofortwo/services/category_service.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/shared/widgets.dart';
import '/services/button_presses.dart';
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

  ChooseCategory({this.itemDetails, required Key key}) : super(key: key);

  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  //int _counter = 0;

  var storageService = locator<LocalStorageService>();
  final List<String> _selectedCategories = [];
  final _biggerFont = const TextStyle(fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final FUser user = Provider.of<FUser>(context,listen: false); // Firestore user (contains uid, email)

    double cardHeight = screenHeight(context, dividedBy: (CategoryService().allCategories.length / 2));

    return ValueListenableBuilder(
        // listens to value of loading
        valueListenable: loading,
        builder: (context, value, child) {
          print(value);
          return value != false
              ? Loading()
              : Scaffold(
                  body: Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
//            height: screenHeight(context, dividedBy: 7),
                          height: 85,
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          color: Colors.transparent,
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 75,
                            ),
                            Expanded(
                              child: GridView.count(
                                childAspectRatio: 1.1,
//                  primary: false,
                                padding: const EdgeInsets.all(10),
                                crossAxisCount: 2,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                                children: List.generate(
                                    CategoryService().allCategories.length,
                                    (index) {
//                      alreadySaved = _selectedCategories.contains(categories[index]);
                                  return Center(
                                    child: _buildCard(
                                        CategoryService().allCategories[index],
                                        cardHeight),
                                  );
//                      );
                                }),
                              ),
                            ),
                          ],
                        ),
                        Container(
//            height: screenHeight(context, dividedBy: 10),
                            height: 70,
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                            color: customBlue5,
                            child: Row(children: <Widget>[
                              BackButton(onPressed: () {
                                Navigator.pop(context);
                              }),
                            ])),
                        Positioned(
                          left: dialogPadding * 2,
                          right: dialogPadding * 2,
//            top: screenHeight(context, dividedBy: 18),
                          top: 45,
                          child: Container(
                              height: dialogPadding * 1.6,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  border: Border.all(color: Colors.amber),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(bRad * 4),
                                  )),
                              child: Center(
                                  child: Text(
                                "Choose Categories",
                                style: tabFont,
                              ))),
//          CircleAvatar(
//            backgroundColor: Colors.blueAccent, //TODO: logo or something
//            radius: AvatarPadding,
//          ),
                        ),
//                        _buildAppBar(),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton.extended(
                    elevation: 8.0,
                    onPressed: () {
//              print(widget.itemDetails.docRef);
                      if (widget.itemDetails == null) {
                        // Came from signup or drawer menu (or error in addItem validator)
                        ButtonPresses().onUpdateUserCategories(
                            context, user.uid, _selectedCategories);
                      } else {
                        if (widget.itemDetails[0].docRef == '1') {
                          // Requested item
                          ButtonPresses().onSelectRequestedItemCategories(
                              widget.itemDetails[0].uid,
                              widget.itemDetails[0],
                              _selectedCategories);
                        } else if (widget.itemDetails[0].docRef == '2') {
                          // Available item
                          ButtonPresses().onSelectAvailableItemCategories(
                              widget.itemDetails[0].uid,
                              widget.itemDetails[0],
                              _selectedCategories);
                        } else {
                          // Updating an item's categories
                          ButtonPresses().onUpdateItemCategories(
                              widget.itemDetails[0].uid,
                              widget.itemDetails[0],
                              widget.itemDetails[1],
                              _selectedCategories);
                        }
                      }
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.done),
                    label: Text(
                      'Select',
                      style: _biggerFont,
                    ),
                    backgroundColor: customYellow1,
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
//                ),
                );
        });
  }

  Widget _buildCard(String category, double cardHeight) {
    final bool alreadySaved = _selectedCategories.contains(category);

    return Container(
      width: screenWidth(context, dividedBy: 2, reducedBy: 0),
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
                  margin: const EdgeInsets.all(8.0),
//                padding: EdgeInsets.all(15.0),
                  child: Text(
                    category,
                    style: _biggerFont,
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
        ),
      ),
    );
  } // _buildCard

  Widget _buildAppBar() {
    return Stack(children: <Widget>[
      Container(
//            height: screenHeight(context, dividedBy: 7),
        height: 85,
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        color: Colors.transparent,
      ),
      Container(
//            height: screenHeight(context, dividedBy: 10),
          height: 70,
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          color: customBlue5,
          child: Row(children: <Widget>[
            BackButton(onPressed: () {
              Navigator.pop(context);
            }),
          ])),
      Positioned(
        left: dialogPadding * 2,
        right: dialogPadding * 2,
//            top: screenHeight(context, dividedBy: 18),
        top: 45,
        child: Container(
            height: dialogPadding * 1.6,
            decoration: BoxDecoration(
                color: Colors.amber,
                border: Border.all(color: Colors.amber),
                borderRadius: BorderRadius.all(
                  Radius.circular(bRad * 4),
                )),
            child: Center(
                child: Text(
              "Choose Categories",
              style: tabFont,
            ))),
//          CircleAvatar(
//            backgroundColor: Colors.blueAccent, //TODO: logo or something
//            radius: AvatarPadding,
//          ),
      ),
    ]);
  }

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
