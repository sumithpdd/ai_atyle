# AI Stylist Flutter App

A feature-rich Flutter app inspired by ASOS and Style DNA, designed to help users discover, shop, and get AI-powered fashion suggestions.

## Features

- **Home Screen**: Browse fashion items, filter by mood, and view a carousel of features.
- **Shop by Mood**: Filter and shop items based on your current mood.
- **Discover Your Style**: Get personalized style suggestions and discover new looks.
- **AI Analysis**: Upload an image or enter a text prompt to receive AI-powered fashion suggestions.
- **Style Type Explorer**: Explore different style types (e.g., Romantic, Classic) and their characteristics.
- **Fashion Grid**: Responsive grid of fashion items with images from local assets.
- **Custom Carousel**: Smooth, auto-playing carousel for feature highlights.
- **Modern UI**: Clean, modern design with custom fonts and icons.
- **Firebase Integration**: Upload images to Firebase Storage, analyze with Vertex AI, and store tags in Firestore.
- **Image Tagging**: After upload, images are analyzed and tags are displayed as beautiful, removable chips.

## App Flow

1. **User lands on the Home Screen** and can browse or filter fashion items.
2. **Tap the camera/AI button** to open the AI Stylist screen.
3. **Upload an image** (from gallery or camera):
    - The image is uploaded to Firebase Storage.
    - The download URL is used for display and analysis.
    - (Mocked) Vertex AI analyzes the image and returns tags.
    - Tags are displayed as stylish chips and stored in Firestore with the image URL.
4. **User can remove tags** by tapping the 'x' on each chip.
5. **All image/tag data is stored in Firestore** for future use or analytics.

## Developer Guide

### Prerequisites
- Flutter SDK
- Firebase project (with Storage and Firestore enabled)
- Firebase CLI and FlutterFire CLI

### Setup
1. **Clone the repository**
2. **Install dependencies**
   ```sh
   flutter pub get
   ```
3. **Configure Firebase**
   - Run:
     ```sh
     flutterfire configure
     ```
   - Select your Firebase project and platforms.
   - Ensure `firebase_options.dart` is generated and correct.
4. **Add required packages**
   - Already included: `firebase_core`, `firebase_storage`, `cloud_firestore`, `image_picker`, `flutter_riverpod`, etc.
5. **Android/iOS Permissions**
   - Android: Add permissions to `AndroidManifest.xml` for storage and camera.
   - iOS: Add usage descriptions to `Info.plist`.
6. **Run the app**
   ```sh
   flutter run
   ```

### Image Upload & Tagging Flow
- The app uses a repository (`lib/repositories/image_repository.dart`) to handle:
  - Uploading images to Firebase Storage
  - Getting the download URL
  - (Mock) analyzing the image for tags
  - Storing the image URL and tags in Firestore
- The UI displays the image using the download URL and shows tags as beautiful, removable chips.

### Customization
- Replace the mock `analyzeImageWithVertexAI` with your real Vertex AI/genkit-ai API call.
- Adjust tag UI in `AIUploadScreen` as needed.
- Secure your Firebase Storage and Firestore rules for production.

## Scripts
- `download_fashion_images.ps1`: Downloads sample fashion images.
- `download_style_icons.ps1`: Downloads style type icons.

## Main Functions
- `FashionGrid`: Displays a grid of fashion items.
- `CustomCarousel`: Shows a carousel of feature highlights.
- `MoodSelector`: Lets users filter items by mood.
- `AIUploadScreen`: Lets users upload an image, analyzes it, and displays tags.
- `ImageRepository`: Handles all Firebase Storage, Firestore, and image analysis logic.

---

**Inspired by leading fashion apps for a seamless, stylish experience!** 