import 'package:flutter/material.dart';
import 'package:shoppinglist/http/item_service.dart';
import 'package:shoppinglist/models/item.dart';
import 'dart:convert';

class ShoppingListItemPage extends StatefulWidget {
  @override
  _ShoppingListItemPageState createState() => _ShoppingListItemPageState();
}

class _ShoppingListItemPageState extends State<ShoppingListItemPage> {

  ItemService itemService;

  @override
  void initState() {
    itemService=ItemService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemService.fetchItems(),
      builder: (BuildContext context,AsyncSnapshot<List<Item>> snapshot) {
        if(snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Item item = snapshot.data[index];

              return ListTile(title: Text(item.name),);
            },);
        }
        if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        return CircularProgressIndicator();
      },);
  }
}
