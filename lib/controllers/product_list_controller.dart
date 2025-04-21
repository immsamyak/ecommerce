import 'package:get/get.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/services/api_service.dart';

class ProductListController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  RxList<Product> products = <Product>[].obs;
  RxList<Product> filteredProducts = <Product>[].obs;
  RxList<String> categories = <String>[].obs;
  RxString selectedCategory = ''.obs;
  RxBool isLoading = true.obs;
  RxBool isSearching = false.obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchCategories();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final fetchedProducts = await _apiService.getProducts();
      products.value = fetchedProducts;
      filteredProducts.value = fetchedProducts;
      print('Fetched ${fetchedProducts.length} products');
    } catch (e) {
      print('Error in fetchProducts: $e');
      Get.snackbar('Error', 'Failed to load products: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCategories() async {
    try {
      final List<String> fetchedCategories = await _apiService.getCategories();
      categories.value = fetchedCategories;
      print('Fetched ${fetchedCategories.length} categories');
    } catch (e) {
      print('Error in fetchCategories: $e');
      Get.snackbar('Error', 'Failed to load categories: $e');
    }
  }

  Future<void> filterByCategory(String category) async {
    try {
      if (category.isEmpty) {
        selectedCategory.value = '';
        filteredProducts.value = products;
        print('Cleared category filter');
        return;
      }

      isLoading(true);
      selectedCategory.value = category;
      final fetchedProducts = await _apiService.getProductsByCategory(category);
      filteredProducts.value = fetchedProducts;
      print('Filtered by category: $category, found ${fetchedProducts.length} products');
    } catch (e) {
      print('Error in filterByCategory: $e');
      Get.snackbar('Error', 'Failed to filter products: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> searchProducts(String query) async {
    try {
      searchQuery.value = query;
      
      if (query.isEmpty) {
        isSearching(false);
        if (selectedCategory.isEmpty) {
          filteredProducts.value = products;
        } else {
          filterByCategory(selectedCategory.value);
        }
        print('Cleared search query');
        return;
      }

      isLoading(true);
      isSearching(true);
      final searchResults = await _apiService.searchProducts(query);
      filteredProducts.value = searchResults;
      print('Search for "$query" found ${searchResults.length} products');
    } catch (e) {
      print('Error in searchProducts: $e');
      Get.snackbar('Error', 'Failed to search products: $e');
    } finally {
      isLoading(false);
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    isSearching(false);
    if (selectedCategory.isEmpty) {
      filteredProducts.value = products;
    } else {
      filterByCategory(selectedCategory.value);
    }
    print('Search cleared');
  }

  void clearFilters() {
    selectedCategory.value = '';
    searchQuery.value = '';
    isSearching(false);
    filteredProducts.value = products;
    print('All filters cleared');
  }
}
