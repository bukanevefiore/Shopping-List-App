import 'package:flutter/material.dart';
import 'package:shoppinglist/http/item_service.dart';
import 'package:shoppinglist/models/overview.dart';

class ShoppinListMainPage extends StatefulWidget {
  @override
  _ShoppinListMainPageState createState() => _ShoppinListMainPageState();
}

class _ShoppinListMainPageState extends State<ShoppinListMainPage> {
  ItemService itemService;

  @override
  void initState() {

    itemService=ItemService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text("OverView"),
        ),
        FutureBuilder(
          future: itemService.overview(),
          builder: (BuildContext context,AsyncSnapshot<OverView> snapshot) {
           // if(!snapshot.hasData){
             // return Center(child: CircularProgressIndicator());
           // }
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: Container(
                  child: RefreshIndicator(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: [ //  print(snapshot.data.current);
                        GridItem(icon: Icons.shopping_basket,title: 'Total Items',
                            total: 10),
                        GridItem(icon: Icons.add_shopping_cart,title: 'Current Items',
                            total: 8),
                        GridItem(icon: Icons.history,title: 'Comleted Items',
                            total: 7),
                        GridItem(icon: Icons.remove_shopping_cart,title: 'Deleted Items',
                            total: 5),
                      ],
                    ),
                    onRefresh: () async{
                      setState(() {});
                    },
                  ),
                ),
              ),
            );
          }
        ),
      ],
    );
  }
}

// main deki kartlar için stles widget ımız
class GridItem extends StatelessWidget {
  // karttaki değerlere ait paremetreler
  final IconData icon;
  final String title;
  final int total;

  //constructor
  const GridItem({
    @required this.icon,
    @required this.title,
    @required this.total,
    Key key,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: Icon(icon,size: 64,color: Colors.orange)),
              Padding(
                padding: const EdgeInsets.only(top:8,bottom:16),
                child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54,fontSize: 22),),
              ),
              Text(total.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54,fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}

