import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:twofortwo/main.dart';
import 'package:twofortwo/services/button_presses.dart';
import 'package:twofortwo/services/database.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:twofortwo/shared/widgets.dart';
import 'package:twofortwo/ui/screens/home/contact_item.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/utils/screen_size.dart';

class AvailableList extends StatefulWidget {
  final List<ItemAvailable?> allItems;
  final String name;
  final String uid;
  final String? searchTerm;

  AvailableList({required this.allItems, required this.name, required this.uid, this.searchTerm});

  @override
  _AvailableListState createState() => _AvailableListState();
}

class _AvailableListState extends State<AvailableList> {
  List<bool> _infoShow = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late List<ItemAvailable> items;

  void _onRefresh() async {
    // monitor network fetch
    //TODO
//    items = Provider.of<List<ItemAvailable>>(context, listen: false) ?? []; // This is stupid. It just gets the same list.
//    print(items);
    await Future.delayed(Duration(milliseconds: 500));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    //TODO
//    items = Provider.of<List<ItemAvailable>>(context, listen: false) ?? [];
//    print(items);
//    ProxyProvider(update: (context, value, previous) {
//      return Provider.of<List<ItemAvailable>>(context);
//    });

    await Future.delayed(Duration(milliseconds: 500));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
//    items.add((items.length+1).toString());
    if (mounted) setState(() {});
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
//    items = widget.allItems;
    var numItems = 0;
    if (widget.allItems != null) {
      numItems = widget.allItems.length;
    }

    for (var i = 0; i <= numItems; i++) {
      _infoShow.add(false);
    }
    if (widget.allItems == null) {
      return Center(
        child: Text("No items"),
      );
    } else {
//    return Stack(
//      children: <Widget>[
      return SmartRefresher(
          enablePullDown: true,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          controller: _refreshController,
          header: WaterDropMaterialHeader(),
          child: _buildBorrowList(widget.allItems, widget.name));
//        _contactShow ?  _layer(): SizedBox.shrink() ,
//      ],
//    );
    }
  }

