class CategoryModels {
  String name;
  String iconPath;

  CategoryModels({required this.name, required this.iconPath});

  static List<CategoryModels> getCategory() {
    List<CategoryModels> categories = [];

    categories.add(
      CategoryModels(
        name: 'laptop',
        iconPath: 'assets/icons/laptop.png',
      ),
    );

    categories.add(
      CategoryModels(
        name: 'headset',
        iconPath: 'assets/icons/headset.png',
      ),
    );
    categories.add(
      CategoryModels(
        name: 'keyboard',
        iconPath: 'assets/icons/keyboard.png',
      ),
    );
    categories.add(
      CategoryModels(
        name: 'mouse-clicker',
        iconPath: 'assets/icons/mouse-clicker.png',
      ),
    );
    categories.add(
      CategoryModels(
        name: 'smartphone',
        iconPath: 'assets/icons/smartphone.png',
      ),
    );

    return categories;
  }
}
