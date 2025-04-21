import 'package:get/get.dart';
import 'package:ecommerce/services/api_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService(), permanent: true);
  }
}
