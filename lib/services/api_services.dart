import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com';

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products?limit=100'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List products = data['products'];
      return products.map((p) => Product.fromJson(p)).toList();
    }
    throw Exception('Failed to load products');
  }

  static Future<List<String>> fetchCategories() async {
    final response =
        await http.get(Uri.parse('$_baseUrl/products/category-list'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return List<String>.from(data);
    }
    throw Exception('Failed to load categories');
  }

  static Future<List<Product>> fetchProductsByCategory(
      String category) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/products/category/$category?limit=100'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List products = data['products'];
      return products.map((p) => Product.fromJson(p)).toList();
    }
    throw Exception('Failed to load products by category');
  }

  static Future<Product> fetchProductById(int id) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/products/$id'));
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to load product');
  }
}
