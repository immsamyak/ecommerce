import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/controllers/product_list_controller.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:ecommerce/widgets/shimmer_loading.dart';
import 'package:ecommerce/routes/app_pages.dart';

class ProductListView extends GetView<ProductListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            _buildCustomAppBar(context),
            _buildCategoryFilter(),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return _buildLoadingShimmer();
                } else if (controller.filteredProducts.isEmpty) {
                  return _buildEmptyState();
                } else {
                  return _buildProductGrid();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Online Shopping",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications_none, color: Colors.grey[700]),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart_outlined, color: Colors.grey[700]),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10),
          // Search Bar
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search for products, brands and more",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => controller.searchProducts(value),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Obx(() {
      if (controller.categories.isEmpty) {
        return SizedBox(
          height: 50,
          child: Center(
            child: controller.isLoading.value
                ? CircularProgressIndicator(color: Get.theme.primaryColor)
                : Text("No categories available", style: TextStyle(fontSize: 16)),
          ),
        );
      }

      return Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 12),
          itemCount: controller.categories.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) return _buildCategoryChip('All', '');
            final category = controller.categories[index - 1];
            return _buildCategoryChip(_formatCategoryName(category), category);
          },
        ),
      );
    });
  }

  Widget _buildCategoryChip(String label, String categoryValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Obx(() {
        final isSelected = controller.selectedCategory.value == categoryValue;
        return ChoiceChip(
          label: Text(label),
          selected: isSelected,
          onSelected: (_) => controller.filterByCategory(categoryValue),
          labelStyle: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : Colors.black87,
          ),
          selectedColor: Colors.deepPurple,
          backgroundColor: Colors.grey[200],
          shape: StadiumBorder(),
        );
      }),
    );
  }

  String _formatCategoryName(String category) {
    return category
        .split('-')
        .map((e) => e[0].toUpperCase() + e.substring(1))
        .join(' ');
  }

  Widget _buildProductGrid() {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchProducts();
        await controller.fetchCategories();
      },
      child: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: controller.filteredProducts.length,
        itemBuilder: (context, index) {
          final product = controller.filteredProducts[index];
          return ProductCard(
            product: product,
            onTap: () => Get.toNamed(Routes.PRODUCT_DETAIL, arguments: product.id),
          );
        },
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ShimmerLoading(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text('No products found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700])),
          SizedBox(height: 8),
          Text('Try changing your search or filters', style: TextStyle(color: Colors.grey[600])),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => controller.clearFilters(),
            child: Text('Clear Filters'),
          ),
        ],
      ),
    );
  }
}
