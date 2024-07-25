import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/services/category_service.dart';
import 'package:twofortwo/services/filter.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/ui/screens/user/user_item_list.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/screen_size.dart';

class UserItemDetails extends StatefulWidget {

  final User userData;

  UserItemDetails({required this.userData});

  @override
  _UserItemDetailsState createState() => _UserItemDetailsState();
}

class _UserItemDetailsState extends State<UserItemDetails> with SingleTickerProviderStateMixin{


  late TabController _tabController;
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
//    print(userData);

    final items = Provider.of<List<Item>>(context) ?? [];
    List<Item> thisUserItems = [];


    // Assign items that this user posted
    items.forEach((thisItem){
      if (thisItem.uid == userData.uid){
        thisUserItems.add(thisItem);
      }
    });

    thisUserItems = Filter().sortByDate(thisUserItems);

            return Scaffold(
              appBar: _profileAppBar(userData, userData.uid),
              body: Container(
                child: new TabBarView(
                  children: <Widget>[
                    new UserList(chosenCategories: CategoryService().allCategories, allItems: thisUserItems, pageStorageKey: 'Tab 1',uid: userData.uid, isTab1: true,),
                    new UserList(chosenCategories: CategoryService().allCategories, allItems: thisUserItems, pageStorageKey: 'Tab 2',uid: userData.uid, isTab1: false,),
                  ],
                  controller: _tabController,
                ),
              ),
            );

//      );

  }

  _profileAppBar(User userData, String tag){
    return PreferredSize(
      preferredSize:  Size.fromHeight(screenHeight(context, dividedBy: 4.4 )), // TODO
      child: Container(
        padding: EdgeInsets.fromLTRB(0,30,0,0),
        color: customBlue5,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                BackButton(onPressed: (){Navigator.pop(context);}),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 48.0),//TODO, responsive. Well, an IconButton has a min size of 48 pixels.
                    child: Hero(
                      tag: 'profilePic$tag',
                      child: CircleAvatar(
                        radius: screenHeight(context, dividedBy: 18),
                        backgroundColor: Colors.deepOrangeAccent,
                        child: Text(
                          userData.name.substring(0, 1) +
                              userData.surname!.substring(0, 1),
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
//            Text(userData.email),
//            Text(userData.phone),
//            SizedBox(height: 20,),
            Expanded(
              child: Container(
                color: customBlue5,
                child: TabBar(
                    indicatorColor: customYellow2,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 4.0,
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.black38,
                    tabs: [
                      new Tab(child: Text("Available", style: tabFont,)),
                      new Tab(child: Text("Requested", style: tabFont,)),
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
