import 'package:app/model/product.dart';
import 'package:app/model/recipe.dart';
import 'package:app/model/shoppinglist.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(join(await getDatabasesPath(), 'database.db'),
        onCreate: (Database db, int version) => _createDb(db), version: 1);
  }

  static void _createDb(Database db) {
    db.execute(
        "CREATE TABLE lists(id INTEGER PRIMARY KEY, title TEXT, description TEXT)");
    db.execute(
        "CREATE TABLE products(id INTEGER PRIMARY KEY, listId INTEGER, title TEXT, isDone INTEGER)");
    db.execute(
        "CREATE TABLE recipes(id INTEGER PRIMARY KEY, title TEXT, description TEXT)");
  }

  Future<int> insertList(ShoppingList list) async {
    int listId = 0;
    Database _db = await database();
    await _db
        .insert('lists', list.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      listId = value;
    });
    return listId;
  }

  Future<void> insertProduct(Product product) async {
    Database _db = await database();
    await _db.insert('products', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertRecipe(Recipe recipe) async {
    Database _db = await database();
    await _db.insert('recipes', recipe.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ShoppingList>> getLists() async {
    Database _db = await database();
    List<Map<String, dynamic>> listMap = await _db.query('lists');
    return List.generate(listMap.length, (index) {
      return ShoppingList(
          id: listMap[index]['id'],
          title: listMap[index]['title'],
          description: listMap[index]['description']);
    });
  }

  Future<List<Product>> getProducts(int listId) async {
    Database _db = await database();
    List<Map<String, dynamic>> productMap =
        await _db.rawQuery('SELECT * FROM products WHERE listId = $listId');
    return List.generate(productMap.length, (index) {
      return Product(
          id: productMap[index]['id'],
          title: productMap[index]['title'],
          listId: productMap[index]['listId'],
          isDone: productMap[index]['isDone']);
    });
  }

  Future<List<Recipe>> getRecipes() async {
    Database _db = await database();
    List<Map<String, dynamic>> recipeMap = await _db.query('recipes');
    return List.generate(recipeMap.length, (index) {
      return Recipe(
          id: recipeMap[index]['id'],
          title: recipeMap[index]['title'],
          description: recipeMap[index]['description']);
    });
  }

  Future<void> updateRecipeTitle(int id, String title) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE recipes SET title = '$title' WHERE id = '$id'");
  }

  Future<void> updateRecipeDescription(int id, String desc) async {
    Database _db = await database();
    await _db
        .rawUpdate("UPDATE recipes SET description = '$desc' WHERE id = '$id'");
  }

  Future<void> updateListTitle(int id, String title) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE lists SET title = '$title' WHERE id = '$id'");
  }

  Future<void> updateListDescription(int id, String desc) async {
    Database _db = await database();
    await _db
        .rawUpdate("UPDATE lists SET description = '$desc' WHERE id = '$id'");
  }

  Future<void> updateProductIsDone(int id, int isDone) async {
    Database _db = await database();
    await _db
        .rawUpdate("UPDATE products SET isDone = '$isDone' WHERE id = '$id'");
  }

  Future<void> deleteList(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM lists WHERE id = '$id'");
    await _db.rawDelete("DELETE FROM products WHERE listId= '$id'");
  }

  Future<void> deleteRecipe(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM recipes WHERE id = '$id'");
  }
}
