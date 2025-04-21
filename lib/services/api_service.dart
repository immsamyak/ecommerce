import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/product.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products?limit=100'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> productsJson = data['products'];
        
        // Debug the response
        print('Products API response: ${productsJson.length} items');
        
        return productsJson.map((json) {
          try {
            return Product.fromJson(json);
          } catch (e) {
            print('Error parsing product: $e');
            print('Problematic JSON: $json');
            // Return a placeholder product in case of parsing error
            return Product(
              id: 0,
              title: 'Error loading product',
              description: '',
              price: 0,
              discountPercentage: 0,
              rating: 0,
              stock: 0,
              brand: '',
              category: '',
              thumbnail: '',
              images: [],
            );
          }
        }).toList();
      } else {
        print('Products API error: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Error: $e');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/search?q=$query'),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> productsJson = data['products'];
        
        // Debug the response
        print('Search API response: ${productsJson.length} items');
        
        return productsJson.map((json) {
          try {
            return Product.fromJson(json);
          } catch (e) {
            print('Error parsing search result: $e');
            print('Problematic JSON: $json');
            // Return a placeholder product in case of parsing error
            return Product(
              id: 0,
              title: 'Error loading product',
              description: '',
              price: 0,
              discountPercentage: 0,
              rating: 0,
              stock: 0,
              brand: '',
              category: '',
              thumbnail: '',
              images: [],
            );
          }
        }).toList();
      } else {
        print('Search API error: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to search products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching products: $e');
      throw Exception('Error: $e');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/categories'),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> categoriesJson = json.decode(response.body);
        
        // Debug the response
        print('Categories API response: ${categoriesJson.length} items');
        
        // Explicitly handle null values and ensure all items are strings
        return categoriesJson
    .where((item) => item != null && item['slug'] != null)
    .map<String>((item) => item['slug'].toString())
    .toList();

      } else {
        print('Categories API error: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      throw Exception('Error: $e');
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/category/$category'),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> productsJson = data['products'];
        
        // Debug the response
        print('Category products API response: ${productsJson.length} items');
        
        return productsJson.map((json) {
          try {
            return Product.fromJson(json);
          } catch (e) {
            print('Error parsing category product: $e');
            print('Problematic JSON: $json');
            // Return a placeholder product in case of parsing error
            return Product(
              id: 0,
              title: 'Error loading product',
              description: '',
              price: 0,
              discountPercentage: 0,
              rating: 0,
              stock: 0,
              brand: '',
              category: '',
              thumbnail: '',
              images: [],
            );
          }
        }).toList();
      } else {
        print('Category products API error: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load products by category: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products by category: $e');
      throw Exception('Error: $e');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/$id'),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> productJson = json.decode(response.body);
        
        // Debug the response
        print('Product detail API response for ID $id');
        
        try {
          return Product.fromJson(productJson);
        } catch (e) {
          print('Error parsing product detail: $e');
          print('Problematic JSON: $productJson');
          // Return a placeholder product in case of parsing error
          return Product(
            id: id,
            title: 'Error loading product',
            description: 'Failed to load product details',
            price: 0,
            discountPercentage: 0,
            rating: 0,
            stock: 0,
            brand: '',
            category: '',
            thumbnail: '',
            images: [],
          );
        }
      } else {
        print('Product detail API error: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load product details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching product details: $e');
      throw Exception('Error: $e');
    }
  }
}
