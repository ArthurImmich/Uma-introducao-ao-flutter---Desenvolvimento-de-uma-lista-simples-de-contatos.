import 'dart:io';

import 'package:flutter_app/contatc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  Future<Database> _getDatabase() async {
    var dir = Directory(join(await getDatabasesPath(), 'contacts'));
    if (!await dir.exists()) dir.create();
    return openDatabase(
      join(dir.path, 'contacts.db'),
      onCreate: (db, version) => db.execute(
          '''CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, email TEXT, 
          phone TEXT, instagram TEXT, facebook TEXT, linkedin TEXT, whatsapp INTEGER)'''),
      version: 1,
    );
  }

  Future create(Contact contato) async =>
      _getDatabase().then((db) => db.insert('contacts', contato.toMap()));

  Future delete(int id) async => _getDatabase()
      .then((db) => db.delete('contacts', where: "id = ?", whereArgs: [id]));

  Future update(Contact contato) async =>
      _getDatabase().then((db) => db.update('contacts', contato.toMap(),
          where: "id = ?", whereArgs: [contato.id]));

  Future<List<Contact>> getContacts() async {
    return _getDatabase().then((db) {
      return db.query('contacts').then((List<Map<String, dynamic>> maps) {
        return List.generate(
          maps.length,
          (i) => Contact(
            id: maps[i]['id'],
            name: maps[i]['name'],
            phone: maps[i]['phone'],
            email: maps[i]['email'],
            instagram: maps[i]['instagram'],
            facebook: maps[i]['facebook'],
            linkedin: maps[i]['linkedin'],
            whatsapp: maps[i]['whatsapp'] != 0 ? true : false,
          ),
        );
      });
    });
  }
}
