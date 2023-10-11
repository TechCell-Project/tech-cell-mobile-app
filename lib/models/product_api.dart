class ProductApi {
  int id;
  String title;
  double price;
  String descrpition;
  String catgory;
  String image;
  ProductApi({
    required this.id,
    required this.title,
    required this.price,
    required this.descrpition,
    required this.catgory,
    required this.image,
  });
  factory ProductApi.fromJson(Map<String, dynamic> json) {
    return ProductApi(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        descrpition: json['descrpition'],
        catgory: json['catgory'],
        image: json['image']);
  }
}
