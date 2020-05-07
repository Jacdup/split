import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/services/database.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:twofortwo/shared/loading.dart';
import 'package:twofortwo/ui/screens/user/user_item_list.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/screen_size.dart';
import '../home/request_list.dart';
import '../home/available_list.dart';
import 'package:twofortwo/shared/constants.dart';

class UserItemDetails extends StatefulWidget {

  final User userData;

  UserItemDetails({this.userData});

  @override
  _UserItemDetailsState createState() => _UserItemDetailsState();
}

class _UserItemDetailsState extends State<UserItemDetails> with SingleTickerProviderStateMixin{


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
    final User userData = widget.userData;
    print(userData);

    final items = Provider.of<List<Item>>(context) ?? [];
    final itemsAvailable = Provider.of<List<ItemAvailable>>(context) ?? [];

    List<ItemAvailable> thisUserItemsAvailable = [];
    List<Item> thisUserItemsRequested = [];


    // Assign items that this user posted
    itemsAvailable.forEach((thisItem){
      if (thisItem.uid == userData.uid){
        thisUserItemsAvailable.add(thisItem);
      }
    });
    items.forEach((thisItem){
      if (thisItem.uid == userData.uid){
        thisUserItemsRequested.add(thisItem);
      }
    });



            return Scaffold(
              appBar: _profileAppBar(userData, userData.uid),
              body: new TabBarView(
                children: <Widget>[

                  new UserList(chosenCategories: categories, allAvailableItems: thisUserItemsAvailable, allRequestedItems: thisUserItemsRequested, name: 'Tab 1',uid: userData.uid, isTab1: true,),
                  new UserList(chosenCategories: categories, allAvailableItems: thisUserItemsAvailable, allRequestedItems: thisUserItemsRequested, name: 'Tab 1',uid: userData.uid, isTab1: false,),
//                  new AvailableList(chosenCategories: _categories,allItems: thisUserItemsAvailable, name: 'Tab 1',uid: userData.uid,),
//                  new RequestList(chosenCategories: _categories, allItems: thisUserItemsRequested, name:  'Tab 2', uid: userData.uid,),
//              new RequestList(allItems: items, name: 'tab1', uid: uid,),
//              new AvailableList(allItems: itemsAvailable, name: 'tab2', uid: uid),
                ],
                controller: _tabController,
              ),
              floatingActionButton: FloatingActionButton(onPressed: (){},),
            );

//      );



  }

  _profileAppBar(User userData, String tag){
    return PreferredSize(
      preferredSize:  Size.fromHeight(screenHeight(context, dividedBy: 4 )), // TODO
      child: Container(
        padding: EdgeInsets.fromLTRB(0,30,0,0),
        color: customBlue5,


//        automaticallyImplyLeading: false,
//        centerTitle: true,
        child: Column(
          children: <Widget>[
//            IconButton(alignment: Alignment.centerLeft,icon: Icon(Icons.arrow_back)),
            Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_back), iconSize: 32.0,onPressed: (){Navigator.pop(context);},),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50.0),//TODO, responsive
                    child: Hero(
                      tag: 'profilePic$tag',
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.deepOrangeAccent,
//              child: Image.asset('split_new_blue1.png'),
                        child: Text(
                          userData.name.substring(0, 1) +
                              userData.surname.substring(0, 1),
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(userData.email),
            Text(userData.phone),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                color: customBlue2,
                child: TabBar(
                    indicatorColor: customYellow2,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 4.0,
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.black38,
                    tabs: [
                      new Tab(text: "Available"),
                      new Tab(text: "Requested"),
                    ],
                    controller: _tabController,
                ),
              ),
            ),

          ],

        ),

      ),
    );
  }





}
