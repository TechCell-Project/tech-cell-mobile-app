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

  Category({
    required this.id,
    required this.label,
    required this.name,
    required this.description,
    required this.url,
    required this.isDeleted,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        label: json["label"],
        name: json["name"],
        description: json["description"],
        url: json["url"],
        isDeleted: json["isDeleted"],
      );
}

class GeneralAttribute {
  final String k;
  final String v;
  final String name;
  final String u;

  GeneralAttribute({
    required this.k,
    required this.v,
    required this.name,
    required this.u,
  });

  factory GeneralAttribute.fromJson(Map<String, dynamic> json) =>
      GeneralAttribute(
        k: json["k"] ?? '',
        v: json["v"] ?? '',
        name: json["name"] ?? '',
        u: json["u"] ?? '',
      );
}

class GeneralImage {
  final String url;
  final String publicId;
  bool? isThumbnail;

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
  final List<ImageVariation> images;
  final List<Attributes> attributes;
  final String sku;

  Variation({
    required this.status,
    required this.price,
    required this.stock,
    required this.images,
    required this.attributes,
    required this.sku,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        status: json["status"],
        price: Price.fromJson(json["price"]),
        stock: json["stock"],
        images: List<ImageVariation>.from(
            json["images"].map((x) => ImageVariation.fromJson(x))),
        attributes: List<Attributes>.from(
            json["attributes"].map((x) => Attributes.fromJson(x))),
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
        sale: json["sale"] ?? 0,
        special: json["special"],
      );
}

class ImageVariation {
  final String url;
  final String publicId;
  bool? isThumbnail;

  ImageVariation({
    required this.url,
    required this.publicId,
    required this.isThumbnail,
  });

  factory ImageVariation.fromJson(Map<String, dynamic> json) => ImageVariation(
        url: json["url"],
        publicId: json["publicId"],
        isThumbnail: json["isThumbnail"],
      );
}

class Attributes {
  final String k;
  final String v;
  String? u;
  final String name;

  Attributes({
    required this.k,
    required this.v,
    this.u,
    required this.name,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        k: json["k"],
        v: json["v"],
        u: json["u"],
        name: json["name"],
      );
}
