import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/fashion_provider.dart';

class MoodSelector extends ConsumerWidget {
  const MoodSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMood = ref.watch(selectedMoodProvider);
    final moods = [
      'All',
      'Casual',
      'Elegant',
      'Sporty',
      'Bohemian',
      'Minimalist',
      'Vintage',
      'Streetwear',
    ];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: moods.length,
        itemBuilder: (context, index) {
          final mood = moods[index];
          final isSelected = mood == selectedMood;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(mood),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  ref.read(selectedMoodProvider.notifier).state = mood;
                }
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Theme.of(context).colorScheme.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }
}
