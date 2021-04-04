import 'package:flutter/material.dart';
import 'package:shoppinglist/http/item_service.dart';
import 'package:shoppinglist/models/item.dart';
import 'dart:convert';

import 'package:shoppinglist/ui/dialog/confirm_dialog.dart';
import 'package:shoppinglist/ui/dialog/item_dialog.dart';

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
    return Column(
      children: <Widget>[AppBar(
        title: Text('Shopping List',style: TextStyle(color: Colors.white),),
        actions: <Widget>[IconButton(
          color: Colors.white,
          icon: Icon(Icons.done_all),
          onPressed: () async {
            await itemService.addToArchive();
            setState(() {});
          },
        )],
      ),
        Expanded(
          child: Stack(children: <Widget>[
              FutureBuilder(
                future: itemService.fetchItems(),
                builder: (BuildContext context,AsyncSnapshot<List<Item>> snapshot) {
                  if(snapshot.hasData && snapshot.data.length == 0){
                    return Center(child: Text("Your shopping list is empty"));
                  }
                  if(snapshot.hasData) {
                    return ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: snapshot.data.length == null ? 0 : snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Item item = snapshot.data[index];

                        return GestureDetector(
                          onLongPress: () async {
                            bool result=await showDialog(
                                context: context,
                                builder: (BuildContext context)=>
                                    ConfirmDialog(item: item));

                            item.isArchived=result;
                            await itemService.editItem(item);
                            setState(() {

                            });
                          },

                          child: CheckboxListTile(
                            title: Text(item.name),
                            onChanged: (bool value) async {
                              item.isCompleted = !item.isCompleted;
                              await itemService.editItem(item);
                              setState(() {});
                            },
                            value: item.isCompleted,
                          ),
                        );
                      },);
                  }
                  if(snapshot.hasError){
                    return Text(snapshot.error.toString());
                  }
                  return CircularProgressIndicator();
                },),
            Positioned(
              right: 16,
              bottom: 16,
              child: FloatingActionButton(
                onPressed: () async {
                  String itemName=await showDialog(
                      context: context,
                      builder: (BuildContext context)=>ItemDialog());

                  if(itemName.isNotEmpty){
                    var item= Item(name:itemName,isCompleted:false,isArchived:false);

                    try {
                      await itemService.addItem(item);
                      print(item.name);
                      // sayfa güncellemerli için kullanıyoruz
                      setState(() {});
                    }catch(ex){

                      Scaffold.of(context).showSnackBar(SnackBar(content: Text(ex.toString())));
                    }
                  }
                },
                child: Icon(Icons.add),
              ),

            ),
          ],),
        )

      ],
    );
  }
}
