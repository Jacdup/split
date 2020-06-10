import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twofortwo/services/database.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/shared/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/shared/widgets.dart';
import 'package:twofortwo/services/button_presses.dart';
import 'package:twofortwo/utils/routing_constants.dart';

class UserList extends StatefulWidget {

  final List<String> chosenCategories;
  final List<ItemAvailable> allAvailableItems;
  final List<Item> allRequestedItems;
  final String name;
  final String uid;
  final bool isTab1;

  UserList({this.chosenCategories, this.allAvailableItems, this. allRequestedItems, this.name, this.uid, this.isTab1});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  List<bool> _infoShow = [];
  List<bool> _notAvailableVal = [];
  bool loading = false;

  void _toggleDropdown(int num) {
    setState(() {
      _infoShow[num] = !_infoShow[num];
    });
  }

  void _toggleAvailable(int num) {
    setState((){
      _notAvailableVal[num] = !_notAvailableVal[num];
    });
  }

  bool _availableSelection = false;
  bool _deleteSelect = false;



  @override
  Widget build(BuildContext context) {

    // Go to available list
   if (widget.isTab1){
     var numItems = 0;
     if (widget.allAvailableItems != null){
       numItems = widget.allAvailableItems.length;
     }
     for (var i = 0; i <= numItems; i++){
       _infoShow.add(false);
       _notAvailableVal.add(false);
     }
     if (widget.allAvailableItems == null){
       return Center(child: Text("No items"),);
     }else{
       return loading ? Loading() : _buildBorrowList(widget.chosenCategories, widget.allAvailableItems, widget.name, widget.isTab1);
     }
   }
   // Go to requested list
   else{
     var numItems = 0;
     if (widget.allRequestedItems != null){
       numItems = widget.allRequestedItems.length;
     }

     for (var i = 0; i <= numItems; i++){
       _infoShow.add(false) ;
       _notAvailableVal.add(false);
     }
     if (widget.allRequestedItems == null){
       return Center(child: Text("No items"),);
     }else{
       return loading ? Loading() : _buildBorrowList(widget.chosenCategories, widget.allRequestedItems, widget.name,widget.isTab1);
     }
   }





  }

  Widget _buildBorrowList(List<String> chosenCategories, List<dynamic> allItems, String name, bool type) {

    double _buildBox = 0;

    return allItems.isEmpty ? Center(child: Text("No items"),) : ListView.builder(
      key: PageStorageKey<String>(name), // Keeps track of scroll position
      padding: const EdgeInsets.all(10.0),
      itemCount: allItems.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == allItems.length -1) {
          _buildBox = 80;
        }
        return _buildRow(allItems[index], index, _buildBox, type);
//        if (chosenCategories.any((item) => allItems[index].categories.contains(item)))  {// Don't know why all this logic is here though
//          i = i + 1;
//          return _buildRow(allItems[index], index, _buildBox, type);
//        }else{
//          if (index == allItems.length -1){
//            _buildBox = 80;
//            if (i == 0) {
//              return Center(child: Text("No items in chosen categories"));
//            }
//          }
////          if (i == 0){
////            i = i + 1;
//
////          }else {
//          return Center();
////          }
//        }

      },
//      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );

  }

  Widget _buildRow(dynamic item, int num, double buildBox, bool type) {
//    List<String> category = item.categories;
    String itemName = item.itemName;
    String description = item.description;
    String date = item.startDate;
    String itemRef = item.docRef;
//    int typeInt;
//    type==true ? typeInt = 2 : typeInt = 1;
    // final bool alreadySaved = _saved.contains(pair);
    return Hero(
//      tag: "row$num $typeInt",
      tag: "row$num 2",
      child: Wrap(
        children: <Widget>[
          Card(
            margin: EdgeInsets.fromLTRB(0, 10, 0, buildBox),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            elevation: 4.0,
            child: Column(
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.all(12.0),
                  title: Text(
                    itemName,
                    style: itemHeaderFont,
                  ),
                  subtitle: Text(
                    description,
                    style: itemBodyFont,
                  ),
                  trailing: Text(
                    date == null ? " " : date,
                    style: itemDate,
                  ),
                  onTap: () {
//                    print("row$num $typeInt");
                    _toggleDropdown(num);
                  },
                ),

                Visibility(
                  visible: _infoShow[num] ,
                  child: Column(
                    children: <Widget>[

                      Row(
                        children: <Widget>[
                          FlatButton(
                            onPressed: (){
                              _toggleAvailable(num);

                            if (!_notAvailableVal[num]){
                          showDialog(context: context,child:
                             CustomDialog(
                          title: "Confirmation",
                          description: "This will hide this item from other users until you mark this item as available again. Proceed?",
                               buttonText1: "Okay",
                               buttonText2: "Cancel",
                                type: type,
                                item: item,
//                               onPressedBtn1:
//                               onPressedBtn2: popDialog(context, num),
                             ));
                        }

                          },
                            child: Text("Available", style: itemHeaderFont,),
                            color: _notAvailableVal[num] ? Colors.green : Colors.red,
                            shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                          ),
                          Spacer(),
                          IconButton(onPressed: (){
//                            print(item);
                            Navigator.pushNamed(context, NewItemRoute, arguments: [widget.uid, 2, item]);
                          },
                            icon: Icon(Icons.edit,),
                            color: Colors.blueGrey,
                            iconSize: 30.0,),
                          Spacer(),
                          IconButton(onPressed: (){
                            _confirmDelete(context, itemRef, type);
                          },
                          icon: Icon(Icons.delete,),
                          color: Colors.red,
                          iconSize: 30.0,),
                        ],
                      ),


//                      CheckboxListTile(value: _notAvailableVal[num], title: Text("Item is currently not available"),
//                        onChanged:(newValue){_toggleAvailable(num);
//                        if (_notAvailableVal[num]){
//                          showDialog(context: context,child:
//                             CustomDialog(
//                          title: "Confirmation",
//                          description: "This will hide this item from other users until you mark this item as available again. Proceed?",
//                               buttonText1: "Okay",
//                               buttonText2: "Cancel",
//                                type: type,
//                                item: item,
////                               onPressedBtn1:
////                               onPressedBtn2: popDialog(context, num),
//                             ));
//                        };
//
//                        }, ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _confirmDelete(context, String documentRef, bool type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirmation"),
          content: new Text("This will permanently delete this item. Proceed?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () async {
                setState(() {
                  loading = true;
                  Navigator.pop(context);
                });

                dynamic result = await DatabaseService().deleteItem(documentRef, type);

                if (result == null) {
                  setState(() {
                    Fluttertoast.showToast(msg: 'Success! Item deleted.', toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.CENTER, fontSize: 20.0);
//                    error = 'Could not add item, please check details';
                    loading = false;
                  });
                } else {
                  Fluttertoast.showToast(msg: 'Hmm. Something went wrong.', toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.CENTER, fontSize: 20.0);
                }
                //TODO
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
//                Fluttertoast.showToast(msg: 'Success! Item deleted.', toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.CENTER, backgroundColor: Colors.red, fontSize: 20.0);
//                Fluttertoast.showToast(msg: 'Success! Item deleted.', toastLength: Toast.LENGTH_LONG);
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
    // return false;
    //return true;
  }

  popDialog(BuildContext context, int num){
//TODO: why is this called forever
  print("in here!!!!!!");
//    setState(() {
//      _notAvailableVal[num] = false;
//    });

  }
}


