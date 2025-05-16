import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/fashion_item.dart';
import 'product_detail_screen.dart';

final Map<String, String> predefinedSuggestions = {
  "beach, please!":
      "Make waves by the water in the season's best swimwear and cover-ups.",
  "away we go":
      "Pool float, beach towel, flip-flops – luggage for all your holiday essentials.",
  "work meeting outfit":
      "Opt for a tailored blazer and smart trousers for a professional look.",
  "date night":
      "Try a chic midi dress with statement accessories for your special evening.",
  // Add more prompts and suggestions here!
};

class AIUploadScreen extends StatefulWidget {
  const AIUploadScreen({Key? key}) : super(key: key);

  @override
  State<AIUploadScreen> createState() => _AIUploadScreenState();
}

class _AIUploadScreenState extends State<AIUploadScreen> {
  String? _selectedImagePath;
  final TextEditingController _textController = TextEditingController();
  String? _suggestion;
  FashionItem? _suggestedItem;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    // TODO: Integrate image picker
    setState(() {
      _selectedImagePath =
          'assets/images/Oversized Denim Jacket.jpg'; // Placeholder
    });
  }

  void _getSuggestion() {
    final prompt = _textController.text.toLowerCase().trim();

    // Flexible matching: check if prompt contains any key (case-insensitive)
    final match = predefinedSuggestions.keys.firstWhere(
      (k) => prompt.contains(k.toLowerCase().trim()),
      orElse: () => '',
    );
    if (match.isNotEmpty) {
      setState(() {
        _suggestion = predefinedSuggestions[match];
        _suggestedItem = null;
      });
      return;
    }
    // Keywords for beach/holiday
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
            if (_selectedImagePath != null) ...[
              const SizedBox(height: 12),
              Image.asset(_selectedImagePath!, height: 120),
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
