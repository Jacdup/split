import 'package:flutter/material.dart';
import 'package:twofortwo/services/category_service.dart';
import 'package:twofortwo/services/filter.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/shared/constants.dart';
import 'package:twofortwo/ui/screens/home/request_list.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/ui/screens/home/drawer.dart';

class BorrowListPortrait extends StatefulWidget {

  @override
  _BorrowListPortraitState createState() => _BorrowListPortraitState();
}

class _BorrowListPortraitState extends State<BorrowListPortrait>
    with TickerProviderStateMixin{

//  AnimationController _animationController;
  late TabController _tabController;
  late ScrollController _scrollController;
  late TextEditingController  _searchController;
  bool _showSearchBar = false;
  FocusNode _searchNode = FocusNode();

  String filter = "";
//  Widget _titleBar;
//  RefreshController  _refreshController;

  @override
  void initState() {
    super.initState();
    _searchController = new TextEditingController();
    _searchController.addListener(() {
      setState(() {
        filter = _searchController.text;
      });
    });

    _scrollController = new ScrollController();

    _tabController = new TabController(length: 1, vsync: this);
    _tabController.addListener(_handleTabIndex);
    _tabController.animation!.addListener(() {_handleTabIndex();}); // This makes the FAB respond faster to tab changes
  }

  @override
  void dispose() {
    _searchNode.dispose();
    _searchController.dispose();
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _handleTabIndex() {
    setState(() {
    });
  }



  @override
  Widget build(BuildContext context) {
    Filter thisFilter = new Filter();
    final itemsRequestedFromFirestore = Provider.of<List<Item>>(context);
    final User userData = Provider.of<User>(context);

    List<Item> itemsRequested = thisFilter.sortByDate(itemsRequestedFromFirestore);
    var categories = CategoryService.categories;

          return Scaffold(
            drawer: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6, //20.0,
              child: MenuDrawer(userData: userData,),
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
                body: ItemList(
                          allItems: thisFilter.filterByCategory(itemsRequested, categories), // TODO: Replace with filter/real categories here
                           uid: userData.uid,
                           name: 'tab1',
                           searchTerm: filter,),
                  // TabBarView(
                  //   children: <Widget>[
                  //      ItemList(
                  //         allItems: thisFilter.filterByCategory(itemsRequested, categories), // TODO: Replace with filter/real categories here
                  //          uid: userData.uid,
                  //          name: 'tab1',
                  //          searchTerm: filter,),
                  //   ],
                  //   controller: _tabController,
                  // ),
                ),

          );
          }

  Widget _createHeader(String userName, bool innerBoxIsScrolled) {
    return SliverAppBar(
     // backgroundColor: Colors.blueGrey,
//      snap: true,
//    leading: IconButton(icon: Icon(Icons.menu),onPressed:(){ _buildDrawer(context);},),
      floating: false,
      pinned: true,
      elevation: 8.0,
      forceElevated: innerBoxIsScrolled,
//      leading: Icon(Icons.menu),
      title: innerBoxIsScrolled || _showSearchBar || _searchNode.hasFocus  ? _searchBar() : SizedBox.shrink(), // Builds search bar in title when search clicked, or when innerBoxIsScrolled
      centerTitle: true,
      expandedHeight: 150,

      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: (){
            setState(() {
              _showSearchBar = true;
              _searchNode.requestFocus();
            });
          },
        )
      ],

      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: LinearGradient(

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          stops: [0.1, 0.8],
          colors: [customBlue2, customBlue5]
        )),
        child: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 20.0),
          centerTitle: true,
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //TODO //_titleBar(userName)
                      Visibility(
                        visible: !innerBoxIsScrolled && !_showSearchBar && !_searchNode.hasFocus,
                        child: Text(
                          userName != null ? 'Welcome $userName!' : 'Welcome !',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          background: Column(

            children: <Widget>[
              Spacer(),
              Image.asset(
                'logo_only.png',
                width: 150.0,
                height: 150.0,
                alignment: Alignment(0, 0.5),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
      // bottom: PreferredSize(
      //   preferredSize: Size.square(38.0),
      //   child: TabBar(
      //     indicatorColor: customYellow2,
      //     indicatorSize: TabBarIndicatorSize.tab,
      //     indicatorWeight: 4.0,
      //     labelColor: Colors.black87,
      //     unselectedLabelColor: Colors.black38,
      //     tabs: [
      //       new Tab(child: Text("Items", style: tabFont,), ),
      //       // new Tab(child: Text("In Need Of",style: tabFont,)),
      //     ],
      //     controller: _tabController,
      //   ),
      // ),
    );

    // );
  }

  Widget _titleBar(String userName){
    return Text(
      'Welcome $userName!',
      style: TextStyle(color: Colors.white, fontSize: 20.0),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
      child: TextField(decoration: InputDecoration(
        isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
          fillColor: Colors.white,
          enabledBorder:  OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(16.0)),
              borderSide: BorderSide(color: Colors.white,)),
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(16.0)),),
//            borderSide: BorderSide(color: Colors.white,)),
          filled: true,
          hintText: "Search",
          suffixIcon: IconButton(icon: Icon(Icons.clear), onPressed: (){

            if (filter == ""){
              FocusScope.of(context).unfocus();
              _searchController.clear();
              setState(() {
                _showSearchBar = false;
              });
            }else{
              _searchController.clear();
            }
            },),
      ),
//        autofocus: true, // Always has focus when _showSearchBar is true
        style: TextStyle(fontSize: 14.0, height: 1),
        focusNode: _searchNode,
        onEditingComplete: () {
          if (filter == "") {
            FocusScope.of(context).unfocus();
            _searchController.clear();
            setState(() {
              _showSearchBar = false;
            });

          } else {
//              showSearchBar.value = true;
          }
        },
        controller: _searchController,
      ),
    );
  }



  Widget _actionButtons(String uid){

//  print(tabPosition);
    return _tabController.animation!.value < 0.5 ?
    FloatingActionButton.extended(
      onPressed: () {
//        print(_currentIndex);
//        print(_scrollController.offset);
        Navigator.pushNamed(context, NewItemRoute,
            arguments: [uid, 0]);
      },
      label: Text('Add item'),
      icon:  Icon(Icons.add),
      backgroundColor: customYellow1,
    )
        : FloatingActionButton.extended(
      onPressed: () {
//        print(_scrollController.offset);

        Navigator.pushNamed(context, NewItemRoute,
            arguments: [uid,1]);
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
