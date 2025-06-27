import 'dart:convert';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  // Replace with your actual Django API endpoint
  static const String _baseUrl = 'http://192.168.43.139:8000/api/products/';

  Future<List<Product>> fetchProducts() async {
    print('Fetching products from \\_baseUrl: \\$_baseUrl');
    final response = await http.get(Uri.parse(_baseUrl));
    print('Status code: \\${response.statusCode}');
    print('Response body: \\${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print('Decoded data: \\${data.length} products');
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products: \\${response.statusCode}');
    }
  }
} 