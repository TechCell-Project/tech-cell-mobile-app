import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/models/product_model.dart';
import 'package:my_app/utils/constant.dart';

class ProductAPI {
  var data = [];
  List<ProductModel> result = [];
  String url = '${uri}products?select_type=only_active';

  Future<List<ProductModel>> getAllProducts({String? query}) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);

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
        // Handle HTTP error status codes if needed
        print('HTTP Error: ${response.statusCode}');
      }
    } on Exception catch (error) {
      // Handle other types of errors (e.g., network error)
      print('Error: $error');
    }
    // Return an empty list in case of errors
    return result;
  }
}
