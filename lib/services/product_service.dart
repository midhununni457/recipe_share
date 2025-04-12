import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_circle/models/product_model.dart';

class ProductService {
  final String apiUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
