import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ImageAssist {
  Future<File?> pickFile() => ImagePicker()
      .getImage(source: ImageSource.gallery)
      .then((pickedFile) => pickedFile != null ? File(pickedFile.path) : null);

  Future<String> saveImage(File fileImage) {
    return getDatabasesPath().then((dbPath) {
      var dir = Directory(join(dbPath, 'contacts', 'images'));
      if (!dir.existsSync()) dir.create();
      String newPath =
          join(dir.path, '${DateTime.now()}.${fileImage.path.split('.').last}');
      fileImage.copy(newPath);
      return newPath;
    });
  }
}
