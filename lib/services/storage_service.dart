import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadRecipeImage(File file) async {
    final fileName = const Uuid().v4();
    final ref = _storage.ref().child('recipe_images/$fileName.jpg');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
