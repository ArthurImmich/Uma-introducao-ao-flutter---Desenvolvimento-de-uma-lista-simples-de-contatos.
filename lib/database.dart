import 'package:flutter_app/contato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'contacts.db'),
      onCreate: (db, version) => db.execute(
          '''CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, email TEXT, 
          telefone TEXT, instagram TEXT, facebook TEXT, linkedin TEXT)'''),
      version: 1,
    );
  }

  Future create(Contato contato) async {
    try {
      _getDatabase().then((db) => db.insert('contatos', contato.toMap()));
      // final Database db = await _getDatabase();
      // await db.insert('contatos', contato.toMap());
    } catch (e) {
      print(e);
      return;
    }
  }

  Future<List<Contato>> getContacts() async {
    try {
      List<Map<String, dynamic>> maps =
          await _getDatabase().then((db) => db.query('contatos'));
      return List.generate(
          maps.length,
          (i) => Contato(
                id: maps[i]['id'],
                name: maps[i]['name'],
                phone: maps[i]['phone'],
                email: maps[i]['email'],
                instagram: maps[i]['instagram'],
                facebook: maps[i]['facebook'],
                linkedin: maps[i]['linkedin'],
              ));
    } catch (e) {
      print(e);
      // return;
    }
  }
}
