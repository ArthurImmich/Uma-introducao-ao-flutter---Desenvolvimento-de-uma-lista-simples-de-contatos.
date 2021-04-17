import 'package:flutter/widgets.dart';

class Contato {
  String? name;
  String? email;
  String? phone;
  String? instagram;
  String? facebook;
  String? linkedin;
  bool? whatsapp;

  Contato(
      {@required this.name,
      this.email,
      this.phone,
      this.instagram,
      this.facebook,
      this.linkedin,
      this.whatsapp});
}
