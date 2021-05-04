import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/contatc.dart';
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';

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
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _fileImage != null
                        ? CircleAvatar(
                            radius: 30, backgroundImage: FileImage(_fileImage!))
                        : CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.person, color: Colors.black),
                            backgroundColor: Colors.amber),
                    ElevatedButton(
                      onPressed: () => _pickFile()
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
                validator: (value) =>
                    value!.isEmpty ? 'Campo Obrigatório' : null,
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
              CheckboxListTile(
                  title: Text('Whatsapp?'),
                  value: _checked,
                  controlAffinity: ListTileControlAffinity.platform,
                  onChanged: (value) {
                    setState(() => _checked = value!);
                  }),
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
                        // The FormState class contains the validate() method. When the validate()
                        //  method is called, it runs the validator() function for each text field
                        //  in the form. If everything looks good, the validate() method returns true.
                        //  If any text field contains errors, the validate() method rebuilds the
                        //  form to display any error messages and returns false.
                        if (_formKey.currentState!.validate()) {
                          DatabaseConnection databaseConnection =
                              DatabaseConnection();
                          try {
                            await databaseConnection.create(
                              Contact(
                                name: _nameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                                instagram: _instagramController.text,
                                facebook: _facebookController.text,
                                linkedin: _linkedinController.text,
                                image: _fileImage != null
                                    ? await _saveImage(_fileImage!)
                                    : null,
                                whatsapp: _checked,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Cadastrado!')));
                            Navigator.of(context).pop();
                          } catch (e) {
                            print(e.toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Erro ao cadastrar contato!'),
                              ),
                            );
                          }
                        }
                      },
                      child: Text('Cadastrar'),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

Future<File?> _pickFile() => ImagePicker()
    .getImage(source: ImageSource.gallery)
    .then((pickedFile) => pickedFile != null ? File(pickedFile.path) : null);

Future<String> _saveImage(File fileImage) async {
  Img.Image img = Img.decodeImage(fileImage.readAsBytesSync())!;
  String type = fileImage.path.split('.').last;
  File newFile = await getDatabasesPath().then((dbPath) async {
    var dir = Directory(join(dbPath, 'contacts', 'images'));
    var fileDir = join(dir.path, '${DateTime.now()}.$type');
    if (await dir.exists())
      return File(fileDir);
    else {
      dir.create(recursive: true);
      return File(fileDir);
    }
  });
  if (type == 'jpg' || type == 'jpeg')
    newFile.writeAsBytesSync(Img.encodeJpg(img));
  else
    newFile.writeAsBytesSync(Img.encodePng(img));
  return newFile.path;
}