  Widget _buildBorrowList(List<ItemAvailable?> allItems, String name) {
    double _buildBox = 0;
    int i = 0;
//    print(allItems[0].itemName);

    return allItems.isEmpty
        ? Center(
            child: Text("No items"),
          )
        : ListView.builder(
            key: PageStorageKey<String>(name), // Keeps track of scroll position
            padding: const EdgeInsets.all(10.0),
            itemCount: allItems.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == allItems.length - 1) {
                _buildBox = 0;
              }
//        if (chosenCategories.any((item) => allItems[index].categories.contains(item)))  {
//          i = i + 1;
              // Non - case sensitive search
              return widget.searchTerm == null || widget.searchTerm == ""
                  ? _buildRow(allItems[index], index, _buildBox)
                  : allItems[index]!
                          .itemName
                          .toLowerCase()
                          .contains(widget.searchTerm!.toLowerCase())
                      ? _buildRow(allItems[index], index, _buildBox)
                      : new Container();

              ;
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
//            return Center();
////          }
////        }
            },
//      separatorBuilder: (BuildContext context, int index) => const Divider(),
          );
  }

  Widget _buildRow(ItemAvailable? item, int num, double buildBox) {
//    List<String> category = item.categories;
    String itemName = item!.itemName;
    String description = item.description;
    String startDate = item.startDate;
    String endDate = item.endDate;
//    print(itemName);
//    print(startDate);
    // final bool alreadySaved = _saved.contains(pair);
    return Hero(
      tag: "row$num 2",
      child: Wrap(
        children: <Widget>[
          Card(
            margin: EdgeInsets.fromLTRB(0, 10, 0, buildBox),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            elevation: 3.0,
            child: Column(
              children: <Widget>[
                (item.price == null && item.pricePeriod == null) ? _buildNonLeadingListTile(item, itemName, description, startDate, endDate,num):
                _buildLeadingListTile(item, itemName, description, startDate, endDate,num),
                Visibility(
                  visible: _infoShow[num],
                  child: Row(
                    children: <Widget>[
                      //TODO: add this when spam does something
//                      FlatButton(
//                        child: Text('spam', style: spamFont,textAlign: TextAlign.left,),
//                        onPressed: () => AlertDialog(),
//                      ),
                      Spacer(),
                      ButtonBar(
                        children: <Widget>[
                          TextButton(
                            child: const Text('Request to borrow'),
                            onPressed: () {
                              /* send ping to item user, with thisUser info */
                              _confirmHelp(context, item);
                            },
                          ),
                          TextButton(
                            child: const Text('Contact'),
                            onPressed: () {
                              // There are multiple ways of overlaying a widget unto blurry screen.
                              // This seems to be easiest, and fastest
                              Object arg = {
                                "uid": widget.uid,
                                "docRef": item.docRef,
                                "type": true
                              };
                              Navigator.of(context).pushNamed(
                                  contactItemOwnerRoute,
                                  arguments: arg);

//    showDialog(
//    context: context,
//    builder: (BuildContext context) {return AlertDialog(content: createContactDialog(context),);});

//                              showContact.value = ItemInfo(userUid: widget.uid,itemID: item.docRef,type: true,);
                            },
                          ),
                        ],
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
  Widget _buildLeadingListTile(item, itemName, description, startDate, endDate,num){
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(8.0,8.0,8.0,8.0),
      leading: Container(
        width: 60.0,
        //padding: const EdgeInsets.all(8.0),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            item.price == null ? SizedBox.shrink() : Text('R' + item.price.toString(), style: priceFont),
            Text(pricePeriod[item.pricePeriod], style: item.pricePeriod == 0 ? priceFreeFont: itemDateFromTo)
          ],
        ),
      ),
      title: Text(
        itemName,
        style: itemHeaderFont,
      ),
      subtitle: Text(
        description,
        style: itemBodyFont,
      ),
      trailing: (item.startDate == null) || (item.startDate == "null")
          ? Text('')
          : _buildDatesTrailing(startDate, endDate),
      onTap: () {
        _toggleDropdown(num);
      },
    );
  }
  Widget _buildNonLeadingListTile(item, itemName, description, startDate, endDate,num){
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(8.0,8.0,8.0,8.0),
      title: Text(
        itemName,
        style: itemHeaderFont,
      ),
      subtitle: Text(
        description,
        style: itemBodyFont,
      ),
      trailing: (item.startDate == null) || (item.startDate == "null")
          ? Text('')
          : _buildDatesTrailing(startDate, endDate),
      onTap: () {
        _toggleDropdown(num);
      },
    );
  }

  Widget _buildDatesTrailing(String startDate, String endDate) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          "Availability",
          style: itemDateTitle,
        ),
        RichText(
          text: TextSpan(
              text: "From: ",
              style: itemDateFromTo,
              children: <TextSpan>[
                TextSpan(
                  text: startDate == null ? " " : startDate,
                  style: itemDate,
                ),
              ]),
        ),
        RichText(
          text: TextSpan(
              text: "To: ",
              style: itemDateFromTo,
              children: <TextSpan>[
                TextSpan(
                  text: endDate == null ? " " : endDate,
                  style: itemDate,
                ),
              ]),
        ),
      ],
    );
  }

  _confirmHelp(context, ItemAvailable item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirmation"),
          content: new Text(
              "This will send your contact details to the user that listed this item. Proceed?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Yes"),
              onPressed: () async {
                ButtonPresses().onSendMessage(
                    widget.uid,
                    item.docRef,
                    "I would like to borrow this item (${item.itemName}) you listed. Please contact me.",
                    "",
                    true);
                Navigator.of(context).pop(false);
              },
            ),
            new TextButton(
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

//  Widget _contact(){
//
//    return Container(
//      decoration: BoxDecoration(
//          color: Colors.white,
//          border: Border.all(color: Colors.black54,width: 3.0)
//      ),
//      margin: const EdgeInsets.fromLTRB(50.0, 200.0, 50.0, 200.0),
////            position: Offset(offset.dx, offset.dy),
////        color: Colors.white,
//      child: Center(
//        child: Hero(
//          tag: "row$num 2",
//          child: Card(
////            child: Text(
////              'test${widget.num}', style: TextStyle(color: Colors.black),
////            ),
//              elevation: 4.0,
//              child: Column(
//                children: <Widget>[
//                  Center(child: Text("TODO"))
//                ],
//              )
//
//          ),
//        ),
//      ),
//
//    );
//  }
}
