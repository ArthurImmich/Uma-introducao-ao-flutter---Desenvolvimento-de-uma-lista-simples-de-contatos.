import 'package:flutter/material.dart';
import 'package:flutter_app/themes.dart';

import 'contacts_list.dart';

void main() => runApp(ContactsListApp());
CustomTheme currentTheme = CustomTheme();

class ContactsListApp extends StatefulWidget {
  @override
  _ContactsListAppState createState() => _ContactsListAppState();
}

class _ContactsListAppState extends State<ContactsListApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contatos',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      home: ContactsList(title: 'Contatos'),
    );
  }
}
