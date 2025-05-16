import 'package:flutter/material.dart';
import '../models/dummy_data.dart';

class OutfitIdeasScreen extends StatelessWidget {
  const OutfitIdeasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Outfit Ideas')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          for (final outfit in dummyOutfits)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      outfit.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        for (final itemId in outfit.itemIds)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Image.asset(
                              dummyWardrobe
                                  .firstWhere((item) => item.id == itemId)
                                  .imageUrl,
                              width: 60,
                              height: 60,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
