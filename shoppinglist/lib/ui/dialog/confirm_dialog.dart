import 'package:flutter/material.dart';
import 'package:loading_elevated_button/loading_elevated_button.dart';
import 'package:shoppinglist/models/item.dart';

class ConfirmDialog extends StatelessWidget {

  final Item item;

  const ConfirmDialog({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(item.name,style: TextStyle(color: Colors.orange),),
      content: Text('Confirm to delete ${item.name}'),
      actions: <Widget>[
        LoadingElevatedButton(
          onPressed: (){
            Navigator.of(context).pop(false);
          },
          child: Text('Cansel', style: TextStyle(color: Colors.white),),
        ),
        LoadingElevatedButton(
          onPressed: (){
            Navigator.of(context).pop(true);
          },
          child: Text('Delete', style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}
