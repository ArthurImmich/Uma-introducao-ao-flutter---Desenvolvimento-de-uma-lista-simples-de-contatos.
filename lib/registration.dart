import 'package:flutter/material.dart';
import 'package:flutter_app/contatc.dart';

import 'database.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  bool _checked = false;
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
            child: Column(
              children: [
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
                                await databaseConnection.create(Contact(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  instagram: _instagramController.text,
                                  facebook: _facebookController.text,
                                  linkedin: _linkedinController.text,
                                  whatsapp: _checked,
                                ));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Cadastrado!')));
                                Navigator.of(context).pop();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Erro ao cadastrar contato!')));
                              }
                            }
                          },
                          child: Text('Cadastrar')),
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
