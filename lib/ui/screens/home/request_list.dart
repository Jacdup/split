import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/utils/routing_constants.dart';


class RequestList extends StatefulWidget {

  final List<String> chosenCategories;
  final List<Item> allItems;
  final String name;

  RequestList({this.chosenCategories, this. allItems, this.name});

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

  @override
  Widget build(BuildContext context) {

    var numItems = widget.allItems.length;
    for (var i = 0; i <= numItems; i++){
      _infoShow.add(false) ;
    }
    return _buildBorrowList(widget.chosenCategories, widget.allItems, widget.name);
  }

  Widget _buildBorrowList(List<String> chosenCategories, List<Item> allItems, String name) {

    double _buildBox = 0;

    return ListView.separated(
      key: PageStorageKey<String>(name), // Keeps track of scroll position
      padding: const EdgeInsets.all(10.0),
      itemCount: allItems.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == allItems.length -1){
          _buildBox = 80;
        }
        return _buildRow(allItems[index], index, _buildBox);

      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );

  }

  Widget _buildRow(Item item, int num, double buildBox) {
    String category = item.category;
    String itemName = item.itemName;
    String description = item.description;
    String date = item.date;
    // final bool alreadySaved = _saved.contains(pair);
    return Hero(
      tag: "row$num",
      child: Card(
        margin: EdgeInsets.fromLTRB(0, 0, 0, buildBox),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 4.0,
        child: Column(
          children: <Widget>[
            ListTile(
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
                    onPressed: () {/* send ping to item user, with thisUser info */},
                  ),
                  FlatButton(
                    child: const Text('Contact'),
                    onPressed: () {
                      print("row$num");
                      Navigator.pushNamed(context, getItemInfoRoute, arguments: num,);},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
