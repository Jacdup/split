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
import 'package:twofortwo/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/ui/screens/home/available_list.dart';
import 'package:overlay_container/overlay_container.dart';
import 'package:twofortwo/ui/screens/home/drawer.dart';

class BorrowListPortrait extends StatefulWidget {
//  final List<dynamic> chosenCategories;
//  final FUser user;
//  BorrowListPortrait({Key key, this.user}) : super(key: key);

  @override
  _BorrowListPortraitState createState() => _BorrowListPortraitState();
}

class _BorrowListPortraitState extends State<BorrowListPortrait>
    with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
//  final localStorageService = locator<LocalStorageService>();
//  List<dynamic> userCategories = [];

  TabController _tabController;
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _tabController = new TabController(length: 2, vsync: this);
  }

  assumeStrings(List<Object> objects) {
    List<String> strings = objects; // Runtime downcast check
    String string = strings[0]; // Expect a String value
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context) ?? [];
    final itemsAvailable = Provider.of<List<ItemAvailable>>(context) ?? [];
//    print('here before');
    final User userData = Provider.of<User>(context) ?? []; // This motherf&**&er asserts at runtime
//    print('here after');
//    assumeStrings(userData.categories);
//    return StreamBuilder<User>(
//        stream: DatabaseService(uid: widget.user.uid).userData, // Access stream
//        builder: (context, snapshot) {
//          print(snapshot);
          if (userData != null) {
//            User userData = snapshot.data;
//            userCategories = userData.categories ?? [];
//            return DefaultTabController(
//                length: 2,
//                initialIndex: 0,
            return new Scaffold(
              drawer: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6, //20.0,
                child: MenuDrawer(userData: userData,),
//              child: _buildDrawer(context, userData),
            ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                 print(_scrollController.offset);
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
                      new AvailableList(
                          chosenCategories: userData.categories == null ? <String>[] : userData.categories.cast<String>(),
                          allItems: itemsAvailable,
                          name: 'tab2'),
                      new RequestList(
                          chosenCategories: userData.categories == null ? <String>[] : userData.categories.cast<String>(),
                          allItems: items,
                          name: 'tab1'),
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
//        });
  }

  Widget _createHeader(String userName, bool innerBoxIsScrolled) {

    return SliverAppBar(
//      snap: true,
//    leading: IconButton(icon: Icon(Icons.menu),onPressed:(){ _buildDrawer(context);},),
      floating: false,
      pinned: true,
      elevation: 8.0,
      forceElevated: innerBoxIsScrolled,
//      leading: Icon(Icons.menu),
      title: //_getTitle(userName, scrollController),
         Text(
        'Welcome $userName!',
        style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),

//        IconButton(icon: Icon(Icons.menu), color: Colors.white,),
       // TODO: this become Search bar as user scrolls up

      centerTitle: true,
      expandedHeight: 200,

      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: (){
//            showSearch(context: context, delegate: ),
          },
        )
      ],

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
            new Tab(text: "Items Available"),
            new Tab(text: "Items Requested"),
          ],
          controller: _tabController,
        ),
      ),
    );

    // );
  }

//  _getTitle(String userName, ScrollController scrollController){
//    print(scrollController);
//    if (scrollController.offset < 90.0){
//      return Text('Welcome $userName!',
//        style: TextStyle(color: Colors.white, fontSize: 20.0),);
//    }else{
//      return Text('test');
//    }
//  }

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
