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
}