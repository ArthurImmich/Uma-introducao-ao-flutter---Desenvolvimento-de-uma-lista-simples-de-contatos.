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

  Future create(Contato contato) async => _getDatabase()
          .then((db) => db.insert('contacts', contato.toMap()))
          .catchError((e) {
        print(e);
      });

  Future delete(int id) async => _getDatabase()
          .then((db) => db.delete('contacts', where: "id = ?", whereArgs: [id]))
          .catchError((e) {
        print(e);
      });

  Future upate(Contato contato) async => _getDatabase()
          .then((db) => db.update('contacts', contato.toMap(),
              where: "id = ?", whereArgs: [contato.id]))
          .catchError((e) {
        print(e);
      });

  Future<List<Contato>> getContacts() async {
    return _getDatabase().then((db) {
      return db.query('contacts').then((List<Map<String, dynamic>> maps) {
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
          ),
        );
      });
    });
  }
}
