// lib/services/image_upload_service.dart
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as path;

Future<String?> uploadImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile == null) return null;

  File imageFile = File(pickedFile.path);
  String fileName = path.basename(imageFile.path);

  try {
    final ref = FirebaseStorage.instance.ref().child('recipe_images/$fileName');
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  } catch (e) {
    print('Upload failed: $e');
    return null;
  }
}

Future<void> saveImageUrl(String url) async {
  await FirebaseFirestore.instance.collection('recipes').add({
    'image_url': url,
    'timestamp': Timestamp.now(),
  });
}
