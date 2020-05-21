import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:twofortwo/main.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/shared/widgets.dart';
import 'package:twofortwo/ui/screens/home/item_info_view.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/shared/constants.dart';


class RequestList extends StatefulWidget {

  final List<Item> allItems;
  final String name;
  final String uid;

  RequestList({this. allItems, this.name, this.uid});

  @override
  _RequestListState createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {

  List<bool> _infoShow = [];
  RefreshController _refreshController =  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    //TODO
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    //TODO
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
//    items.add((items.length+1).toString());
    if(mounted)
      setState(() {
      });
    _refreshController.loadComplete();
  }
  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }



  void _toggleDropdown(int num) {
    setState(() {
      _infoShow[num] = !_infoShow[num];
    });
  }

  @override
  Widget build(BuildContext context) {

//    overlayState = OverlayState();
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
      return SmartRefresher(
          enablePullDown: true,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          controller: _refreshController,
          header: WaterDropMaterialHeader(),
          child: _buildBorrowList(widget.allItems, widget.name)
      );
    }
  }

  Widget _buildBorrowList(List<Item> allItems, String name) {

    double _buildBox = 0;
    int i = 0;

    return allItems.isEmpty ? Center(child: Text("No items"),) : ListView.builder(
      key: PageStorageKey<String>(name), // Keeps track of scroll position
      padding: const EdgeInsets.all(10.0),

      itemCount: allItems.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == allItems.length -1) {
          _buildBox = 80;
        }
//        if (chosenCategories.any((item) => allItems[index].categories.contains(item))) {
//          i = i + 1;
          return _buildRow(allItems[index], index, _buildBox);
//        }else{
          if (index == allItems.length -1){
            _buildBox = 80;
            if (i == 0){
              return Center(child: Text("No items in chosen categories"));
            }
          }
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
//        }



      },
//      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );

  }

  Widget _buildRow(Item item, int num, double buildBox) {
//    List<String> category = item.categories;
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
                    child: const Text('Willing to help'),
                    onPressed: () {/* send ping to item user, with thisUser info */
                      _confirmHelp(context);},
                  ),
                  FlatButton(
                    child: const Text('Contact'),
                    onPressed: () {
//                      print("row$num");
//                      _toggleBlur(1,num);
//                      showContact.value = "row$num 1";
//                      showContact.value = itemInfo(item.docRef, context);
                      showContact.value = ItemInfo(userUid: widget.uid, itemID: item.docRef,type: false,);
//                      _insertOverlayEntry();
//                      overlayState.insert(_overlayEntry);
//                      overlayState.insert(_overlayEntry);
//                      Navigator.pushNamed(context, getItemInfoRoute, arguments: [num, 1]);
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
