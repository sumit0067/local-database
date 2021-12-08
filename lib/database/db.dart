import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBSearchProvider {

  static Database _database;
  static final DBSearchProvider dbSearchProvider = DBSearchProvider._();

  DBSearchProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'search.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          db.execute(
            'CREATE TABLE Notes ('
                'id INTEGER PRIMARY KEY AUTOINCREMENT,'
                'number TEXT,'
                'description TEXT,'
                'title TEXT,'
                'createdTime TEXT'
                ')',
          );
        });

  }

  List noteList = [];

  getAllNote() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Notes");
    noteList = res;
  }

  createNote(String number,String description,String title,String createdTime) async{
    final db= await database;
    final res = await db.rawInsert('INSERT INTO Notes(number,description,title,createdTime) VALUES("$number","$description","$title","$createdTime")');
    return res;
  }

  Future<int> deleteAllNote() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Notes');
    return res;
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    final res = await db.rawDelete("DELETE FROM Notes Where id = '$id'");
    return res;
  }

  updateNote(String title,int id) async {

    // print("$live_price,$gain_loss,$symbol");

    final db = await database;
    final res = await db.rawQuery("UPDATE Notes SET title = '$title' WHERE id = '$id'");

    return res;
  }

/*  List<AccountList> accountList = [];
  getAllAccount() async {

    accountList.clear();

    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Account");

    List<AccountList> list = res.map((c) => AccountList.fromJson(c)).toList();
    accountList = list;
  }

  createAccount(AccountList newAccount) async{
    final db= await database;
    final res = await db.insert('Account', newAccount.toJson());
    return res;
  }*/


}
