import 'package:flutter/material.dart';
import 'package:my_app/API/api_product.dart';
import 'package:my_app/Pages/Tabs/search_category.dart';
import 'package:my_app/Providers/product_provider.dart';
import 'package:my_app/models/product_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductProvider>(context, listen: false).getProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: FutureBuilder<List<ProductModel>>(
          future: ProductAPI().getAllProducts(),
          builder: (context, snapshot) {
            if ((snapshot.hasError) || (!snapshot.hasData)) {
              return Padding(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (snapshot.data == null) {
              return Center(
                child: Text('No Data!'),
              );
            }

            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text('Data Empty!'),
              );
            }

            List<ProductModel>? products = snapshot.data;

            return Container(
              child: _buildCategory(products),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategory(products) {
    List<String> _getUniqueCategories(List<ProductModel> products) {
      return products.map((product) => product.category.name).toSet().toList();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 50,
      ),
      itemCount: _getUniqueCategories(products!).length,
      itemBuilder: (context, index) {
        final category = _getUniqueCategories(products)[index];
        final categoryProducts = products
            .where((product) => product.category.name == category)
            .toList();
        return Container(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchCategory(
                    category: category,
                    products: categoryProducts,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColors,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              '${category}',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
