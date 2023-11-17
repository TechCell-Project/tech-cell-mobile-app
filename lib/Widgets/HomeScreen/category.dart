import 'package:flutter/material.dart';
import 'package:my_app/models/category_model.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<CategoryModels> categories = [];

  void _getCategory() {
    categories = CategoryModels.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Container(
        height: 250,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.15,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    child: Image.asset(
                      categories[index].image,
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  categories[index].name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF3B3B3B),
                    fontSize: 14,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
