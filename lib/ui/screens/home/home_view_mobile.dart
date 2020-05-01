import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twofortwo/services/auth.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/shared/loading.dart';
import 'package:twofortwo/ui/screens/home/item_info_view.dart';
import 'package:twofortwo/ui/screens/home/request_list.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/overlay.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import 'package:twofortwo/utils/service_locator.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/services/database.dart';
import 'package:overlay_container/overlay_container.dart';

class BorrowListPortrait extends StatefulWidget {

  final List<String> chosenCategories;
  final User user;
  BorrowListPortrait(
      {Key key, this.chosenCategories, this.user})
      : super(key: key);

  @override
  _BorrowListPortraitState createState() => _BorrowListPortraitState();
}

class _BorrowListPortraitState extends State<BorrowListPortrait> with SingleTickerProviderStateMixin {//TODO, dont know what this does


  final AuthService _auth = AuthService();
  final localStorageService = locator<LocalStorageService>();

  TabController _tabController;
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context) ?? [];



    return StreamBuilder<User>(
        stream: DatabaseService(uid: widget.user.uid).userData, // Access stream
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            User userData = snapshot.data;
//            return DefaultTabController(
//                length: 2,
//                initialIndex: 0,
                return new Scaffold(
                    drawer: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65, //20.0,
                      child: _buildDrawer(context),
                    ),
                    floatingActionButton: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pushNamed(context,
                            NewItemRoute); // TODO: Can send userData to route
                      },
                      label: Text('Add request'),
                      icon: Icon(Icons.add),
                      backgroundColor: Colors.red,
                    ),

                  body: NestedScrollView(
                    controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
                      return <Widget>[
                        _createHeader(userData.name, innerBoxIsScrolled),
                      ];
                  },
                  body: new TabBarView(
                      children: <Widget>[
                        new RequestList(chosenCategories: widget.chosenCategories, allItems: items, name: 'tab1'),
                        new RequestList(chosenCategories: widget.chosenCategories, allItems: items, name: 'tab2'),
//                        _buildBorrowList(widget.chosenCategories, items, 'tab1'),
//                        _buildBorrowList(widget.chosenCategories, items, 'tab2'),
//                        Text("Tab 2"),
                      ],
                          controller: _tabController,
                  )

//                  slivers: <Widget>[
//                  _createHeader(userData.name),
////
//                    new SliverFillRemaining(
//                      child: TabBarView(
//                        controller: controller,
//                        children: <Widget>[
//                          _buildBorrowList(widget.chosenCategories, items),
////                          Text("Tab 2"),
//                          Text("Tab 3"),
//                        ],
//                      ),
//                    ),
//
//                    ],
                  ),
                );
//            );
          } else {
//            print('in here');
//            _auth.logOut();//TODO
//            return Navigator.pushReplacementNamed(context, LoginRoute);
//            return Login();
            return Loading();
          }
        });
  }

