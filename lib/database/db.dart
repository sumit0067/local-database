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
            'CREATE TABLE User ('
                'id INTEGER PRIMARY KEY AUTOINCREMENT,'
                'name TEXT,'
                'email TEXT,'
                'password TEXT,'
                'image TEXT'
                ')',
          );
        });

  }

  List userList = [];

  getAllUser() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM User");
    userList = res;
  }

  createUser(String name,String email,String password,String image) async{
    final db= await database;

    final res = await db.rawQuery("SELECT * FROM User WHERE email = '$email' and password = '$password'");
    if(res.isEmpty){
      final res = await db.rawInsert('INSERT INTO User(name,email,password,image) VALUES("$name","$email","$password","$image")');
      return res;
    }else{
      return "user exist";
    }
  }

  Future<int> deleteAllUser() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM User');
    return res;
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    final res = await db.rawDelete("DELETE FROM User Where id = '$id'");
    return res;
  }

  updateUser(String name,String email,String image,int id) async {

    // print("$live_price,$gain_loss,$symbol");

    final db = await database;
    final res = await db.rawQuery("UPDATE User SET name='$name',email='$email',image='$image' WHERE id = '$id'");

    return res;
  }

  selectUser(int id)async{
    final db = await database;
    final res = await db.rawQuery("SELECT name,email,password,image FROM User WHERE id ='$id'");
    return res;
  }

  loginUser(String email,String password)async{
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM User WHERE email = '$email' and password = '$password'");

    if(res.isNotEmpty){
      return res;
    }else{
      return "loginFail";
    }
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
