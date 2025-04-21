import 'package:get/get.dart';
import 'package:ecommerce/controllers/product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(() => ProductDetailController());
  }
}
