import 'dart:core';

import 'package:twofortwo/services/item_service.dart';

class Filter {

  final List<Item> itemsRequested;
  final List<ItemAvailable> itemsAvailable;

  Filter({this.itemsAvailable, this.itemsRequested});


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




}

