// import 'dart:convert';

// Products productsFromJson(String str) => Products.fromJson(json.decode(str));

// String productsToJson(Products data) => json.encode(data.toJson());

// class Products {
//     final List<Datum> data;

//     Products({
//         required this.data,
//     });

//     factory Products.fromJson(Map<String, dynamic> json) => Products(
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class Datum {
//     final String id;
//     final String name;
//     // final String description;
//     // final Category category;
//     // final int status;
//     // final List<GeneralAttribute> generalAttributes;
//     // final List<Image> generalImages;
//     // final List<dynamic> descriptionImages;
//     // final List<Variation> variations;
//     // final DateTime createdAt;
//     // final DateTime updatedAt;
//     // final int v;

//     Datum({
//         required this.id,
//         required this.name,
//         // required this.description,
//         // required this.category,
//         // required this.status,
//         // required this.generalAttributes,
//         // required this.generalImages,
//         // required this.descriptionImages,
//         // required this.variations,
//         // required this.createdAt,
//         // required this.updatedAt,
//         // required this.v,
//     });

//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["_id"],
//         name: json["name"],
//         // description: json["description"],
//         // category: Category.fromJson(json["category"]),
//         // status: json["status"],
//         // generalAttributes: List<GeneralAttribute>.from(json["generalAttributes"].map((x) => GeneralAttribute.fromJson(x))),
//         // generalImages: List<Image>.from(json["generalImages"].map((x) => Image.fromJson(x))),
//         // descriptionImages: List<dynamic>.from(json["descriptionImages"].map((x) => x)),
//         // variations: List<Variation>.from(json["variations"].map((x) => Variation.fromJson(x))),
//         // createdAt: DateTime.parse(json["createdAt"]),
//         // updatedAt: DateTime.parse(json["updatedAt"]),
//         // v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         // "description": description,
//         // "category": category.toJson(),
//         // "status": status,
//         // "generalAttributes": List<dynamic>.from(generalAttributes.map((x) => x.toJson())),
//         // "generalImages": List<dynamic>.from(generalImages.map((x) => x.toJson())),
//         // "descriptionImages": List<dynamic>.from(descriptionImages.map((x) => x)),
//         // "variations": List<dynamic>.from(variations.map((x) => x.toJson())),
//         // "createdAt": createdAt.toIso8601String(),
//         // "updatedAt": updatedAt.toIso8601String(),
//         // "__v": v,
//     };
// }

// class Category {
//     final String id;
//     final String label;
//     final String name;
//     final String description;
//     final dynamic url;
//     final bool isDeleted;
//     final List<RequireAttribute> requireAttributes;
//     final DateTime createdAt;
//     final DateTime updatedAt;
//     final int v;

//     Category({
//         required this.id,
//         required this.label,
//         required this.name,
//         required this.description,
//         required this.url,
//         required this.isDeleted,
//         required this.requireAttributes,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//     });

//     factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json["_id"],
//         label: json["label"],
//         name: json["name"],
//         description: json["description"],
//         url: json["url"],
//         isDeleted: json["isDeleted"],
//         requireAttributes: List<RequireAttribute>.from(json["requireAttributes"].map((x) => RequireAttribute.fromJson(x))),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "label": label,
//         "name": name,
//         "description": description,
//         "url": url,
//         "isDeleted": isDeleted,
//         "requireAttributes": List<dynamic>.from(requireAttributes.map((x) => x.toJson())),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//     };
// }

// class RequireAttribute {
//     final String label;
//     final String name;
//     final String description;

//     RequireAttribute({
//         required this.label,
//         required this.name,
//         required this.description,
//     });

//     factory RequireAttribute.fromJson(Map<String, dynamic> json) => RequireAttribute(
//         label: json["label"],
//         name: json["name"],
//         description: json["description"],
//     );

//     Map<String, dynamic> toJson() => {
//         "label": label,
//         "name": name,
//         "description": description,
//     };
// }

// class GeneralAttribute {
//     final String k;
//     final String v;
//     final String u;

//     GeneralAttribute({
//         required this.k,
//         required this.v,
//         required this.u,
//     });

//     factory GeneralAttribute.fromJson(Map<String, dynamic> json) => GeneralAttribute(
//         k: json["k"],
//         v: json["v"],
//         u: json["u"],
//     );

//     Map<String, dynamic> toJson() => {
//         "k": k,
//         "v": v,
//         "u": u,
//     };
// }

// class Image {
//     final String url;
//     final String publicId ;
//     final bool isThumbnail;

//     Image({
//         required this.url,
//         required this.publicId,
//         required this.isThumbnail,
//     });

//     factory Image.fromJson(Map<String, dynamic> json) => Image(
//         url: json["url"],
//         publicId: json["publicId"],
//         isThumbnail: json["isThumbnail"],
//     );

//     Map<String, dynamic> toJson() => {
//         "url": url,
//         "publicId": publicId,
//         "isThumbnail": isThumbnail,
//     };
// }

// class Variation {
//     final int status;
//     final Price price;
//     final int stock;
//     final List<Image> images;
//     final List<Attribute> attributes;
//     final String sku;

//     Variation({
//         required this.status,
//         required this.price,
//         required this.stock,
//         required this.images,
//         required this.attributes,
//         required this.sku,
//     });

//     factory Variation.fromJson(Map<String, dynamic> json) => Variation(
//         status: json["status"],
//         price: Price.fromJson(json["price"]),
//         stock: json["stock"],
//         images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
//         attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
//         sku: json["sku"],
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "price": price.toJson(),
//         "stock": stock,
//         "images": List<dynamic>.from(images.map((x) => x.toJson())),
//         "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
//         "sku": sku,
//     };
// }

// class Attribute {
//     final K k;
//     final String v;
//     final String name;
//     final String description;
//     final String u;

//     Attribute({
//         required this.k,
//         required this.v,
//         required this.name,
//         required this.description,
//         required this.u,
//     });

//     factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
//         k: kValues.map[json["k"]]!,
//         v: json["v"],
//         name: json["name"],
//         description: json["description"],
//         u: json["u"],
//     );

//     Map<String, dynamic> toJson() => {
//         "k": kValues.reverse[k],
//         "v": v,
//         "name": name,
//         "description": description,
//         "u": u,
//     };
// }

// enum K {
//     COLOR,
//     STORAGE
// }

// final kValues = EnumValues({
//     "color": K.COLOR,
//     "storage": K.STORAGE
// });

// class Price {
//     final int base;
//     final int sale;
//     final int special;

//     Price({
//         required this.base,
//         required this.sale,
//         required this.special,
//     });

//     factory Price.fromJson(Map<String, dynamic> json) => Price(
//         base: json["base"],
//         sale: json["sale"],
//         special: json["special"],
//     );

//     Map<String, dynamic> toJson() => {
//         "base": base,
//         "sale": sale,
//         "special": special,
//     };
// }

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         reverseMap = map.map((k, v) => MapEntry(v, k));
//         return reverseMap;
//     }
// }

// class Products {
//   String? name;
//   String? description;

//   Products({this.name, this.description});

//   Products.fromJson(Map<String, dynamic> json)
//       : this.name = json['name'],
//         this.description = json['description'];
// }

////////////////////////////////////////////////////////////////

// class ProductModel {
//    final int page;
//     final int pageSize;
//     final int totalPage;
//     final int totalRecord;
//     final List<Datum> data;

//       ProductModel({
//         required this.page,
//         required this.pageSize,
//         required this.totalPage,
//         required this.totalRecord,
//         required this.data,
//     });

//       factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
//         page: json["page"],
//         pageSize: json["pageSize"],
//         totalPage: json["totalPage"],
//         totalRecord: json["totalRecord"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     );

// }

class ProductModel {
  final String id;
  final String name;
  final String description;
  final Category category;
  final List<GeneralAttribute> generalAttributes;
  final List<GeneralImage> generalImages;
  final List<Variation> variations;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.generalAttributes,
    required this.generalImages,
    required this.variations,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        category: Category.fromJson(json["category"]),
        generalAttributes: List<GeneralAttribute>.from(
            json["generalAttributes"].map((x) => GeneralAttribute.fromJson(x))),
        generalImages: List<GeneralImage>.from(
            json["generalImages"].map((x) => GeneralImage.fromJson(x))),
        variations: List<Variation>.from(
            json["variations"].map((x) => Variation.fromJson(x))),
      );
}

