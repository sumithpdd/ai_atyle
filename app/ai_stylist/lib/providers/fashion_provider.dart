import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/fashion_item.dart';
import '../data/dummy_data.dart';

final fashionItemsProvider =
    StateNotifierProvider<FashionItemsNotifier, List<FashionItem>>((ref) {
      return FashionItemsNotifier();
    });

class FashionItemsNotifier extends StateNotifier<List<FashionItem>> {
  FashionItemsNotifier() : super(dummyFashionItems);

  void addItem(FashionItem item) {
    state = [...state, item];
  }

  void removeItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  List<FashionItem> getItemsByMood(String mood) {
    return state.where((item) => item.mood == mood).toList();
  }

  List<FashionItem> getItemsByStyle(String styleType) {
    return state.where((item) => item.styleType == styleType).toList();
  }

  List<FashionItem> getItemsByCategory(String category) {
    return state.where((item) => item.category == category).toList();
  }
}

final selectedMoodProvider = StateProvider<String>((ref) => 'All');
final selectedStyleProvider = StateProvider<String>((ref) => 'All');
final selectedCategoryProvider = StateProvider<String>((ref) => 'All');
