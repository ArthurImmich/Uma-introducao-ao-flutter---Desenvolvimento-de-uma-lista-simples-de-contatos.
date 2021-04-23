import 'package:flutter/material.dart';

class CustomTheme with ChangeNotifier {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.amber,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Montserrat',
      textTheme: ThemeData.light().textTheme,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.amber),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: Colors.amber, onPrimary: Colors.black),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.amber;
            }
            return Colors.black38;
          },
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.amber,
      scaffoldBackgroundColor: Colors.black,
      fontFamily: 'Montserrat',
      textTheme: ThemeData.dark().textTheme,
      brightness: Brightness.dark,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.amber),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: Colors.amber, onPrimary: Colors.black),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.amber;
            }
            return Colors.white;
          },
        ),
      ),
    );
  }

  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
