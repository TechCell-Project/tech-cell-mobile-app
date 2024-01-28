import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/models/product_model.dart';

class ProductAPI {
  var data = [];
  List<ProductModel> result = [];
  String url = 'https://api.techcell.cloud/products?select_type=only_active';

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
        // final String jsonBody = response.body;
        // final List productList = json.decode(jsonBody)['data'];

        // if (query != null) {
        //   productList
        //       .where((element) =>
        //           element['name'].toLowerCase().contains((query.toLowerCase())))
        //       .toList();
        // }

        // return productList
        //     .map((contactRaw) => ProductModel.fromJson(contactRaw))
        //     .toList();
      } else {
        // Handle HTTP error status codes if needed
        print('HTTP Error: ${response.statusCode}');
      }
    } on Exception catch (error) {
      // Handle other types of errors (e.g., network error)
      print('Error: $error');
    }

    return result; // Return an empty list in case of errors
  }
}
