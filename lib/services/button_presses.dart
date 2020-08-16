
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:twofortwo/main.dart';
import 'package:twofortwo/services/category_service.dart';
import 'package:twofortwo/services/database.dart';
import 'package:twofortwo/services/item_service.dart';

/*
This is to keep the 'business' logic separate from the widget construction.
* Here I do all the calls to the database service, and update ValueNotifier
* 'loading' to change the state
* TODO: Move all of this inside BLoC for each specific view/component
*/
class ButtonPresses{


  onSelectRequestedItemCategories(String uid, Item item,
      List<String> selectedCategories) async {
//      loading.value = true;
////      newItem = new Item(null, itemName, description, date, null, null); //TODO, send to category route
////      Navigator.pushReplacementNamed(context,CategoryRoute);
//
//    // TODO, this in category view
    dynamic result = await DatabaseService(uid: uid).addItemRequestedData(
        item.itemName, item.description, item.startDate,item.endDate, selectedCategories,
        item.createdAt);
//
    if (result == null) {
      Fluttertoast.showToast(msg: 'Success! Item added.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
//          error = 'Could not add item, please check details';
      loading.value = false;
    } else {
      Fluttertoast.showToast(msg: 'Hmm. Something went wrong.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
//        Navigator.pop(context);
    }
//    Navigator.pop(context);

  }


  onSelectAvailableItemCategories(String uid, ItemAvailable item,
      List<String> selectedCategories) async {
//      loading.value = true;
//
////      newItem = new Item(_selectedCategory, itemName, date, description);
    dynamic result = await DatabaseService(uid: uid).addItemAvailableData(
        item.itemName, item.description, item.startDate,item.endDate, selectedCategories,
        item.createdAt);

    if (result == null) {
      Fluttertoast.showToast(msg: 'Success! Item added.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
      loading.value = false;
    } else {
      Fluttertoast.showToast(msg: 'Hmm. Something went wrong.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
    }
  }


  onUpdateItemCategories(String uid, dynamic item, bool itemType,
      List<String> selectedCategories) async {

    dynamic result;
//      loading.value = true;
//
////      newItem = new Item(_selectedCategory, itemName, date, description);
  if (itemType == true) { // Available item

    result = await DatabaseService(uid: uid).updateItem(
        item,null, itemType, selectedCategories);
  }else{
    result = await DatabaseService(uid: uid).updateItem(
        null,item, itemType, selectedCategories);
  }
//    dynamic result = await DatabaseService(uid: uid).addItemAvailableData(
//        item.itemName, item.description, item.startDate,item.endDate, selectedCategories,
//        item.createdAt);
//  }


    if (result == null) {
      Fluttertoast.showToast(msg: 'Success! Item updated.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
      loading.value = false;
    } else {
      Fluttertoast.showToast(msg: 'Hmm. Something went wrong.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
    }
  }


  onUpdateUserCategories(BuildContext context, String uid, List<String> selectedCategories) async {
    loading.value = true; // Should do the job of setState
    var categories = Provider.of<CategoryService>(context, listen: false);
    categories.updateWith(selectedCategories);
//    CategoryService thisCat = CategoryService();
//   CategoryService().updateWith(selectedCategories); // Notifies listeners
//    thisCat.updateWith(selectedCategories);
//    print(thisCat.userCategories);

    dynamic result = await DatabaseService(uid: uid).updateCategory(
        selectedCategories);

//                      storageService.hasSignedUp = true;
//                      storageService.category = _selectedCategories;
//                      print(_selectedCategories);
//                      print(storageService.category);

    if (result == null) {
      loading.value = false;
//    setState(() {
      Fluttertoast.showToast(
          msg: 'Successfully updated categories.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
//                  error = 'Could not sign in, please check details';
//      loading.value = false;
//    });
    } else {
      Fluttertoast.showToast(
          msg: 'Hmm. Something went wrong.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
    }
//  Navigator.pop(context);
  }

  onSendMessage(String messageUid, String documentRef, String messagePayload,
      String datePayload, bool type) async {
    dynamic result = await DatabaseService(uid: messageUid).contactItemOwner( //messageUid is 'fromUid' (person who sent the message)
        documentRef, messagePayload, datePayload, type);
    if (result == null) {
      loading.value = false;
//    setState(() {
      Fluttertoast.showToast(
          msg: 'Successfully sent message.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
//                  error = 'Could not sign in, please check details';
//      loading.value = false;
//    });
    } else {
      Fluttertoast.showToast(
          msg: 'Hmm. Something went wrong.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
    }
  }


  Future onMarkAsUnavailable(String itemID, bool type, bool availability) async {
    dynamic result = await DatabaseService().updateItemAvailability(itemID, type, availability);
    if (result == null) {
      loading.value = false;
//    setState(() {
      Fluttertoast.showToast(
          msg: 'Success',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
//                  error = 'Could not sign in, please check details';
//      loading.value = false;
//    });
    } else {
      Fluttertoast.showToast(
          msg: 'Hmm. Something went wrong.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 20.0);
    }
    return result;

  }

}