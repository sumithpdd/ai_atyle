import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/fashion_provider.dart';
import '../widgets/fashion_grid.dart';
import '../widgets/mood_selector.dart';
import '../widgets/custom_carousel.dart';
import '../models/fashion_item.dart';
import 'ai_upload_screen.dart';
import 'discover_style_screen.dart';
import 'shop_by_mood_screen.dart';
import 'ai_analysis_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMood = ref.watch(selectedMoodProvider);
    final fashionItems = ref.watch(fashionItemsProvider);
    final filteredItems = selectedMood == 'All'
        ? fashionItems
        : fashionItems.where((item) => item.mood == selectedMood).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text('AI Stylist'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // TODO: Implement search
                },
              ),
              IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () {
                  // TODO: Implement profile
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: CustomCarousel(
              items: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const DiscoverStyleScreen()),
                  ),
                  child: _buildCarouselItem(
                    context,
                    'Discover Your Style',
                    'Get personalized fashion recommendations',
                    Icons.style,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const ShopByMoodScreen()),
                  ),
                  child: _buildCarouselItem(
                    context,
                    'Shop by Mood',
                    'Find outfits that match your mood',
                    Icons.mood,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const AIAnalysisScreen()),
                  ),
                  child: _buildCarouselItem(
                    context,
                    'AI Analysis',
                    'Get your personal style analysis',
                    Icons.analytics,
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: MoodSelector(),
            ),
          ),
          SliverToBoxAdapter(
            child: FashionGrid(
              items: filteredItems,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AIUploadScreen()),
          );
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Widget _buildCarouselItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.8),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
