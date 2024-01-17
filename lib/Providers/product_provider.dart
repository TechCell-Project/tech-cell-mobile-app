import 'package:flutter/material.dart';
import 'package:my_app/API/api_product.dart';

import 'package:my_app/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  ProductAPI _productAPI = ProductAPI();
  bool isLoading = false;
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  Future<void> getProduct() async {
    isLoading = true;
    notifyListeners();

    final response = await _productAPI.getAllProducts();
    _products = response;
    isLoading = false;
    notifyListeners();
  }
}
