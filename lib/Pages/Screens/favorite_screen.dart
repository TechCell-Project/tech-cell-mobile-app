import 'package:flutter/material.dart';
import 'package:my_app/Providers/product_provider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final product =
        Provider.of<ProductProvider>(context, listen: false).products;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: product.length,
                itemBuilder: (context, index) {
                  return Text('${product[index].name}');
                },
              ),
              Text('${product.length}'),
              Text('as'),
            ],
          ),
        ),
      ),
    );
  }
}
