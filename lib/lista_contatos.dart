import 'package:flutter/material.dart';
import 'cadastro.dart';
import 'contato.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<Contato> contatos = [
  Contato(
      name: 'João Carlos',
      email: 'asd@asd.com',
      phone: '(55) 55555-5555',
      facebook: 'teste',
      instagram: 'teste'),
  Contato(name: 'Carla', email: 'asds@asds.com'),
  Contato(name: 'João Carlos', email: 'asd@asd.com', phone: '(55) 55555-5555'),
  Contato(name: 'Carla', email: 'asds@asds.com'),
  Contato(name: 'João Carlos', email: 'asd@asd.com', phone: '(55) 55555-5555'),
  Contato(name: 'Carla', email: 'asds@asds.com'),
  Contato(name: 'João Carlos', email: 'asd@asd.com', phone: '(55) 55555-5555'),
  Contato(name: 'Carla', email: 'asds@asds.com'),
  Contato(name: 'João Carlos', email: 'asd@asd.com', phone: '(55) 55555-5555'),
  Contato(name: 'Carla', email: 'asds@asds.com'),
  Contato(name: 'João Carlos', email: 'asd@asd.com', phone: '(55) 55555-5555'),
  Contato(name: 'Carla', email: 'asds@asds.com'),
  Contato(name: 'João Carlos', email: 'asd@asd.com', phone: '(55) 55555-5555'),
  Contato(name: 'Carla', email: 'asds@asds.com'),
  Contato(name: 'João Carlos', email: 'asd@asd.com', phone: '(55) 55555-5555'),
  Contato(name: 'Carla', email: 'asds@asds.com'),
  Contato(name: 'João Carlos', email: 'asd@asd.com', phone: '(55) 55555-5555'),
  Contato(name: 'Carla', email: 'asds@asds.com'),
  Contato(name: 'João Carlos', email: 'asd@asd.com', phone: '(55) 55555-5555'),
  Contato(name: 'Carla', email: 'asds@asds.com'),
  Contato(name: 'João Carlos', email: 'asd@asd.com', phone: '(55) 55555-5555'),
  Contato(name: 'Carla', email: 'asds@asds.com'),
  Contato(name: 'João Carlos', email: 'asd@asd.com', phone: '(55) 55555-5555'),
  Contato(name: 'Carla', email: 'asds@asds.com'),
];

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        separatorBuilder: (_, i) => Divider(
          indent: 30,
          endIndent: 30,
          thickness: 1,
          height: 0,
        ),
        itemCount: contatos.length,
        itemBuilder: (_, i) => Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.15,
          child: SizedBox(
            height: 70,
            child: Center(
              child: ListTile(
                title: Text(contatos[i].name!),
                //subtitle: Text(contatos[i].phone ?? ''),
                leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                ),
              ),
            ),
          ),
          secondaryActions: _secondaryActions(contatos[i]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Cadastro())),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

List<Widget> _secondaryActions(Contato contato) {
  List<Widget> secondaryActions = [
    IconSlideAction(
      caption: 'Editar',
      color: Colors.amber,
      icon: Icons.edit,
      onTap: () {},
    ),
    IconSlideAction(
      caption: 'Excluir',
      color: Colors.red,
      icon: Icons.delete,
      onTap: () {},
    ),
  ];
  if (contato.facebook?.isNotEmpty ?? false) {
    secondaryActions.insert(
        0,
        IconSlideAction(
          caption: 'Facebook',
          color: Colors.blue.shade600,
          icon: Icons.facebook,
          onTap: () {},
        ));
  }
  if (contato.facebook?.isNotEmpty ?? false) {
    secondaryActions.insert(
        0,
        IconSlideAction(
          caption: 'Instagram',
          color: Colors.purple.shade600,
          icon: Icons.camera_alt_outlined,
          onTap: () {},
        ));
  }

  return secondaryActions;
}
