import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/controllers/product_detail_controller.dart';
import 'package:ecommerce/widgets/image_carousel.dart';
//import 'package:ecommerce/widgets/rating_bar.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.product.value == null) {
          return Center(child: Text('Product not found'));
        } else {
          final product = controller.product.value!;
          final List<String> displayImages = product.images.isEmpty
              ? [product.thumbnail]
              : product.images;

          return SafeArea(
            child: Column(
              children: [
                // Top Bar with Back Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new, size: 20),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),

                // Image Carousel
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageCarousel(
                          images: displayImages,
                          currentIndex: controller.currentImageIndex.value < displayImages.length
                              ? controller.currentImageIndex.value
                              : 0,
                          onPageChanged: controller.setImageIndex,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Title
                              SizedBox(height: 4),
                              Text(
                                product.title,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                              ),

                              SizedBox(height: 6),
                              // Brand and Category Row
                              Row(
                                children: [
                                  Icon(Icons.storefront, size: 16, color: Colors.grey[600]),
                                  SizedBox(width: 4),
                                  Text(
                                    product.brand,
                                    style: TextStyle(color: Colors.grey[700], fontSize: 13),
                                  ),
                                  SizedBox(width: 16),
                                  Icon(Icons.category_outlined, size: 16, color: Colors.grey[600]),
                                  SizedBox(width: 4),
                                  Text(
                                    product.category,
                                    style: TextStyle(color: Colors.grey[700], fontSize: 13),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20),
                              // Price and Promo
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.purple.shade200,
                                            Colors.pink.shade100
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.bar_chart, size: 24, color: Colors.white),
                                          SizedBox(height: 8),
                                          Text(
                                            '\$${product.price.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.deepOrange,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              'Extra ${product.discountPercentage.toStringAsFixed(0)}% off',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),

                                  // Stock & Delivery
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.check_circle_outline, color: Colors.green),
                                                  SizedBox(width: 4),
                                                  Text('In stock'),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Icon(Icons.local_shipping_outlined, size: 18),
                                                  SizedBox(width: 4),
                                                  Text('Delivery: Tomorrow'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.star_border_outlined, color: Colors.orange),
                                              SizedBox(width: 6),
                                              Text(
                                                product.rating.toStringAsFixed(1),
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(width: 6),
                                              Text('25 reviews'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20),
                              // Description
                              Text(
                                'Description',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 6),
                              Text(
                                product.description,
                                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Action Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Icon(Icons.share),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.snackbar(
                              'Added to Cart',
                              '${product.title} has been added to your cart',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Add to bag',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Icon(Icons.shopping_cart_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}