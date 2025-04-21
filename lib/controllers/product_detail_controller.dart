import 'package:get/get.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/services/api_service.dart';

class ProductDetailController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  Rx<Product?> product = Rx<Product?>(null);
  RxBool isLoading = true.obs;
  RxInt currentImageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Safely get the product ID from arguments
    final dynamic args = Get.arguments;
    int productId;
    
    if (args is int) {
      productId = args;
    } else if (args is String) {
      try {
        productId = int.parse(args);
      } catch (e) {
        print('Invalid product ID format: $args');
        Get.snackbar('Error', 'Invalid product ID');
        productId = 0;
      }
    } else {
      print('Invalid product ID type: ${args.runtimeType}');
      Get.snackbar('Error', 'Invalid product ID');
      productId = 0;
    }
    
    if (productId > 0) {
      fetchProductDetails(productId);
    } else {
      isLoading(false);
      Get.back();
    }
  }

  Future<void> fetchProductDetails(int id) async {
    try {
      isLoading(true);
      print('Fetching product details for ID: $id');
      final fetchedProduct = await _apiService.getProductById(id);
      product.value = fetchedProduct;
      print('Product details fetched successfully: ${fetchedProduct.title}');
    } catch (e) {
      print('Error in fetchProductDetails: $e');
      Get.snackbar('Error', 'Failed to load product details: $e');
    } finally {
      isLoading(false);
    }
  }

  void nextImage() {
    if (product.value != null && currentImageIndex < product.value!.images.length - 1) {
      currentImageIndex++;
    }
  }

  void previousImage() {
    if (currentImageIndex > 0) {
      currentImageIndex--;
    }
  }

  void setImageIndex(int index) {
    if (product.value != null && index >= 0 && index < product.value!.images.length) {
      currentImageIndex.value = index;
    }
  }
}
