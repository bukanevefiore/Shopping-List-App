import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/http/item_service.dart';
import 'package:shoppinglist/models/item.dart';


class ShoppingListHistoryPage extends StatefulWidget {
  @override
  _ShoppingListHistoryPageState createState() => _ShoppingListHistoryPageState();
}

class _ShoppingListHistoryPageState extends State<ShoppingListHistoryPage> {

 StreamController<List<Item>> streamController=StreamController();
 ItemService itemService;
 final ScrollController controller=ScrollController();
 int currentPage=0;

 List<Item> item=List<Item>();

 @override
  void initState() {

    itemService=ItemService();
    fetchArchived(currentPage);
    controller.addListener(onScrolled);

    super.initState();

  }

 @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  // archive listeleme methodu istek atma
  Future<void> fetchArchived(int page) async {
   var take=20;

   var items=await itemService.fetchArchive(20,take*page);

   if(items.length==0) return;
   item.addAll(items);

   streamController.add(item);

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(title: Text("Shopping List History"),),
        Expanded(
          child: StreamBuilder<List<Item>>(
              stream: streamController.stream,
              builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Center(child: CircularProgressIndicator());
                    break;
                  case ConnectionState.active:
                  case ConnectionState.done:
                  if(snapshot.data.length == 0){
                    return Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(16),
                        child: Text("Archive is empty!")
                    );
                  }
                    return ListView.builder(
                      controller: controller,
                      padding: EdgeInsets.all(0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context,int index) {
                        var item=snapshot.data[index];

                        return ListTile(title: Text(item.name));
                      },
                    );
                    break;
                  default:
                    return Container();
                    break;
                }
              }),
        ),
      ],
    );
  }



  void onScrolled() {

   if(controller.position.maxScrollExtent == controller.position.pixels){
     currentPage += 1;
     fetchArchived(currentPage);
   }
  }
}
