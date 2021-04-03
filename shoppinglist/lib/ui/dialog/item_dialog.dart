import 'package:flutter/material.dart';

class ItemDialog extends StatefulWidget {
  @override
  _ItemDialogState createState() => _ItemDialogState();
}

class _ItemDialogState extends State<ItemDialog> {

  final formKey=GlobalKey<FormState>(); // dialog içindeki form için key
  String itemName;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Add your shopping item"),
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              Form(
                key: formKey,
                child: TextFormField(
                  maxLength: 100,
                  onSaved: (value)=> itemName=value,
                  autofocus: true,
                  validator: (value){
                    if(value.isEmpty){
                      return "validation error";
                    }
                  },
                ),),
              SizedBox(height: 16,),
              FlatButton(child: Text("Add item to shopping list"),
                color: Theme.of(context).accentColor,
                onPressed: saveForm,)
            ],
          ),
        )
      ],
    );
  }



  void saveForm() {

    formKey.currentState.save();
    if(formKey.currentState.validate()){
      Navigator.pop(context,itemName); // itenNmae alışveriş maddesinin list sayfasına gönderiyoruz
    }
  }
}
