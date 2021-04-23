import 'package:flutter/material.dart';
import 'package:flutter_app/themes.dart';
import 'contacts_list.dart';

void main() => runApp(MyApp());
CustomTheme currentTheme = CustomTheme();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
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
