import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
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
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro'),
        ),
        body: Form(
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
                ElevatedButton(
                    onPressed: () {
                      // The FormState class contains the validate() method. When the validate()
                      //  method is called, it runs the validator() function for each text field
                      //  in the form. If everything looks good, the validate() method returns true.
                      //  If any text field contains errors, the validate() method rebuilds the
                      //  form to display any error messages and returns false.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: Text('Cadastrar')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
