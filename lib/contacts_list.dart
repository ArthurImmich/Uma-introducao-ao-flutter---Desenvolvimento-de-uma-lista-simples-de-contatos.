import 'package:flutter/material.dart';
import 'package:flutter_app/database.dart';
import 'package:flutter_app/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'registration.dart';
import 'contatc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'edit.dart';

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
    super.initState();
    db.getContacts().then((contatos) => setState(() {
          lista = contatos;
        }));
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
                  //subtitle: Text(contatos[i].phone ?? ''),
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber,
                  ),
                ),
              ),
            ),
            secondaryActions: [
              if (lista[i].linkedin?.isNotEmpty ?? false)
                IconSlideAction(
                  caption: 'LinkedIn',
                  color: Colors.blue.shade800,
                  icon: FontAwesomeIcons.linkedin,
                  onTap: () async {
                    await canLaunch(lista[i].linkedin!)
                        ? launch(lista[i].linkedin!)
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('URL inválida')));
                  },
                ),
              if (lista[i].facebook?.isNotEmpty ?? false)
                IconSlideAction(
                  caption: 'Facebook',
                  color: Colors.blue.shade600,
                  icon: FontAwesomeIcons.facebook,
                  onTap: () async {
                    await canLaunch(lista[i].facebook!)
                        ? launch(lista[i].facebook!)
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('URL inválida')));
                  },
                ),
              if (lista[i].instagram?.isNotEmpty ?? false)
                IconSlideAction(
                  caption: 'Instagram',
                  color: Colors.purple.shade600,
                  icon: FontAwesomeIcons.instagram,
                  onTap: () async {
                    await canLaunch(lista[i].instagram!)
                        ? launch(lista[i].instagram!)
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('URL inválida')));
                  },
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
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
