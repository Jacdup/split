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
import 'package:twofortwo/ui/screens/home/available_list.dart';
import 'package:overlay_container/overlay_container.dart';

class BorrowListPortrait extends StatefulWidget {
//  final List<dynamic> chosenCategories;
  final User user;
  BorrowListPortrait({Key key, this.user}) : super(key: key);

  @override
  _BorrowListPortraitState createState() => _BorrowListPortraitState();
}

class _BorrowListPortraitState extends State<BorrowListPortrait>
    with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  final localStorageService = locator<LocalStorageService>();
  List<dynamic> userCategories = [];

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
    final itemsAvailable = Provider.of<List<ItemAvailable>>(context) ?? [];

    return StreamBuilder<User>(
        stream: DatabaseService(uid: widget.user.uid).userData, // Access stream
        builder: (context, snapshot) {
//          print(snapshot);
          if (snapshot.hasData) {
            User userData = snapshot.data;
            userCategories = userData.categories;
//            return DefaultTabController(
//                length: 2,
//                initialIndex: 0,
            return new Scaffold(
              drawer: SizedBox(
                width: MediaQuery.of(context).size.width * 0.65, //20.0,
                child: _buildDrawer(context, userData),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pushNamed(context, NewItemRoute,
                      arguments:
                          userData.uid); // TODO: Can send userData to route
                },
                label: Text('Add item'),
                icon: Icon(Icons.add),
                backgroundColor: customYellow1,
              ),
              body: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      _createHeader(userData.name, innerBoxIsScrolled),
                    ];
                  },
                  body: new TabBarView(
                    children: <Widget>[
                      new RequestList(
                          chosenCategories: userCategories,
                          allItems: items,
                          name: 'tab1'),
                      new AvailableList(
                          chosenCategories: userCategories,
                          allItems: itemsAvailable,
                          name: 'tab2'),
                    ],
                    controller: _tabController,
                  )),
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

  Widget _createHeader(String userName, bool innerBoxIsScrolled) {
    return SliverAppBar(
//      snap: true,
//    leading: IconButton(icon: Icon(Icons.menu),onPressed:(){ _buildDrawer(context);},),
      floating: false,
      pinned: true,
      forceElevated: innerBoxIsScrolled,
      title:
//        IconButton(icon: Icon(Icons.menu), color: Colors.white,),

          Text(
        'Welcome $userName!',
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
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
                children: <Widget>[
                  //TODO
//                    Text(
////                      'Welcome $userName!',
////                      style: TextStyle(color: Colors.white, fontSize: 20.0),
//                    ),
                ],
              ),
            ],
          ),
        ),
        background: Image.asset(
          'split_new_blue1.png',
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
          unselectedLabelColor: Colors.black38,
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

  Widget _buildDrawer(context, User userData) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
                child: Column(
              children: <Widget>[
                Text('Menu'),
                SizedBox(
                  height: 20.0,
                ),
                CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.deepOrangeAccent,
                  child: Text(
                    userData.name.substring(0, 1) +
                        userData.surname.substring(0, 1),
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                )

//    )
              ],
            )),
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
              title: Text('Edit items'),
              onTap: () {
                Navigator.pop(context); // This one for the drawer
                Navigator.pushNamed(context, UpdateItemRoute);
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
//            numType[1]: num,
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
