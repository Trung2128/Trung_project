import 'package:flutter/material.dart';
import 'package:duan_thi/model/recipe_model.dart';

class FavoriteStore {
  // Chuyển sang ValueNotifier để các màn hình có thể "nghe" sự thay đổi
  static final ValueNotifier<List<Recipe>> favoritesNotifier = ValueNotifier(
    [],
  );

  // Hàm lấy danh sách hiện tại cho tiện gọi
  static List<Recipe> get favorites => favoritesNotifier.value;

  static bool isFavorite(int id) {
    return favorites.any((p) => p.id == id);
  }

  static bool toggle(Recipe recipe) {
    final List<Recipe> currentList = List.from(favorites); // Tạo bản sao list
    final index = currentList.indexWhere((p) => p.id == recipe.id);

    bool isAdded;
    if (index >= 0) {
      currentList.removeAt(index);
      isAdded = false;
    } else {
      currentList.add(recipe);
      isAdded = true;
    }

    // Gán lại để thông báo cho các Widget đang lắng nghe (ValueListenableBuilder)
    favoritesNotifier.value = currentList;
    return isAdded;
  }
}
