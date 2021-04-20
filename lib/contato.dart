import 'package:flutter/widgets.dart';

class Contato {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? instagram;
  String? facebook;
  String? linkedin;
  bool? whatsapp;

  Contato(
      {this.id,
      @required this.name,
      this.email,
      this.phone,
      this.instagram,
      this.facebook,
      this.linkedin,
      this.whatsapp});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'instagram': instagram,
      'facebook': facebook,
      'linkedin': linkedin,
      'whatsapp': whatsapp,
    };
  }
}
