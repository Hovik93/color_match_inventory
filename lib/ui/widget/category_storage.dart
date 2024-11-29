import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryStorage {
  static const String _categoriesKey = 'categories';
  static const String _onboardingKey = 'onboarding_seen';

  /// Проверка, был ли онбординг показан
  static Future<bool> isOnboardingSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  /// Установка флага, что онбординг был просмотрен
  static Future<void> setOnboardingSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  /// Перезаписывает весь список категорий
  static Future<void> overwriteCategories(
      List<Map<String, dynamic>> newCategories) async {
    // Сохраняем переданный список
    await saveCategories(newCategories);
  }

  static Future<void> addCategory(Map<String, dynamic> newCategory) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? encodedCategories = prefs.getString(_categoriesKey);

    List<Map<String, dynamic>> categories = [];
    if (encodedCategories != null) {
      categories =
          List<Map<String, dynamic>>.from(jsonDecode(encodedCategories));
    }

    // Проверяем, существует ли категория
    final bool exists = categories.any((category) =>
        category['title'] == newCategory['title'] &&
        category['icon'] == newCategory['icon']);

    if (!exists) {
      categories.add(newCategory);
      await prefs.setString(_categoriesKey, jsonEncode(categories));
    }
  }

  static Future<void> addImageToSubcategory(
      String categoryTitle, String subcategoryTitle, String imagePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? encodedCategories = prefs.getString(_categoriesKey);

    if (encodedCategories == null) return;

    // Загружаем существующие категории
    List<Map<String, dynamic>> categories =
        List<Map<String, dynamic>>.from(jsonDecode(encodedCategories));

    // Ищем нужную категорию
    for (var category in categories) {
      if (category['title'] == categoryTitle && category['data'] != null) {
        List<dynamic> data = category['data'];

        for (var item in data) {
          if (item['subcategory'] != null) {
            List<dynamic> subcategories = item['subcategory'];

            for (var subcategory in subcategories) {
              if (subcategory['title'] == subcategoryTitle) {
                // Добавляем путь к изображению
                subcategory['image'] = imagePath;
              }
            }
          }
        }
      }
    }

    // Сохраняем обновлённый список категорий
    prefs.setString(_categoriesKey, jsonEncode(categories));
  }

  /// Сохранение категорий в SharedPreferences
  static Future<void> saveCategories(
      List<Map<String, dynamic>> categories) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedCategories = jsonEncode(categories);
    print("Сохраняемые категории: $encodedCategories");
    await prefs.setString(_categoriesKey, encodedCategories);
  }

  /// Загрузка категорий из SharedPreferences
  static Future<List<Map<String, dynamic>>> loadCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? encodedCategories = prefs.getString(_categoriesKey);
    print("Загруженные данные (до декодирования): $encodedCategories");

    if (encodedCategories != null) {
      // Если данные существуют, декодируем их
      final decodedCategories =
          List<Map<String, dynamic>>.from(jsonDecode(encodedCategories));
      print(
          "Загруженные категории (после декодирования): $decodedCategories"); // Лог для проверки
      return decodedCategories;
    } else {
      // Если данных нет, возвращаем пустой список
      return [];
    }
  }

  /// Убедиться, что категория по умолчанию существует
  static Future<void> ensureCategoryExists(
      Map<String, dynamic> defaultCategory) async {
    final List<Map<String, dynamic>> existingCategories =
        await loadCategories();

    // Проверяем, есть ли категория по умолчанию
    final bool exists = existingCategories.any((category) =>
        category['title'] == defaultCategory['title'] &&
        category['icon'] == defaultCategory['icon']);

    if (!exists) {
      // Добавляем категорию по умолчанию в список
      existingCategories.add(defaultCategory);
      await saveCategories(existingCategories);
    }
  }

  // Удаление данных по ключу
  static Future<void> removeCategories() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_categoriesKey)) {
      await prefs.remove(_categoriesKey); // Удаляет данные с указанным ключом
    }
  }

  // Удаление всех данных
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Удаляет все сохранённые данные
  }

  Future<Map<String, dynamic>?> loadMap(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      // Преобразуем JSON-строку обратно в Map
      return jsonDecode(jsonString);
    }
    return null;
  }

  // Внутри CategoryStorage
  static Future<void> updateCategory(String categoryTitle, int color) async {
    // Загружаем существующие категории
    List<Map<String, dynamic>> categories = await loadCategories();

    // Находим нужную категорию по названию
    for (var category in categories) {
      if (category['title'] == categoryTitle) {
        // Обновляем или добавляем ключ data
        category['data'] = {'color': color};
        break;
      }
    }

    // Сохраняем обновлённый список
    await saveCategories(categories);
  }

  static Future<void> updateCategoryWithSubcategory(
      String categoryTitle, Map<String, dynamic> newData) async {
    // Загружаем существующие категории
    List<Map<String, dynamic>> categories = await loadCategories();

    // Находим нужную категорию по названию
    for (var category in categories) {
      if (category['title'] == categoryTitle) {
        // Проверяем наличие ключа 'data'
        if (category['data'] == null || category['data'] is! List) {
          category['data'] = []; // Инициализируем 'data' как пустой список
        }

        // Добавляем новый объект непосредственно в список 'data'
        (category['data'] as List<dynamic>).add(newData);

        break;
      }
    }

    // Сохраняем обновлённый список категорий
    await saveCategories(categories);
  }
}
