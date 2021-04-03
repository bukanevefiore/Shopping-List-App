class Item{
  int id;
  String name;
  bool isCompleted;
  bool isArchived;

  Item(this.id,this.name,this.isCompleted,this.isArchived);

  // class içeriğini kullnmak için classın kendisini döndürmeye yarayan
  // factory methodları kullaılır

  factory Item.fromjson(Map<String,dynamic> map){
    return Item(map['id'],map['name'],map['isCompleted'],map['isArchived']);
  }
}

