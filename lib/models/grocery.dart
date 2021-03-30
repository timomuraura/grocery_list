class Grocery {
  final int id;
  final String title;
  final String description;
  Grocery({this.id, this.title, this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}