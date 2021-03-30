import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'models/grocery.dart';
import 'models/item.dart';
import 'models/user.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'grocery2.db'),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute(
          "CREATE TABLE grocerys(id INTEGER PRIMARY KEY, title TEXT, description TEXT)",
        );
         await db.execute(
          "CREATE TABLE item(id INTEGER PRIMARY KEY, groceryId INTEGER, title TEXT, isDone INTEGER)",
        );
         await db.execute(
          "CREATE TABLE user(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT)",
        );

        return db;
      },
      version: 4,
    );
  }

// save data to grocery table
  Future<void> insertgrocery(Grocery grocery) async {
    Database _db = await database(); // open db
    await _db.insert('grocerys', grocery.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

// save user 
  Future<void> insertuser(User user) async {
    Database _db = await database(); // open db
    await _db.insert('user', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

// save data to item table
  Future<void> insertitem(Item item) async {
    Database _db = await database(); // open db
    await _db.insert('item', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

// fetch data from grocery table
  Future<List<Grocery>> getGrocery() async {
    Database _db = await database();
    List<Map<String, dynamic>> groceryMap = await _db.query('grocerys');
    return List.generate(groceryMap.length, (index) {
      return Grocery(
          id: groceryMap[index]['id'],
          title: groceryMap[index]['title'],
          description: groceryMap[index]['description']);
    });
  }

// fetch data from item table
  Future<List<Item>> getItems(int groceryId) async {
    Database _db = await database();
    List<Map<String, dynamic>> itemMap = await _db.rawQuery("SELECT * FROM item WHERE groceryId = $groceryId ");
    return List.generate(itemMap.length, (index) {
      return Item(
          id: itemMap[index]['id'],
          title: itemMap[index]['title'],
          groceryId: itemMap[index]['groceryId'],
          isDone: itemMap[index]['isDone']);
    });
  }

// fetch user
  Future<List<User>> getUser() async {
    Database _db = await database();
    List<Map<String, dynamic>> userMap = await _db.query('user');
    return List.generate(userMap.length, (index) {
      return User(
          id: userMap[index]['id'],
          firstName: userMap[index]['firstName'],
          lastName: userMap[index]['lastName'],
          );
    });
  }

  // update if an item has been baought
    Future<void> updatePurchase(int id, int isDone) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE item SET isDone = '$isDone' WHERE id = '$id'");
  }
}
