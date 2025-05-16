import 'package:flutter/material.dart';
import '../models/fashion_item.dart';

class ProductDetailScreen extends StatefulWidget {
  final FashionItem item;
  final List<FashionItem> completeTheLook;
  final List<FashionItem> youWillLove;

  const ProductDetailScreen({
    Key? key,
    required this.item,
    this.completeTheLook = const [],
    this.youWillLove = const [],
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? _selectedSize;
  String? _selectedColor;

  @override
  void initState() {
    super.initState();
    if (widget.item.sizes.isNotEmpty) {
      _selectedSize = widget.item.sizes.first;
    }
    if (widget.item.colors.isNotEmpty) {
      _selectedColor = widget.item.colors.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product images (main + thumbnails)
              Center(
                child:
                    Image.asset(item.imageUrl, height: 300, fit: BoxFit.cover),
              ),
              const SizedBox(height: 16),
              Text(item.name, style: Theme.of(context).textTheme.titleLarge),
              Text(item.brand, style: const TextStyle(color: Colors.grey)),
              Text('£${item.price.toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              // Color options
              if (item.colors.isNotEmpty) ...[
                const Text('Color:'),
                Row(
                  children: item.colors
                      .map((color) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(color),
                              selected: _selectedColor == color,
                              onSelected: (_) =>
                                  setState(() => _selectedColor = color),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 12),
              ],
              // Size options
              if (item.sizes.isNotEmpty) ...[
                const Text('Size:'),
                Wrap(
                  spacing: 8,
                  children: item.sizes
                      .map((size) => ChoiceChip(
                            label: Text(size),
                            selected: _selectedSize == size,
                            onSelected: (_) =>
                                setState(() => _selectedSize = size),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 12),
              ],
              ElevatedButton(
                onPressed: () {},
                child: const Text('Select a Size'),
              ),
              const SizedBox(height: 16),
              // Expandable sections
              _buildExpansionTile('Description', [
                const Text('100% polyester'),
                const Text(
                    'Loose fit, high neck, short sleeves, all-over plisse texture'),
              ]),
              _buildExpansionTile('Size & Fit', [
                const Text('True to size'),
                const Text('Size small: length 132cm'),
                const Text('Model is 5ft 11in/1.80m and wears a size small'),
                const Text('Lightweight, non-stretch'),
              ]),
              _buildExpansionTile('Care', [
                const Text('Hand wash'),
              ]),
              const SizedBox(height: 24),
              if (widget.completeTheLook.isNotEmpty) ...[
                const Text('COMPLETE THE LOOK...',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildProductScroller(widget.completeTheLook),
                const SizedBox(height: 24),
              ],
              if (widget.youWillLove.isNotEmpty) ...[
                const Text('WE THINK YOU\'LL LOVE',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildProductScroller(widget.youWillLove),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionTile(String title, List<Widget> children) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      children: children,
      initiallyExpanded: title == 'Description',
    );
  }

  Widget _buildProductScroller(List<FashionItem> items) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ProductDetailScreen(item: item),
              ));
            },
            child: SizedBox(
              width: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item.imageUrl,
                      height: 100,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis),
                  Text('£${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
