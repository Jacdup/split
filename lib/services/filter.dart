import 'dart:core';

import 'package:twofortwo/services/item_service.dart';
import 'package:twofortwo/services/message_service.dart';

class Filter {

  final List<Item>? items;

  Filter({this.items});

List<Message> sortMessagesByDate(List<Message> messages){
  messages.sort((a,b) =>
  b.dateSent.compareTo(a.dateSent)
  );
  return messages;
}


  // Sort from newest -> oldest
  List<Item> sortByDate(List<Item> items){
    items.sort((a,b) =>
      b.createdAt.compareTo(a.createdAt)
    );
    return items;
  }

  List<Item?> filterByCategory(List<Item?> items, List<dynamic>? chosenCategories){
    return items.where((element) =>
       (chosenCategories!.any((item) => element!.categories.contains(item)))
    ).toList();
  }



}

