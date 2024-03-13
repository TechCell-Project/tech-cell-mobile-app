import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/models/product_model.dart';

class ProductAPI {
  var data = [];

  Future<List<ProductModel>> getAllProducts({String? query}) async {
    final url = 'https://api.techcell.cloud/products?select_type=only_active';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    List<ProductModel> result = [];

    try {
      if (response.statusCode == 200) {
        data = json.decode(response.body)['data'];
        result = data.map((e) => ProductModel.fromJson(e)).toList();

        if (query != null) {
          result = result
              .where((element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } on Exception catch (error) {
      print('Error: $error');
    }
    return result;
  }

  static Future<List<ProductModel>> getProductsByQuantity(
      int page, int pageSize) async {
    final url = 'https://api.techcell.cloud/products?page=' +
        page.toString() +
        '&pageSize=$pageSize&select_type=only_active';
    print(url);
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'] as List<dynamic>;
      final fetchedProducts =
          jsonData.map((e) => ProductModel.fromJson(e)).toList();
      return fetchedProducts;
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }
}
