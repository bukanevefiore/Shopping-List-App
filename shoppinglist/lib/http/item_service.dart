import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shoppinglist/models/item.dart';

class ItemService{
  final String serviceUrl='https://kesali-shopping.herokuapp.com/item/';

  Future<List<Item>> fetchItems() async {

    final response=await http.get(Uri.parse(serviceUrl));

    if(response.statusCode==200){

      Iterable items=json.decode(response.body);
      return items.map((item) => Item.fromjson(item)).toList();

    }else{
      throw Exception("Something went wrong");
    }
  }

  Future<Item> addItem(String itemJson) async{
    final response=await http.post(Uri.parse(serviceUrl),headers: {
      'content-type':'application/json'
    }, body: itemJson);
    
    if(response.statusCode == 201){
      Map item=json.decode(response.body);
      
      return Item.fromjson(item);
    }
    else{
      throw Exception("Something went wrong");
    }
  }
}