import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shoppinglist/models/item.dart';

class ItemService{
  final String serviceUrl='kesali-shopping.herokuapp.com';

  Future<List<Item>> fetchItems() async {

    var uri=Uri.https(serviceUrl,"item");
    final response=await http.get(uri);

    if(response.statusCode==200){

      Iterable items=json.decode(response.body);
      return items.map((item) => Item.fromjson(item)).toList();

    }else{
      throw Exception("Something went wrong");
    }
  }

  Future<Item> addItem(Item item) async {
    var uri = Uri.https(serviceUrl, "item");

    final response = await http.post(uri,
        headers: {'content-type': 'application/json'}, body: item.toJson());

    if (response.statusCode == 201) {
      Map item = json.decode(response.body);

      return Item.fromjson(item);
    } else {
      throw Exception("Something went wrong");
    }
  }



  Future<Item> editItem(Item item) async {
    var uri = Uri.https(serviceUrl, "item/${item.id}");

    final response = await http.patch(uri,
        headers: {'content-type': 'application/json'}, body: item.toJson());

    if (response.statusCode == 200) {
      Map item = json.decode(response.body);

      return Item.fromjson(item);
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<void> addToArchive() async {

    var uri=Uri.https(serviceUrl,"history");
    final response=await http.post(uri);

    if(response.statusCode != 201){
      throw Exception("Something went wrong");
    }
  }

  Future<List<Item>> fetchArchive(int take, int skip) async {
    var parameters = {"take": take.toString(), "skip": skip.toString()};

    var uri = Uri.https(serviceUrl, "history", parameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Iterable items = json.decode(response.body);

      return items.map((item) => Item.fromjson(item)).toList();
    } else {
      throw Exception("Something went wrong");
    }
  }

}