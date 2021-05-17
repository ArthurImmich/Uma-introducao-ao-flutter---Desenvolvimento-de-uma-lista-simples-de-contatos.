import 'package:flutter/widgets.dart';

class Contact {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? instagram;
  String? facebook;
  String? linkedin;
  String? image;

  Contact(
      {this.id,
      @required this.name,
      this.email,
      this.phone,
      this.instagram,
      this.facebook,
      this.linkedin,
      this.image});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'instagram': instagram,
      'facebook': facebook,
      'linkedin': linkedin,
      'image': image,
    };
  }
}
