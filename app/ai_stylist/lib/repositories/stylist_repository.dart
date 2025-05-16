import '../services/firebase_service.dart';
import '../models/user_prompt.dart';
import '../models/analysis_result.dart';
import 'dart:io';

class StylistRepository {
  final FirebaseService _firebaseService;

  StylistRepository(this._firebaseService);

  Future<String> uploadUserImage(String imagePath) async {
    // In real app, convert imagePath to File
    return await _firebaseService.uploadImage(File(imagePath));
  }

  Future<void> saveUserPrompt(UserPrompt prompt) async {
    await _firebaseService.savePrompt(prompt.imagePath, prompt.prompt);
  }

  Future<AnalysisResult> analyzePrompt(UserPrompt prompt) async {
    // Dummy analysis logic
    await Future.delayed(Duration(seconds: 1));
    return AnalysisResult(
      colorType: 'True Summer',
      styleType: 'Dramatic',
      bodyType: 'Triangle',
      outfitMatch: true,
    );
  }
}
