import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ImageRepository {
  Future<String> uploadImageToFirebase(XFile image) async {
    final storageRef = FirebaseStorage.instance.ref().child(
        'uploads/${DateTime.now().millisecondsSinceEpoch}_${image.name}');
    UploadTask uploadTask;
    if (kIsWeb) {
      uploadTask = storageRef.putData(await image.readAsBytes());
    } else {
      uploadTask = storageRef.putFile(File(image.path));
    }
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> storeImageTags(String imageUrl, List<String> tags) async {
    await FirebaseFirestore.instance.collection('analyzed_images').add({
      'imageUrl': imageUrl,
      'tags': tags,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Mock Vertex AI image analysis (replace with real API call)
  Future<List<String>> analyzeImageWithVertexAI(String imageUrl) async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      'outdoor',
      'person',
      'beach',
      'swimwear',
      'clothing',
      'rock',
      'girl',
      'woman',
      'water',
      'nature',
      'white',
      'red'
    ];
  }
}
