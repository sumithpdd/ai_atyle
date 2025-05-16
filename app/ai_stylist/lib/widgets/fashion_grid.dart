import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../models/fashion_item.dart';
import '../screens/product_detail_screen.dart';
import '../data/dummy_data.dart';

class FashionGrid extends StatelessWidget {
  final List<FashionItem> items;
  final Function(FashionItem)? onItemTap;

  const FashionGrid({super.key, required this.items, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: items.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            if (onItemTap != null) {
              onItemTap!(item);
            } else {
              // Dynamic recommendations
              final related =
                  dummyFashionItems.where((f) => f.id != item.id).toList();
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(
                    item: item,
                    completeTheLook: completeTheLook,
                    youWillLove: youWillLove,
                  ),
                ),
              );
            }
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.error, size: 32),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.brand,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
