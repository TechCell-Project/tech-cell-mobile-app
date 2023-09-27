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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 100,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 25),
            padding: const EdgeInsets.only(left: 20, right: 20),
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                height: 25,
                width: 100,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 254, 201, 197),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(categories[index].iconPath),
                    ),
                    Text(
                      categories[index].name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 187, 187, 187),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
