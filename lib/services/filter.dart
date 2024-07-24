import 'dart:core';

import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/services/message_service.dart';

class Filter {

  final List<Item>? itemsRequested;
  final List<ItemAvailable>? itemsAvailable;

  Filter({this.itemsAvailable, this.itemsRequested});

List<Message> sortMessagesByDate(List<Message> messages){
  messages.sort((a,b) =>
  b.dateSent!.compareTo(a.dateSent)
  );
  return messages;
}


  // Sort from newest -> oldest
  List<Item> sortRequestedByDate(List<Item> itemsRequested){
    itemsRequested.sort((a,b) =>
      b.createdAt.compareTo(a.createdAt)
    );
    return itemsRequested;
  }

  List<ItemAvailable> sortAvailableByDate(List<ItemAvailable> itemsAvailable){
    itemsAvailable.sort((a,b) =>
        b.createdAt.compareTo(a.createdAt)
    );
    return itemsAvailable;
  }

  List<Item?> filterRequestedByCategory(List<Item?> itemsRequested, List<dynamic>? chosenCategories){
    return itemsRequested.where((element) =>
       (chosenCategories!.any((item) => element!.categories.contains(item)))
    ).toList();
  }

  List<ItemAvailable> filterAvailableByCategory(List<ItemAvailable> itemsAvailable, List<dynamic> chosenCategories){
//    print(chosenCategories);
    // if (chosenCategories.length == 0) {
    //   return [];
    //  }
    return itemsAvailable.where((element) =>
    (chosenCategories.any((item) => element.categories.contains(item)))
    ).toList();
  }



}

