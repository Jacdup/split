import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/services/item_service.dart';
import 'request_list.dart';
import 'available_list.dart';

class UpdateItemDetails extends StatefulWidget {

  final String uid;

  UpdateItemDetails({this.uid});

  @override
  _UpdateItemDetailsState createState() => _UpdateItemDetailsState();
}

class _UpdateItemDetailsState extends State<UpdateItemDetails> with SingleTickerProviderStateMixin{

  TabController _tabController;
//  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
//    _scrollController = new ScrollController();
    _tabController = new TabController(length: 2, vsync: this);
  }



  @override
  Widget build(BuildContext context) {
    final String uid = widget.uid;

//    final items = Provider.of<List<Item>>(context) ?? [];
//    final itemsAvailable = Provider.of<List<ItemAvailable>>(context) ?? [];

    return Scaffold(
//      appBar: AppBar(title: Text('My items'),),
      body:
           new TabBarView(
            children: <Widget>[
              Text('My items'),
              Text('My items2'),
//              new RequestList(allItems: items, name: 'tab1', uid: uid,),
//              new AvailableList(allItems: itemsAvailable, name: 'tab2', uid: uid),
            ],
            controller: _tabController,
          ),
    );
  }
}
