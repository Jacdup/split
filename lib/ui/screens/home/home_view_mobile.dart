import 'package:flutter/material.dart';
import 'package:twofortwo/services/auth.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import 'package:twofortwo/utils/service_locator.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:provider/provider.dart';

class BorrowListPortrait extends StatelessWidget {
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> chosenCategories;
  final Item borrowList;
  final User user;
  BorrowListPortrait({Key key, this.chosenCategories, this.borrowList, this.user}) : super(key: key);
//  const BorrowListPortrait({Key key, this.chosenCategories, this.borrowList}) : super(key: key);
  final _itemFont = const TextStyle(fontSize: 15.0);
  final AuthService _auth = AuthService();
  final localStorageService = locator<LocalStorageService>();

  @override
  Widget build(BuildContext context) {

  final items = Provider.of<List<Item>>(context);
//  print(items.documents);
//  items.forEach((item) {
//    print(item.category);
//    print(item.date);
//    print(item.description);
//    print(item.itemName);
//  });
    return DefaultTabController(
        length: 1,
        initialIndex: 0,
        child: Scaffold(
          //key: _scaffoldKey,
          appBar: _createHeader(user.uid), //TODO: make this sliverAppBar
          drawer: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.65, //20.0,
            child: _buildDrawer(context),
          ),

          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, NewItemRoute);
            },
            label: Text('Add request'),
            icon: Icon(Icons.add),
            backgroundColor: Colors.red,
          ),

//appBar: AppBar(
// title: Text('List of items'),
//),
          body: _buildBorrowList(chosenCategories, items),//TODO: borrowlist should contain multiple items
        ));

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
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: allItems.length,
      itemBuilder: (BuildContext context, int index) {

//        allItems.forEach((item) {
          return _buildRow(allItems[index]);
//        });
//        if (item1 == null) {
//            return Text("No items in chosen category");}
////        else if (chosenCategories.contains(item1.category)){
//        else if (chosenCategories.contains(item1.category)){
//
//        //TODO: iterate over items in borrowList here
//             return _buildRow(chosenCategories.first, item1.itemName, item1.date,item1.description);
//        }else{
////          print(item1.category);
//          return Text("No items in chosen category");
//        }

      },

      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );

  }

  Widget _buildRow(Item item) {
    String category = item.category;
    String itemName = item.itemName;
    String description = item.description;
    String date = item.date;
    // final bool alreadySaved = _saved.contains(pair);
    return Card(
      child: ListTile(
        title: Text(
          itemName,
          //pair.asPascalCase,
          style: _itemFont,
        ),
        subtitle: Text(
          description,
        ),
        trailing: Text(
          date,
        ),
        onTap: () {}, //TODO: create expandable thing here
      ),
    );
  }

  Widget _createHeader(String userName) {
    //return Scaffold(

    return AppBar(
      title: Text(''),
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
                height: 120.0,),
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
              color: colorCustom,
            ),
          ),
          ListTile(
              title: Text('Edit Categories'),
              onTap: () {
                Navigator.pop(context); // This one for the drawer
                Navigator.pushNamed(context, CategoryRoute);
              }),
          ListTile(
              title: Text('Logout'),
              onTap: () async {
                Navigator.pop(context); // This one for the drawer
//                Navigator.pushReplacementNamed(context, LoginRoute); // Shouldn't have to call this, the wrapper listens for changes
                localStorageService.clear(); //  Remove all saved values
//                print(localStorageService.stayLoggedIn);
                await _auth.logOut();
//                Navigator.pushReplacementNamed(context, CategoryRoute);
              })
        ],
      ),
    );
  }

}