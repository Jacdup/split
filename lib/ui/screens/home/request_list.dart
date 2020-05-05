import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/ui/screens/home/item_info_view.dart';
import 'package:twofortwo/utils/routing_constants.dart';


class RequestList extends StatefulWidget {

  final List<dynamic> chosenCategories;
  final List<Item> allItems;
  final String name;
  final String uid;

  RequestList({this.chosenCategories, this. allItems, this.name, this.uid});

  @override
  _RequestListState createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  final _itemFont = const TextStyle(fontSize: 15.0);
  List<bool> _infoShow = [];

  void _toggleDropdown(int num) {
    setState(() {
      _infoShow[num] = !_infoShow[num];
    });
  }

  double sigmaXVal = 10;
  double sigmaYVal = 10;
  List<int> numType = [0,1];
  int indexStack = 0;
  void _toggleBlur(int num, int rowNum){
    setState(() {
      indexStack = num;
      numType[0] = rowNum;
//      numType[1] = 1;
//      sigmaXVal = num;
//      sigmaYVal = num;
    });
  }
  OverlayEntry _overlayEntry;
  OverlayState overlayState;

  void _insertOverlayEntry() async {
    _overlayEntry = OverlayEntry(builder: (context){
      print('test');
      return ItemInfo(numType: [0,1],);
    },
    );

  }

    void _removeOverlayEntry() {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }

  @override
  Widget build(BuildContext context) {

    overlayState = OverlayState();
//    print(overlayState);

    var numItems = widget.allItems.length;
    for (var i = 0; i <= numItems; i++){
      _infoShow.add(false) ;
    }
    return _buildBorrowList(widget.chosenCategories, widget.allItems, widget.name);

//      child: Stack(
//      index: indexStack,
//      fit: StackFit.loose,
//        children: <Widget>[


//        ItemInfo(numType: numType),
//        Positioned.fill(
//          child: BackdropFilter(
//              filter: ImageFilter.blur(sigmaX: sigmaXVal, sigmaY: sigmaYVal),
//              child: Container(color: Colors.transparent),// Insert into stack only on button press
//          ),
//        ),
//        ],
//      ),





  }

  Widget _buildBorrowList(List<dynamic> chosenCategories, List<Item> allItems, String name) {

    double _buildBox = 0;
    int i = 0;

    return allItems.isEmpty ? Center(child: Text("No items"),) : ListView.builder(
      key: PageStorageKey<String>(name), // Keeps track of scroll position
      padding: const EdgeInsets.all(10.0),

      itemCount: allItems.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == allItems.length -1){
          _buildBox = 80;
          if (i == 0){
            return Center(child: Text("No items in chosen categories"));
          }
        }
        if (chosenCategories.contains(allItems[index].category)){
          i = i + 1;
          return _buildRow(allItems[index], index, _buildBox);
        }else{

//          if (index == allItems.length-1){
//
//          }
//          print(index);
//          if (i == 0){
//            i = i +1;
//            return Center(child: Text("No items in chosen categories"));
//          }else {
            return Center();
//          }
        }



      },
//      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );

  }

  Widget _buildRow(Item item, int num, double buildBox) {
    String category = item.category;
    String itemName = item.itemName;
    String description = item.description;
    String date = item.date;
    // final bool alreadySaved = _saved.contains(pair);
    return Hero(
      tag: "row$num 1",
      child: Card(
        margin: EdgeInsets.fromLTRB(0, 10, 0, buildBox),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 4.0,
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(12.0),
              title: Text(
                itemName,
                style: _itemFont,
              ),
              subtitle: Text(
                description,
              ),
              trailing: Text(
                date,
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
                    child: const Text('Willing to help'),
                    onPressed: () {/* send ping to item user, with thisUser info */
                      _confirmHelp(context);},
                  ),
                  FlatButton(
                    child: const Text('Contact'),
                    onPressed: () {
                      print("row$num");
                      _toggleBlur(1,num);
//                      _insertOverlayEntry();
//                      overlayState.insert(_overlayEntry);
//                      overlayState.insert(_overlayEntry);
                      Navigator.pushNamed(context, getItemInfoRoute, arguments: [num, 1]);
                      },
                  ),
                ],
              ),
            )
          ],
        ),
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
          content: new Text("This will send your contact details to the user that requested this item. Proceed?"),
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
}
