import 'package:flutter/material.dart';
import 'package:twofortwo/services/auth.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/shared/loading.dart';
import 'package:twofortwo/ui/screens/authenticate/login.dart';
import 'package:twofortwo/ui/screens/home/item_info_view.dart';
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
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> chosenCategories;
  final User user;
  BorrowListPortrait(
      {Key key, this.chosenCategories, this.user})
      : super(key: key);

  @override
  _BorrowListPortraitState createState() => _BorrowListPortraitState();
}

class _BorrowListPortraitState extends State<BorrowListPortrait> {
  final _itemFont = const TextStyle(fontSize: 15.0);

  final AuthService _auth = AuthService();
  final localStorageService = locator<LocalStorageService>();
  List<bool> _infoShow = [];
  void _toggleDropdown(int num) {
    setState(() {
      _infoShow[num] = !_infoShow[num];
    });
  }
//  void populateData() {
//    var list = [];
//    for (int i = 0; i < 10; i++)
//      list.add(ListItem<String>("item $i"));
//  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context) ?? [];

    var numItems = items.length;
    for (var i = 0; i <= numItems; i++){
      _infoShow.add(false) ;
    }

    return StreamBuilder<User>(
        stream: DatabaseService(uid: widget.user.uid).userData, // Access stream
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            User userData = snapshot.data;
            return DefaultTabController(
                length: 1,
                initialIndex: 0,
                child: Scaffold(
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

                  body: CustomScrollView(
                  slivers: <Widget>[
                  _createHeader(userData.name),
                    _buildBorrowList(widget.chosenCategories, items),
                    ],
                  ),
                ),

            );
          } else {
            print('in here');
//            _auth.logOut();//TODO
//            return Navigator.pushReplacementNamed(context, LoginRoute);
//            return Login();
            return Loading();
          }
        });
  }

  Widget _buildBorrowList(List<String> chosenCategories, List<Item> allItems) {
    //final chosenCategories = chosenCategories1.categories;
    //return ListView.builder(
    //return
    //  return CustomScrollView(
    //    slivers: <Widget>[
    //  SliverList(
    //delegate: new SliverChildListDelegate())
    //),
    double _buildBox = 0;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
//            if (index.isOdd) {
//              return Divider( color: Colors.grey,);
//             }
            if (index == (allItems.length)-1){
              _buildBox = 80;
            }
            return _buildRow(allItems[index], index, _buildBox);

          },
           childCount:(allItems.length),
//        padding: const EdgeInsets.all(10.0),
////        itemCount: allItems.length,
////        itemBuilder: (BuildContext context, int index) {
////          return _buildRow(allItems[index], index);
////        },
//        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
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
        margin: EdgeInsets.fromLTRB(0, 20, 0, buildBox),
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

  Widget _createHeader(String userName) {
    //return Scaffold(

    return  SliverAppBar(
        floating: true,
        title: Text(''),
        expandedHeight: 200,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'split.png',
                  alignment: Alignment.bottomCenter,
                  width: 120.0,
                  height: 120.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
//                  Text(
//                    'Welcome [Account Name]!',
//                    style: TextStyle(color: Colors.white),
//                  ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.square(105.0),
          child: TabBar(
            tabs: [
              Text(
                'Welcome $userName!',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              )
              // Icon(Icons.train),
              // Icon(Icons.directions_bus),
              //Icon(Icons.motorcycle)
            ],
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
