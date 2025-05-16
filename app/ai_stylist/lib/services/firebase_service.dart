import 'dart:io';

class FirebaseService {
  Future<String> uploadImage(File image) async {
    // TODO: Implement Firebase Storage upload
    await Future.delayed(Duration(seconds: 1));
    return 'https://dummyimage.com/200x200';
  }

  Future<void> savePrompt(String imageUrl, String prompt) async {
    // TODO: Implement Firestore save
    await Future.delayed(Duration(milliseconds: 500));
  }
}
