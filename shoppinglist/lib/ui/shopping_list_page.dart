import 'package:flutter/material.dart';
import 'package:shoppinglist/http/item_service.dart';
import 'package:shoppinglist/models/item.dart';
import 'package:shoppinglist/ui/dialog/item_dialog.dart';
import 'package:shoppinglist/ui/shopping_list_history_page.dart';
import 'package:shoppinglist/ui/shopping_list_item_page.dart';
import 'package:shoppinglist/ui/shopping_list_main_page.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {

  int selectedindex=0;  // sayfnın altındaki navigationbar sayfa geçişleri için
  final scaffoldKey=GlobalKey<ScaffoldState>();
  final PageController pageController=PageController();// sayfa geçiş kontrollr
  ItemService itemService;


  @override
  void initState() {
    itemService=ItemService();
    pageController.addListener(() {
      int currentIndex=pageController.page.round();
      if(currentIndex != selectedindex){
        selectedindex=currentIndex;

        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(icon: Icon(Icons.list), title: Text("Shopping List")),
        BottomNavigationBarItem(icon: Icon(Icons.history), title: Text("History")),
      ],
      currentIndex: selectedindex,
      onTap: onTap,),
      body: PageView(
        controller: pageController,
        children: <Widget>[
        ShoppinListMainPage(),
        ShoppingListItemPage(),
        ShoppingListHistoryPage(),
        ],),
    );
  }



  void onTap(int value) {
    setState(() {
      selectedindex=value;
    });
    pageController.jumpToPage(value);

  }

}
