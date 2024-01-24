class CategoryModels {
  String name;
  String image;

  CategoryModels({required this.name, required this.image});

  static List<CategoryModels> getCategory() {
    List<CategoryModels> categories = [];

    categories.add(CategoryModels(
      name: 'Điện thoại Điện thoại',
      image: 'assets/images/brand_category_img/1.webp',
    ));
    categories.add(CategoryModels(
      name: 'Điện thoại',
      image: 'assets/images/brand_category_img/2.webp',
    ));
    categories.add(CategoryModels(
      name: 'Điện thoại',
      image: 'assets/images/brand_category_img/3.webp',
    ));
    categories.add(CategoryModels(
      name: 'Điện thoại Điện thoại',
      image: 'assets/images/brand_category_img/4.webp',
    ));
    categories.add(CategoryModels(
      name: 'Điện thoại',
      image: 'assets/images/brand_category_img/5.webp',
    ));
    categories.add(CategoryModels(
      name: 'Điện thoại',
      image: 'assets/images/brand_category_img/6.webp',
    ));
    categories.add(CategoryModels(
      name: 'Điện thoại',
      image: 'assets/images/brand_category_img/7.webp',
    ));
    categories.add(CategoryModels(
      name: 'Điện thoại',
      image: 'assets/images/brand_category_img/8.webp',
    ));
    categories.add(CategoryModels(
      name: 'Điện thoại',
      image: 'assets/images/brand_category_img/9.webp',
    ));
    categories.add(CategoryModels(
      name: 'Điện thoại',
      image: 'assets/images/brand_category_img/10.webp',
    ));
    categories.add(CategoryModels(
      name: 'Điện thoại',
      image: 'assets/images/brand_category_img/11.webp',
    ));
    categories.add(CategoryModels(
      name: 'Điện thoại',
      image: 'assets/images/brand_category_img/12.webp',
    ));

    return categories;
  }
}
