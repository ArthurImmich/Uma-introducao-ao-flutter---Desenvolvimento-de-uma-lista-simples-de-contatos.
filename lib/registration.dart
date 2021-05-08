import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/contatc.dart';

import 'database.dart';
import 'image_assist.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  bool _checked = false;
  File? _fileImage;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _instagramController = TextEditingController();
  final _facebookController = TextEditingController();
  final _linkedinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _fileImage != null
                          ? CircleAvatar(
                              radius: 30,
                              backgroundImage: FileImage(_fileImage!))
                          : CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.person, color: Colors.black),
                              backgroundColor: Colors.amber),
                      ElevatedButton(
                        onPressed: () => ImageAssist()
                            .pickFile()
                            .then((file) => setState(() => _fileImage = file)),
                        child: Text('Selecionar Imagem'),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  //the post fix exclamation mark is a 'casting away nullability'
                  //meaning that it will take the value of null and cast it to a string
                  //and then check if it is empty avoiding calling .isEmpty on null
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo Obrigatório'
                      : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Telefone'),
                ),
                TextFormField(
                  controller: _instagramController,
                  decoration: const InputDecoration(labelText: 'Instagram'),
                ),
                TextFormField(
                  controller: _facebookController,
                  decoration: const InputDecoration(labelText: 'Facebook'),
                ),
                TextFormField(
                  controller: _linkedinController,
                  decoration: const InputDecoration(labelText: 'LinkedIn'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 140, height: 35),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              DatabaseConnection().create(
                                Contact(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  instagram: _instagramController.text,
                                  facebook: _facebookController.text,
                                  linkedin: _linkedinController.text,
                                  image: _fileImage != null
                                      ? await ImageAssist()
                                          .saveImage(_fileImage!)
                                      : null,
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Cadastrado!')));
                              Navigator.of(context).pop();
                            } catch (e) {
                              print(e.toString());
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Erro ao cadastrar!')));
                            }
                          }
                        },
                        child: Text('Cadastrar'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
