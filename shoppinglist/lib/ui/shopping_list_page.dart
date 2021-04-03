import 'package:flutter/material.dart';
import 'package:shoppinglist/ui/dialog/item_dialog.dart';
import 'package:shoppinglist/ui/shopping_list_item_page.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {

  int selectedindex=0;  // sayfnın altındaki navigationbar sayfa geçişleri için
  final PageController pageController=PageController();// sayfa geçiş kontrollr


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shopping List"),),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String itemName=await showDialog(context: context, builder: (BuildContext context)=>ItemDialog());
        },
        child: Icon(Icons.add),
      ),
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
        Container(
          color: Colors.white,
        ),
        ShoppingListItemPage(),
        Container(
          color: Colors.white,
        ),
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
