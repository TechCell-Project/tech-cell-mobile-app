// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartModel {
  String id;
  String userId;
  int cartCountProduct;
  List<Product> product;
  String cartState;

  CartModel({
    required this.id,
    required this.userId,
    required this.cartCountProduct,
    required this.product,
    required this.cartState,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'userId': userId,
      'cartCountProducts': cartCountProduct,
      'products': product.map((x) => x.toMap()).toList(),
      'cartState': cartState,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['_id'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      cartCountProduct: map['cartCountProducts'] as int? ?? 0,
      product: (map['products'] as List<dynamic>?)
              ?.map<Product>((x) => Product.fromMap(x as Map<String, dynamic>))
              .toList() ??
          [],
      cartState: map['cartState'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Product {
  String productId;
  String sku;
  int quantity;

  Product({
    required this.productId,
    required this.sku,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'sku': sku,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'] as String,
      sku: map['sku'] as String,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
