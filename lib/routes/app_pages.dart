import 'package:get/get.dart';
import 'package:ecommerce/views/product_list_view.dart';
import 'package:ecommerce/views/product_detail_view.dart';
import 'package:ecommerce/bindings/product_list_binding.dart';
import 'package:ecommerce/bindings/product_detail_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.PRODUCT_LIST;

  static final routes = [
    GetPage(
      name: Routes.PRODUCT_LIST,
      page: () => ProductListView(),
      binding: ProductListBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT_DETAIL,
      page: () => ProductDetailView(),
      binding: ProductDetailBinding(),
    ),
  ];
}