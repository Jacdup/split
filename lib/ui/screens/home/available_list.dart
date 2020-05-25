import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:twofortwo/main.dart';
import 'package:twofortwo/services/database.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:twofortwo/shared/widgets.dart';
import 'package:twofortwo/ui/screens/home/contact_item.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/shared/constants.dart';

class AvailableList extends StatefulWidget {

  final List<ItemAvailable> allItems;
  final String name;
  final String uid;

  AvailableList({this. allItems, this.name, this.uid});

  @override
  _AvailableListState createState() => _AvailableListState();
}

class _AvailableListState extends State<AvailableList> {
  List<bool> _infoShow = [];
  RefreshController _refreshController =  RefreshController(initialRefresh: false);
  List<ItemAvailable> items;

  void _onRefresh() async{
    // monitor network fetch
    //TODO
//    items = Provider.of<List<ItemAvailable>>(context, listen: false) ?? []; // This is stupid. It just gets the same list.
//    print(items);
    await Future.delayed(Duration(milliseconds: 500));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
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

//    items = widget.allItems;
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
        return SmartRefresher(
          enablePullDown: true,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            controller: _refreshController,
            header: WaterDropMaterialHeader(),
            child: _buildBorrowList(widget.allItems, widget.name)
        );
//        _contactShow ?  _layer(): SizedBox.shrink() ,
//      ],
//    );
    }
  }

  Widget _buildBorrowList(List<ItemAvailable> allItems, String name) {

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
//        if (chosenCategories.any((item) => allItems[index].categories.contains(item)))  {
//          i = i + 1;
          return _buildRow(allItems[index], index, _buildBox);
//        }else{
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
//        }

      },
//      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );

  }

  Widget _buildRow(ItemAvailable item, int num, double buildBox) {
//    List<String> category = item.categories;
    String itemName = item.itemName;
    String description = item.description;
    String startDate = item.startDate;
    String endDate = item.endDate;
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
                  trailing:
                  startDate == null ? Text('') : _buildDatesTrailing(startDate, endDate),
//                        Text(
//                          startDate == null ? " " : startDate,
//                          style: itemDate,
//                        ),
//                        Text(endDate == null ? " " : endDate,
//                          style: itemDate,),
//                    ],
//                  ),
                  onTap: () {
                    _toggleDropdown(num);
                  },
                ),

                Visibility(
                  visible: _infoShow[num] ,
                  child: Row(
                    children: <Widget>[
                      ButtonBar(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: FlatButton(
                              child: Text('spam', style: spamFont,textAlign: TextAlign.left,),
                            ),
                          ),
//                          FractionallySizedBox(widthFactor: 0.2,),
                          FlatButton(
                            child: const Text('Request to borrow'),
                            onPressed: () {/* send ping to item user, with thisUser info */
                              _confirmHelp(context);},
                          ),
                          FlatButton(
                            child: const Text('Contact'),
                            onPressed: () {
                                showContact.value = ItemInfo(userUid: widget.uid,itemID: item.docRef,type: true,);
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

  Widget _buildDatesTrailing(String startDate, String endDate){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
    Text("Availability", style: itemDateTitle,),
    RichText(
    text: TextSpan(text: "From: ",
    style: GoogleFonts.muli(fontSize: 13.0,
    color: Colors.black87, fontWeight: FontWeight.bold),
    children: <TextSpan>[
    TextSpan(text: startDate == null ? " " : startDate,
    style: itemDate, ),
    ]),
    ),
    RichText(
    text: TextSpan(text: "To: ",
    style: GoogleFonts.muli(fontSize: 13.0,
    color: Colors.black87, fontWeight: FontWeight.bold),
    children: <TextSpan>[
    TextSpan(text: endDate == null ? " " : endDate,
    style: itemDate,),
    ]),
    ),
    ],);
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
