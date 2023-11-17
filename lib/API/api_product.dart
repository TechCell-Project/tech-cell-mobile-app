import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/models/product_model.dart';

class ProductAPI {
  Future<List<ProductModel>> getAllProducts() async {
    const url = 'https://api.techcell.cloud/products?select_type=only_active';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final String jsonBody = response.body;
      final JsonDecoder _decoder = new JsonDecoder();
      final productListContainer = _decoder.convert(jsonBody);
      final List productList = productListContainer['data'];
      return productList
          .map((contactRaw) => new ProductModel.fromJson(contactRaw))
          .toList();
    }
    return [];
  }
}
