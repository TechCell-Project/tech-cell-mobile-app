// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:my_app/models/address_model.dart';
import 'package:my_app/models/cart_model.dart';

class OrderResponse {
  int page;
  int pageSize;
  int totalPage;
  int totalRecord;
  List<OrderUser> data;
  OrderResponse({
    required this.page,
    required this.pageSize,
    required this.totalPage,
    required this.totalRecord,
    required this.data,
  });
  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'pageSize': pageSize,
      'totalPage': totalPage,
      'totalRecord': totalRecord,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderResponse.fromMap(Map<String, dynamic> map) {
    return OrderResponse(
      page: map['page'],
      pageSize: map['pageSize'],
      totalPage: map['totalPage'],
      totalRecord: map['totalRecord'],
      data: (map['data'] as List<dynamic>?)
              ?.map((x) => OrderUser.fromMap(x))
              .toList() ??
          [],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderResponse.fromJson(String source) =>
      OrderResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OrderUser {
  String id;
  String userId;
  List<Product> product;
  CheckoutOrder checkoutOrder;
  ShippingOrder shippingOrder;
  PaymentOrder paymentOrder;
  String trackingCode;
  String oderStatus;
  String createdAt;
  String updatedAt;
  OrderUser({
    required this.id,
    required this.product,
    required this.userId,
    required this.checkoutOrder,
    required this.shippingOrder,
    required this.paymentOrder,
    required this.trackingCode,
    required this.oderStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'userId': userId,
      'products': product.map((x) => x.toMap()).toList(),
      'checkoutOrder': checkoutOrder.toMap(),
      'shippingOrder': shippingOrder.toMap(),
      'paymentOrder': paymentOrder.toMap(),
      'trackingCode': trackingCode,
      'orderStatus': oderStatus,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory OrderUser.fromMap(Map<String, dynamic> map) {
    return OrderUser(
      id: map['_id'],
      userId: map['userId'],
      product:
          List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
      checkoutOrder: CheckoutOrder.fromMap(map['checkoutOrder']),
      shippingOrder: ShippingOrder.fromMap(map['shippingOrder']),
      paymentOrder: PaymentOrder.fromMap(map['paymentOrder']),
      trackingCode: map['trackingCode'],
      oderStatus: map['orderStatus'],
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderUser.fromJson(String source) =>
      OrderUser.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CheckoutOrder {
  int shippingFee;
  int totalApplyDiscount;
  int totalPrice;

  CheckoutOrder({
    required this.shippingFee,
    required this.totalApplyDiscount,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shippingFee': shippingFee,
      'totalApplyDiscount': totalApplyDiscount,
      'totalPrice': totalPrice,
    };
  }

  factory CheckoutOrder.fromMap(Map<String, dynamic> map) {
    return CheckoutOrder(
      shippingFee: map['shippingFee'] ?? 0,
      totalApplyDiscount: map['totalApplyDiscount'] ?? 0,
      totalPrice: map['totalPrice'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckoutOrder.fromJson(String source) =>
      CheckoutOrder.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ShippingOrder {
  AddressModel toAddress;
  ShippingOrder({required this.toAddress});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'toAddress': toAddress.toJson(),
    };
  }

  factory ShippingOrder.fromMap(Map<String, dynamic> map) {
    return ShippingOrder(
      toAddress: map['shippingOrder'] != null
          ? AddressModel.fromMap(map['shippingOrder'])
          : AddressModel(
              addressName: '',
              customerName: '',
              phoneNumbers: '',
              provinceLevel: ProvinceLevel(province_id: 0, province_name: ''),
              districtLevel: DistrictLevel(district_id: 0, district_name: ''),
              wardLevel: WardLevel(wardCode: '', wardName: ''),
              detail: '',
              isDefault: true,
            ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShippingOrder.fromJson(String source) =>
      ShippingOrder.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PaymentOrder {
  String method;
  String status;
  String paymentUrl;
  Object orderData;
  PaymentOrder({
    required this.method,
    required this.orderData,
    required this.paymentUrl,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'method': method,
      'status': status,
      'paymentUrl': paymentUrl,
      'orderData': orderData,
    };
  }

  factory PaymentOrder.fromMap(Map<String, dynamic> json) {
    return PaymentOrder(
      method: json['method'] ?? '',
      status: json['status'] ?? '',
      paymentUrl: json['paymentUrl'] ?? '',
      orderData: json['orderData'] ?? {},
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentOrder.fromJson(String source) =>
      PaymentOrder.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OrderReviewResponse {
  String paymentMethod;
  int addressSelected;
  List<Product> product;
  int totalPrice;
  Shipping shipping;
  OrderReviewResponse({
    required this.paymentMethod,
    required this.addressSelected,
    required this.product,
    required this.totalPrice,
    required this.shipping,
  });
  Map<String, dynamic> toMap() {
    return {
      'paymentMethod': paymentMethod,
      'addressSelected': addressSelected,
      'productSelected': product.map((product) => product.toMap()).toList(),
      'totalProductPrice': totalPrice,
      'shipping': shipping.toMap(),
    };
  }

  factory OrderReviewResponse.fromJson(Map<String, dynamic> json) {
    return OrderReviewResponse(
      paymentMethod: json['paymentMethod'],
      addressSelected: json['addressSelected'],
      product: List<Product>.from(
          json['productSelected']?.map((x) => Product.fromMap(x))),
      totalPrice: json['totalProductPrice'],
      shipping: Shipping.fromJson(json['shipping']),
    );
  }
}

class Shipping {
  Giaohangnhanh giaohangnhanh;

  Shipping({
    required this.giaohangnhanh,
  });

  Map<String, dynamic> toMap() {
    return {
      'giaohangnhanh': giaohangnhanh.toMap(),
    };
  }

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      giaohangnhanh: Giaohangnhanh.fromJson(json['giaohangnhanh']),
    );
  }
}

class Giaohangnhanh {
  int total;
  int serviceFee;

  Giaohangnhanh({
    required this.total,
    required this.serviceFee,
  });

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'service_fee': serviceFee,
    };
  }

  factory Giaohangnhanh.fromJson(Map<String, dynamic> json) {
    return Giaohangnhanh(
      total: json['total'],
      serviceFee: json['service_fee'],
    );
  }
}
