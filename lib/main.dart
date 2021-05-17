import 'package:flutter/material.dart';
import 'package:flutter_app/themes.dart';

import 'contacts_list.dart';

void main() => runApp(ContactsListApp());
CustomTheme customTheme = CustomTheme();

class ContactsListApp extends StatefulWidget {
  @override
  _ContactsListAppState createState() => _ContactsListAppState();
}

class _ContactsListAppState extends State<ContactsListApp> {
  @override
  void initState() {
    customTheme.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contatos',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: customTheme.currentTheme,
      home: ContactsList(title: 'Contatos'),
    );
  }
}
