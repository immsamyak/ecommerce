import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/routes/app_pages.dart';
import 'package:ecommerce/theme/app_theme.dart';
import 'package:ecommerce/bindings/initial_binding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Product App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: InitialBinding(),
    );
  }
}
