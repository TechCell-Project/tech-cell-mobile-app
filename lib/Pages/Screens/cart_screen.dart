import 'package:flutter/material.dart';
import 'package:my_app/API/api_cart.dart';
import 'package:my_app/API/api_login.dart';
import 'package:my_app/Pages/Tabs/cart_tap.dart';
import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/models/cart_model.dart';
import 'package:my_app/utils/constant.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> productCartItem = [];
  CartModel productCart = CartModel(
    id: '',
    userId: '',
    product: [],
    cartCountProduct: 0,
    cartState: '',
  );

  @override
  void initState() {
    super.initState();
    CartApi().getCart(context).then((data) {
      setState(() {
        productCart = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColors,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<String?>(
        future: AuthLogin.getAccessToken(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          } else {
            return ListView.builder(
              itemCount: productCart.product.length,
              itemBuilder: (context, index) {
                final productId = productCart.product[index].productId;
                final sku = productCart.product[index].sku;
                final quantity = productCart.product[index].quantity;
                return Column(
                  children: [
                    CartTap(
                      productId: productId,
                      sku: sku,
                      quantity: quantity,
                      productCartItem: productCartItem,
                      productCart: productCart,
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 200,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF475269).withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng giá:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'VND',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ButtonSendrequest(
                text: 'Thanh toán',
                submit: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
