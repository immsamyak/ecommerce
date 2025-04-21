import 'package:get/get.dart';
import 'package:ecommerce/controllers/product_list_controller.dart';

class ProductListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductListController>(() => ProductListController());
  }
}
