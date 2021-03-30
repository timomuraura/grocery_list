  
class Item {
  final int id;
  final int groceryId;
  final String title;
  final int isDone;
  Item({this.id, this.groceryId, this.title, this.isDone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groceryId': groceryId,
      'title': title,
      'isDone': isDone,
    };
  }
}