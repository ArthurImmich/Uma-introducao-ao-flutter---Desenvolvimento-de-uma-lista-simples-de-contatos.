import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/database.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact.dart';
import 'edit.dart';
import 'registration.dart';

class ContactsList extends StatefulWidget {
  ContactsList({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ContactsListState createState() => _ContactsListState();
}

DatabaseConnection db = DatabaseConnection();

class _ContactsListState extends State<ContactsList> {
  var lista = <Contact>[];
  @override
  void initState() {
    db.getContacts().then((contatos) {
      if (this.mounted) setState(() => lista = contatos);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_4),
            onPressed: () => currentTheme.toggleTheme(),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => db
            .getContacts()
            .then((contatos) => setState(() => lista = contatos)),
        child: ListView.separated(
          separatorBuilder: (context, i) => Divider(
            indent: 30,
            endIndent: 30,
            thickness: 1,
            height: 0,
          ),
          itemCount: lista.length,
          itemBuilder: (context, i) => Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.15,
            child: SizedBox(
              height: 70,
              child: Center(
                child: ListTile(
                  title: Text(lista[i].name!),
                  leading: lista[i].image != null
                      ? CircleAvatar(
                          radius: 30,
                          backgroundImage: FileImage(File(lista[i].image!)),
                        )
                      : CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.person, color: Colors.black),
                          backgroundColor: Colors.amber),
                ),
              ),
            ),
            secondaryActions: [
              if (lista[i].linkedin?.isNotEmpty ?? false)
                IconSlideAction(
                  caption: 'LinkedIn',
                  color: Colors.blue.shade800,
                  icon: FontAwesomeIcons.linkedin,
                  onTap: () => launch(lista[i].linkedin!),
                ),
              if (lista[i].facebook?.isNotEmpty ?? false)
                IconSlideAction(
                  caption: 'Facebook',
                  color: Colors.blue.shade600,
                  icon: FontAwesomeIcons.facebook,
                  onTap: () => launch(lista[i].facebook!),
                ),
              if (lista[i].instagram?.isNotEmpty ?? false)
                IconSlideAction(
                  caption: 'Instagram',
                  color: Colors.purple.shade600,
                  icon: FontAwesomeIcons.instagram,
                  onTap: () => launch(lista[i].instagram!),
                ),
              if (lista[i].phone?.isNotEmpty ?? false)
                IconSlideAction(
                  caption: 'Telefone',
                  color: Colors.black,
                  icon: FontAwesomeIcons.phone,
                  onTap: () => launch('tel:${lista[i].phone}'),
                ),
              if (lista[i].email?.isNotEmpty ?? false)
                IconSlideAction(
                  caption: 'Email',
                  color: Colors.deepPurple,
                  icon: FontAwesomeIcons.envelope,
                  onTap: () => launch('mailto:${lista[i].email}'),
                ),
              IconSlideAction(
                caption: 'Editar',
                color: Colors.amber,
                icon: Icons.edit,
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Edit(lista[i]))),
              ),
              IconSlideAction(
                caption: 'Excluir',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  db
                    ..delete(lista[i].id!)
                    ..getContacts()
                        .then((contatos) => setState(() => lista = contatos));
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Registration())),
        tooltip: 'Registrar',
        child: Icon(Icons.add),
      ),
    );
  }
}