class Category {
  final String id;
  final String label;
  final String name;
  final String description;
  final dynamic url;
  final bool isDeleted;
  final List<RequireAttribute> requireAttributes;

  Category({
    required this.id,
    required this.label,
    required this.name,
    required this.description,
    required this.url,
    required this.isDeleted,
    required this.requireAttributes,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        label: json["label"],
        name: json["name"],
        description: json["description"],
        url: json["url"],
        isDeleted: json["isDeleted"],
        requireAttributes: List<RequireAttribute>.from(
            json["requireAttributes"].map((x) => RequireAttribute.fromJson(x))),
      );
}

class RequireAttribute {
  final String label;
  final String name;
  final String description;

  RequireAttribute({
    required this.label,
    required this.name,
    required this.description,
  });

  factory RequireAttribute.fromJson(Map<String, dynamic> json) =>
      RequireAttribute(
        label: json["label"],
        name: json["name"],
        description: json["description"],
      );
}

class GeneralAttribute {
  final String k;
  final String v;
  String? u;
  String? name;

  GeneralAttribute({
    required this.k,
    required this.v,
    this.u,
    this.name,
  });

  factory GeneralAttribute.fromJson(Map<String, dynamic> json) =>
      GeneralAttribute(
        k: json["k"],
        v: json["v"],
        u: json["u"],
        name: json["name"],
      );
}

class GeneralImage {
  final String url;
  final String publicId;
  final bool isThumbnail;

  GeneralImage({
    required this.url,
    required this.publicId,
    required this.isThumbnail,
  });

  factory GeneralImage.fromJson(Map<String, dynamic> json) => GeneralImage(
        url: json["url"],
        publicId: json["publicId"],
        isThumbnail: json["isThumbnail"],
      );
}

class Variation {
  final int status;
  final Price price;
  final int stock;
  final String sku;

  Variation({
    required this.status,
    required this.price,
    required this.stock,
    required this.sku,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        status: json["status"],
        price: Price.fromJson(json["price"]),
        stock: json["stock"],
        sku: json["sku"],
      );
}

class Price {
  final int base;
  final int sale;
  final int special;

  Price({
    required this.base,
    required this.sale,
    required this.special,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        base: json["base"],
        sale: json["sale"],
        special: json["special"],
      );
}
