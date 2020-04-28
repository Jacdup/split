import 'package:flutter/material.dart';
import 'package:twofortwo/services/auth.dart';
import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/shared/loading.dart';
import 'package:twofortwo/ui/screens/authenticate/login.dart';
import 'package:twofortwo/utils/colours.dart';
import 'package:twofortwo/utils/routing_constants.dart';
import 'package:twofortwo/services/localstorage_service.dart';
import 'package:twofortwo/utils/service_locator.dart';
import 'package:twofortwo/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/services/database.dart';

class BorrowListPortrait extends StatelessWidget {
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> chosenCategories;
  final Item borrowList;
  final User user;
  BorrowListPortrait(
      {Key key, this.chosenCategories, this.borrowList, this.user})
      : super(key: key);
//  const BorrowListPortrait({Key key, this.chosenCategories, this.borrowList}) : super(key: key);
  final _itemFont = const TextStyle(fontSize: 15.0);
  final AuthService _auth = AuthService();
  final localStorageService = locator<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context) ?? [];
//  final userAll = Provider.of<User>(context);
//  print(userAll);
//    print(items);
//  print(user.toString());

//  final userDetails = await DatabaseService(uid: user.uid).userCollection
//  print(items.documents);
//  items.forEach((item) {
//    print(item.category);
//    print(item.date);
//    print(item.description);
//    print(item.itemName);
//  });
    return StreamBuilder<User>(
        stream: DatabaseService(uid: user.uid).userData, // Access stream
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            User userData = snapshot.data;
            return DefaultTabController(
                length: 1,
                initialIndex: 0,
                child: Scaffold(
                  //key: _scaffoldKey,
                  appBar: _createHeader(userData.name), //TODO: make this sliverAppBar

                  drawer: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65, //20.0,
                    child: _buildDrawer(context),
                  ),

                  floatingActionButton: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushNamed(context, NewItemRoute); // TODO: Can send userData to route
                    },
                    label: Text('Add request'),
                    icon: Icon(Icons.add),
                    backgroundColor: Colors.red,
                  ),

                  body: _buildBorrowList(chosenCategories, items),
                ));
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
              color: colorCustom,
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
//                setState()
                localStorageService.clear(); //  Remove all saved values // TODO: call a setstate or something so the widget knows the stayloggedin is cleared

//                print(localStorageService.stayLoggedIn);
                await _auth.logOut();
//                Navigator.pushReplacementNamed(context, CategoryRoute);
              })
        ],
      ),
    );
  }
}