//  Widget _buildBorrowList(List<String> chosenCategories, List<Item> allItems, String name) {
//
//    double _buildBox = 0;
////    return SliverList(
////      delegate: SliverChildBuilderDelegate(
////          (BuildContext context, int index) {
////            if (index == (allItems.length)-1){
////              _buildBox = 80;
////            }
////            return _buildRow(allItems[index], index, _buildBox);
////          },
////           childCount:(allItems.length),
////      ),
////    );
//
//    return ListView.separated(
//      key: PageStorageKey<String>(name), // Keeps track of scroll position
//      padding: const EdgeInsets.all(10.0),
//      itemCount: allItems.length,
//      itemBuilder: (BuildContext context, int index) {
//        if (index == allItems.length -1){
//          _buildBox = 80;
//        }
//        return _buildRow(allItems[index], index, _buildBox);
//
//      },
//      separatorBuilder: (BuildContext context, int index) => const Divider(),
//    );
//
//  }
//
//  Widget _buildRow(Item item, int num, double buildBox) {
//    String category = item.category;
//    String itemName = item.itemName;
//    String description = item.description;
//    String date = item.date;
//    // final bool alreadySaved = _saved.contains(pair);
//    return Hero(
//      tag: "row$num",
//      child: Card(
//        margin: EdgeInsets.fromLTRB(0, 0, 0, buildBox),
//          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
//          elevation: 4.0,
//          child: Column(
//            children: <Widget>[
//              ListTile(
//                title: Text(
//                  itemName,
//                  style: _itemFont,
//                ),
//                subtitle: Text(
//                  description,
//                ),
//                trailing: Text(
//                  date,
//                ),
//                onTap: () {
//                  _toggleDropdown(num);
//                },
//              ),
//
//              Visibility(
//                visible: _infoShow[num] ,
//                child: ButtonBar(
//                  children: <Widget>[
//                    FlatButton(
//                      child: const Text('Willing to help'),
//                      onPressed: () {/* send ping to item user, with thisUser info */},
//                    ),
//                    FlatButton(
//                      child: const Text('Contact'),
//                      onPressed: () {
//                        print("row$num");
//                      Navigator.pushNamed(context, getItemInfoRoute, arguments: num,);},
//                    ),
//                  ],
//                ),
//              )
//            ],
//          ),
//      ),
//    );
//  }

  Widget _createHeader(String userName, bool innerBoxIsScrolled) {

    return  SliverAppBar(
//      snap: true,
//    leading: IconButton(icon: Icon(Icons.menu),onPressed:(){ _buildDrawer(context);},),
        floating: false,
        pinned: true,
        forceElevated: innerBoxIsScrolled,
        title:
//        IconButton(icon: Icon(Icons.menu), color: Colors.white,),

        Text('Welcome $userName!', style: TextStyle(color: Colors.white, fontSize: 20.0),),
        centerTitle: true,
        expandedHeight: 200,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.all(10.0),
          centerTitle: true,
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[//TODO
//                    Text(
////                      'Welcome $userName!',
////                      style: TextStyle(color: Colors.white, fontSize: 20.0),
//                    ),
                  ],
                ),

//                Image.asset(
//                  'split.png',
//                  alignment: Alignment.bottomCenter,
//                  width: 110.0,
//                  height: 100.0,
//                ),

              ],
            ),
          ),
          background:  Image.asset(
            'split.png',
            alignment: Alignment.bottomCenter,
            width: 50.0,
            height: 50.0,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.square(30.0),
          child: TabBar(
            indicatorColor: customYellow2,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 4.0,
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.black38 ,
            tabs: [
              new Tab(text: "Items Requested"),
              new Tab(text: "Items Available"),

            ],
            controller: _tabController,
          ),
        ),
      );

    // );
  }

  Widget _buildDrawer(context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(
              color: customBlue5,
            ),
          ),
          ListTile(
              title: Text('Edit categories'),
              onTap: () {
                Navigator.pop(context); // This one for the drawer
                Navigator.pushNamed(context, CategoryRoute);
              }),
          ListTile(
              title: Text('Edit personal data'),
              onTap: () {
                Navigator.pop(context); // This one for the drawer
                Navigator.pushNamed(context, UpdateUserRoute);
              }),
          ListTile(
              title: Text('Logout'),
              onTap: () async {
                Navigator.pop(context); // This one for the drawer
//                Navigator.pushReplacementNamed(context, LoginRoute); // Shouldn't have to call this, the wrapper listens for changes
//                setState(() {
                localStorageService.clear(); //  Remove all saved values
//                });

//                print(localStorageService.stayLoggedIn);
                await _auth.logOut();
//                Navigator.pushReplacementNamed(context, CategoryRoute);
              })
        ],
      ),
    );
  }

  Widget _buildItemInfo(BuildContext context, int num, bool vis) {
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy + 50.0),

//      return Hero(
//        tag: 'row$num',
          child: ItemInfo(
            num: num,
          ),

//      child: Container(
//
//        margin: const EdgeInsets.all(50.0),
//        color: Colors.white,
//        child: Center(
//          child: Card(
//
//            child: Text(
//
//              'test$num', style: TextStyle(color: Colors.black),
//            ),
//          ),
//        ),
//      ),
//      );
        );
      },
    );
  }


}
