import 'package:flutter/material.dart';
import 'package:shoppinglist/ui/shopping_list_page.dart';

void main() {
  runApp(ShoppingListApp());
}

class ShoppingListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.orange,backgroundColor: Colors.white),
      home: ShoppingListPage(),
    );
  }
}




