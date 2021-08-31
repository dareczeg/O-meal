class Product {
  final int? id;
  final int? listId;
  final String? title;
  final int? isDone;
  Product({this.id, this.listId, this.title, this.isDone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'listId': listId,
      'title': title,
      'isDone': isDone,
    };
  }
}
