import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twofortwo/services/button_presses.dart';
import 'package:twofortwo/services/category_service.dart';
import 'package:twofortwo/services/filter.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/shared/loading.dart';
import 'package:twofortwo/ui/screens/home/request_list.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/ui/screens/home/available_list.dart';
import 'package:twofortwo/ui/screens/home/drawer.dart';

class BorrowListPortrait extends StatefulWidget {

  @override
  _BorrowListPortraitState createState() => _BorrowListPortraitState();
}

class _BorrowListPortraitState extends State<BorrowListPortrait>
    with SingleTickerProviderStateMixin{

  TabController _tabController;
  ScrollController _scrollController;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabIndex);
    _tabController.animation.addListener(() {_handleTabIndex();}); // This makes the FAB respond faster to tab changes
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  _handleTabIndex() {
    setState(() {
      //_currentIndex = _tabController.index;
    });
  }

//  void _listener(){
//    setState(() {
//      //_currentIndex = _tabController.index;
//    });
//  }


  @override
  Widget build(BuildContext context) {
    final itemsTemp = Provider.of<List<Item>>(context) ?? [];
    final itemsAvailableTemp = Provider.of<List<ItemAvailable>>(context) ?? [];
    final User userData = Provider.of<User>(context).runtimeType == User //https://stackoverflow.com/questions/61818855/flutter-provider-type-listdynamic-is-not-a-subtype-of-type-user
        ? Provider.of<User>(context)
        : null;

    final items1 = Filter().sortRequestedByDate(itemsTemp);
    final itemsAvailable1 = Filter().sortAvailableByDate(itemsAvailableTemp);

          if (userData != null) {
//            print(userData.categories);

//            final items = Filter().filterRequestedByCategory(items1, userData.categories);
//            final itemsAvailable = Filter().filterAvailableByCategory(itemsAvailable1, userData.categories);

            return new Scaffold(
              drawer: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6, //20.0,
                child: MenuDrawer(userData: userData,),
//              child: _buildDrawer(context, userData),
            ),
              floatingActionButton: _actionButtons(userData.uid),
              body: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      _createHeader(userData.name, innerBoxIsScrolled),
                    ];
                  },
                  body: Consumer<CategoryService>(
                      builder: (context, categoryModel, child) =>TabBarView(
                      children: <Widget>[
//                        Text("${categoryModel.userCategories}"),
                         AvailableList(
                            allItems: Filter().filterAvailableByCategory(itemsAvailable1, categoryModel.userCategories),uid: userData.uid,
                            name: 'tab2'),
                         RequestList(
                            allItems: Filter().filterRequestedByCategory(items1, categoryModel.userCategories) ,uid: userData.uid,
                            name: 'tab1'),
                      ],
                      controller: _tabController,
                    ),
                  ),
              ),
            );
          } else {
            return Loading();
          }
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
            new Tab(child: Text("Available", style: tabFont,), ),
            new Tab(child: Text("Requested",style: tabFont,)),
          ],
          controller: _tabController,
        ),
      ),
    );

    // );
  }

  Widget _actionButtons(String uid){

//  print(tabPosition);
    return _tabController.animation.value < 0.5 ?
    FloatingActionButton.extended(
      onPressed: () {
//        print(_currentIndex);
//        print(_scrollController.offset);
        Navigator.pushNamed(context, NewItemRoute,
            arguments: [uid, false]);
      },
      label: Text('Add item'),
      icon:  Icon(Icons.add),
      backgroundColor: customYellow1,
    )
        : FloatingActionButton.extended(
      onPressed: () {
//        print(_scrollController.offset);

        Navigator.pushNamed(context, NewItemRoute,
            arguments: [uid,true]);
      },
      label: Text('Request item'),
      icon: Icon(Icons.add),
      backgroundColor: customYellow1,
    );
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

//  Widget _buildItemInfo(BuildContext context, int num, bool vis) {
//    return AnchoredOverlay(
//      showOverlay: true,
//      overlayBuilder: (context, offset) {
//        return CenterAbout(
//          position: Offset(offset.dx, offset.dy + 50.0),
//
////      return Hero(
////        tag: 'row$num',
//          child: ItemInfo(
////            numType[1]: num,
//              ),
//
////      child: Container(
////
////        margin: const EdgeInsets.all(50.0),
////        color: Colors.white,
////        child: Center(
////          child: Card(
////
////            child: Text(
////
////              'test$num', style: TextStyle(color: Colors.black),
////            ),
////          ),
////        ),
////      ),
////      );
//        );
//      },
//    );
//  }
}
