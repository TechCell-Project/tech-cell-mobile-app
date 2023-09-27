class ProductModel {
  String name;
  int price;
  String image;
  int reView;
  ProductModel({
    required this.name,
    required this.price,
    required this.image,
    required this.reView,
  });

  static List<ProductModel> getProduct() {
    List<ProductModel> product = [];

    product.add(ProductModel(
      name: 'Samsung Galaxy Z Flip 5',
      price: 19990000,
      image: 'd4a672c5-4709-4056-9f7f-72d6d70c2c1d_1',
      reView: 24,
    ));
    product.add(ProductModel(
      name: 'Samsung Galaxy Z Fold 5',
      price: 34990000,
      image: 'galaxy-z-fold-5-xanh-1',
      reView: 30,
    ));
    product.add(ProductModel(
      name: 'Samsung Galaxy S23 Ultra',
      price: 23590000,
      image: 'galaxys23ultra_front_green_221122_2',
      reView: 35,
    ));
    product.add(ProductModel(
      name: 'Samsung Galaxy Z Flip 4',
      price: 14990000,
      image: 'samsung_galaxy_z_flip_m_i_2022-1_1',
      reView: 21,
    ));
    product.add(ProductModel(
      name: 'Samsung Galaxy S22 Ultra',
      price: 18290000,
      image: 'sm-s908_galaxys22ultra_front_phantomblack_211119_2',
      reView: 15,
    ));

    return product;
  }
}
