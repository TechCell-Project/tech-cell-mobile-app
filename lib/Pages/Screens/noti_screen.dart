import 'package:flutter/material.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({Key? key}) : super(key: key);

  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  List<bool> productSelected = []; // Track selection for each product
  double totalAmount = 0; // Total amount of selected products

  @override
  void initState() {
    super.initState();
    // Initialize productSelected list with false for each product
    productSelected =
        List.generate(productCart.product.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Color(0xFFEDECF2)),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Handle button press to toggle between selecting all and deselecting all checkboxes
                bool allSelected =
                    productSelected.every((isSelected) => isSelected);
                setState(() {
                  if (allSelected) {
                    productSelected = List.generate(
                        productCart.product.length, (index) => false);
                  } else {
                    productSelected = List.generate(
                        productCart.product.length, (index) => true);
                  }
                  updateTotalAmount(); // Update total amount after toggling
                });
              },
              child: Text('Select All'),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: productCart.product.length,
                itemBuilder: (context, index) {
                  final itemCart = productCart.product[index];
                  return CheckboxListTile(
                    title: Text(itemCart.productName),
                    subtitle: Text('Price: \$${itemCart.price.toString()}'),
                    value: productSelected[index],
                    onChanged: (bool? value) {
                      setState(() {
                        productSelected[index] = value ?? false;
                        updateTotalAmount(); // Update total amount when selection changes
                      });
                    },
                  );
                },
              ),
            ),
            Text(
              'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle button press to get selected products
                List<Product> selectedProducts = [];
                for (int i = 0; i < productCart.product.length; i++) {
                  if (productSelected[i]) {
                    selectedProducts.add(productCart.product[i]);
                  }
                }
                // Do something with selectedProducts
                print('Selected Products: $selectedProducts');
              },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }

  void updateTotalAmount() {
    double total = 0;
    for (int i = 0; i < productCart.product.length; i++) {
      if (productSelected[i]) {
        total += productCart.product[i].price;
      }
    }
    setState(() {
      totalAmount = total;
    });
  }
}

class Product {
  final String productName;
  final double price;

  Product({required this.productName, required this.price});
}

class ProductCart {
  final List<Product> product;

  ProductCart({required this.product});
}

// Sample data
ProductCart productCart = ProductCart(
  product: [
    Product(productName: 'Product 1', price: 10.0),
    Product(productName: 'Product 2', price: 20.0),
    Product(productName: 'Product 3', price: 15.0),
  ],
);
