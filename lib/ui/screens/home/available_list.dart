import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twofortwo/main.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/shared/widgets.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/shared/constants.dart';

class AvailableList extends StatefulWidget {

  final List<String> chosenCategories;
  final List<ItemAvailable> allItems;
  final String name;
  final String uid;

  AvailableList({this.chosenCategories, this. allItems, this.name, this.uid});

  @override
  _AvailableListState createState() => _AvailableListState();
}

class _AvailableListState extends State<AvailableList> {
  List<bool> _infoShow = [];
  bool _contactShow = false;


  void _toggleDropdown(int num) {
    setState(() {
      _infoShow[num] = !_infoShow[num];
    });
  }

  @override
  Widget build(BuildContext context) {

    var numItems = 0;
    if (widget.allItems != null){
      numItems = widget.allItems.length;
    }

    for (var i = 0; i <= numItems; i++){
      _infoShow.add(false) ;
    }
    if (widget.allItems == null){
      return Center(child: Text("No items"),);
    }else{
//    return Stack(
//      children: <Widget>[
        return _buildBorrowList(widget.chosenCategories, widget.allItems, widget.name);
//        _contactShow ?  _layer(): SizedBox.shrink() ,
//      ],
//    );
    }
  }

  Widget _buildBorrowList(List<String> chosenCategories, List<ItemAvailable> allItems, String name) {

    double _buildBox = 0;
    int i = 0;
//    print(allItems[0].itemName);

    return allItems.isEmpty ? Center(child: Text("No items"),) : ListView.builder(
      key: PageStorageKey<String>(name), // Keeps track of scroll position
      padding: const EdgeInsets.all(10.0),
      itemCount: allItems.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == allItems.length -1) {
          _buildBox = 80;
        }
        if (chosenCategories.any((item) => allItems[index].categories.contains(item)))  {
          i = i + 1;
          return _buildRow(allItems[index], index, _buildBox);
        }else{
          if (index == allItems.length -1){
            _buildBox = 80;
            if (i == 0) {
              return Center(child: Text("No items in chosen categories"));
            }
          }
//          if (i == 0){
//            i = i + 1;

//          }else {
            return Center();
//          }
        }

      },
//      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );

  }

  Widget _buildRow(ItemAvailable item, int num, double buildBox) {
//    List<String> category = item.categories;
    String itemName = item.itemName;
    String description = item.description;
    String date = item.date;
    // final bool alreadySaved = _saved.contains(pair);
    return Hero(
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
                    date,
                    style: itemDate,
                  ),
                  onTap: () {
                    _toggleDropdown(num);
                  },
                ),

                Visibility(
                  visible: _infoShow[num] ,
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('Request to borrow'),
                        onPressed: () {/* send ping to item user, with thisUser info */
                          _confirmHelp(context);},
                      ),
                      FlatButton(
                        child: const Text('Contact'),
                        onPressed: () {
//                          print("row$num");
//                          showContact.value = "row$num 2";
                            showContact.value = itemInfo();
                          // TODO, okay now we have a nice UI, but also a different problem
                          // How to actually send [itemID] (and by extension item.uid, item.name) up the widget tree to home_view
                          // I propose that showContact is a string, containing itemID, and check if it's null

//                          setState(() {
//                            _contactShow = true;
////                            return Stack(
////                              children: <Widget>[
////                                _contact(),
////                                //Navigator.pushNamed(context, getItemInfoRoute, arguments: [num, 2],);
////
////                              ],
////
////                            );
//                          });
//                          Navigator.pushNamed(context, getItemInfoRoute, arguments: [num, 2],);
                          },
                      ),
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

  _confirmHelp(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirmation"),
          content: new Text("This will send your contact details to the user that listed this item. Proceed?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () async {
                //TODO
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
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

  Widget _layer(){
    print("here");

    return Stack(
      children: <Widget>[
        Positioned.fill(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(color: Colors.transparent,),)),
      _contact(),
      ],

    );

  }

  Widget _contact(){

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black54,width: 3.0)
      ),
      margin: const EdgeInsets.fromLTRB(50.0, 200.0, 50.0, 200.0),
//            position: Offset(offset.dx, offset.dy),
//        color: Colors.white,
      child: Center(
        child: Hero(
          tag: "row$num 2",
          child: Card(

//            child: Text(
//              'test${widget.num}', style: TextStyle(color: Colors.black),
//            ),
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  Center(child: Text("TODO"))
                ],
              )

          ),
        ),
      ),

    );
  }
}
