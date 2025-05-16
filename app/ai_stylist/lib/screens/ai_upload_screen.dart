import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../repositories/image_repository.dart';
import '../data/dummy_data.dart';
import '../models/fashion_item.dart';
import 'product_detail_screen.dart';

final List<Map<String, dynamic>> predefinedSuggestions = [
  {
    "keywords": ["beach, please!", "beach", "swim", "cover-up"],
    "suggestion":
        "Make waves by the water in the season's best swimwear and cover-ups.",
    "productId": "9", // Leem Kaftan
  },
  {
    "keywords": ["away we go", "holiday", "pool float"],
    "suggestion":
        "Pool float, beach towel, flip-flops – luggage for all your holiday essentials.",
    "productId": null,
  },
  {
    "keywords": ["work meeting outfit", "work", "meeting"],
    "suggestion":
        "Opt for a tailored blazer and smart trousers for a professional look.",
    "productId": "5", // Tailored Blazer
  },
  {
    "keywords": ["date night", "date"],
    "suggestion":
        "Try a chic midi dress with statement accessories for your special evening.",
    "productId": "4", // Floral Maxi Dress
  },
  // Add more...
];

class AIUploadScreen extends StatefulWidget {
  const AIUploadScreen({Key? key}) : super(key: key);

  @override
  State<AIUploadScreen> createState() => _AIUploadScreenState();
}

class _AIUploadScreenState extends State<AIUploadScreen> {
  String? _selectedImagePath;
  String? _uploadedImageUrl;
  final TextEditingController _textController = TextEditingController();
  String? _suggestion;
  FashionItem? _suggestedItem;
  List<String> _imageTags = [];
  final ImageRepository _imageRepo = ImageRepository();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
        _uploadedImageUrl = null;
        _imageTags = [];
      });
      // 1. Upload to Firebase Storage
      final downloadUrl = await _imageRepo.uploadImageToFirebase(pickedFile);
      debugPrint('Firebase Storage Download URL: $downloadUrl');
      setState(() {
        _uploadedImageUrl = downloadUrl;
      });
      // 2. Analyze image using Vertex AI (mocked)
      final tags = await _imageRepo.analyzeImageWithVertexAI(downloadUrl);
      setState(() {
        _imageTags = tags;
      });
      // 3. Store tags and image URL in Firestore
      await _imageRepo.storeImageTags(downloadUrl, tags);
    }
  }

  void _getSuggestion() {
    final prompt = _textController.text.toLowerCase().trim();
    // Fuzzy/partial matching for predefined suggestions
    for (final entry in predefinedSuggestions) {
      for (final keyword in (entry["keywords"] as List<String>)) {
        if (prompt.contains(keyword.toLowerCase().trim())) {
          setState(() {
            _suggestion = entry["suggestion"] as String;
            final productId = entry["productId"] as String?;
            _suggestedItem = productId != null
                ? dummyFashionItems.firstWhere(
                    (item) => item.id == productId,
                    orElse: () => dummyFashionItems.first,
                  )
                : null;
          });
          return;
        }
      }
    }
    // Keywords for beach/holiday (legacy fallback)
    final beachKeywords = [
      'beach',
      'swim',
      'holiday',
      'away we go',
      'pool',
      'waves',
      'kaftan',
      'cover-up'
    ];
    final isBeachPrompt = beachKeywords.any((k) => prompt.contains(k));
    if (isBeachPrompt) {
      final leemKaftan = dummyFashionItems.firstWhere(
        (item) => item.name.toLowerCase().contains('kaftan'),
        orElse: () => dummyFashionItems.first,
      );
      setState(() {
        _suggestedItem = leemKaftan;
        _suggestion = null;
      });
      return;
    }
    // Default suggestion
    setState(() {
      _suggestion =
          'Try pairing your look with a light utility jacket for a modern, effortless vibe!';
      _suggestedItem = null;
    });
  }

  Widget _buildProductDetails(FashionItem item) {
    final related = dummyFashionItems.where((f) => f.id != item.id).toList();
    related.shuffle();
    final completeTheLook = related
        .where((f) =>
            f.tags.any((tag) => item.tags.contains(tag)) ||
            f.styleType == item.styleType ||
            f.mood == item.mood)
        .take(2)
        .toList();
    final youWillLove = related
        .where((f) =>
            f.category == item.category ||
            f.styleType == item.styleType ||
            f.tags.any((tag) => item.tags.contains(tag)))
        .skip(2)
        .take(6)
        .toList();
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              item: item,
              completeTheLook: completeTheLook,
              youWillLove: youWillLove,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(top: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(item.imageUrl,
                      height: 100, width: 80, fit: BoxFit.cover),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(item.brand,
                            style: const TextStyle(color: Colors.grey)),
                        Text('£${item.price.toStringAsFixed(2)}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text('Color: ${item.colors.join(", ")}'),
              Text('Available sizes: ${item.sizes.join(", ")}'),
              Text('Style: ${item.styleType}'),
              const SizedBox(height: 8),
              const Text('Details:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('100% polyester'),
              const Text(
                  'Loose fit, high neck, short sleeves, all-over plisse texture'),
              const Text('Hand wash'),
              const Text('True to size'),
              const Text('Size small: length 132cm'),
              const Text('Model is 5ft 11in/1.80m and wears a size small'),
              const Text('Lightweight, non-stretch'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Stylist Suggestions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text('Upload Image'),
            ),
            if (_uploadedImageUrl != null) ...[
              const SizedBox(height: 12),
              Text('Download URL: $_uploadedImageUrl',
                  style: TextStyle(fontSize: 10, color: Colors.grey)),
              Image.network(_uploadedImageUrl!, height: 120),
              if (_imageTags.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _imageTags
                        .map((tag) => Chip(
                              label: Text(tag,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                              backgroundColor: Colors.grey[100],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Colors.grey[300]!),
                              ),
                              deleteIcon: const Icon(Icons.close, size: 18),
                              onDeleted: () {
                                setState(() {
                                  _imageTags.remove(tag);
                                });
                              },
                            ))
                        .toList(),
                  ),
                ),
              ],
            ],
            const SizedBox(height: 24),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Describe your style or occasion',
                border: OutlineInputBorder(),
              ),
              minLines: 1,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getSuggestion,
              child: const Text('Get Suggestions'),
            ),
            if (_suggestion != null) ...[
              const SizedBox(height: 24),
              Text(
                'AI Suggestion:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(_suggestion!),
            ],
            if (_suggestedItem != null) _buildProductDetails(_suggestedItem!),
          ],
        ),
      ),
    );
  }
}
