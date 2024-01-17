// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/API/api_cart.dart';
import 'package:my_app/API/api_product.dart';
import 'package:my_app/Pages/Tabs/add_address._tap.dart';
import 'package:my_app/Pages/Tabs/change_address.dart';
import 'package:my_app/Pages/Tabs/confirm_order.dart';
import 'package:my_app/Providers/product_provider.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/models/address_model.dart';
import 'package:my_app/models/product_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:provider/provider.dart';

class CartTap extends StatefulWidget {
  final productId;
  final sku;
  final quantity;
  final productCart;
  final productCartItem;
  const CartTap({
    super.key,
    required this.productId,
    required this.sku,
    required this.quantity,
    required this.productCart,
    required this.productCartItem,
  });

  @override
  State<CartTap> createState() => _CartTapState();
}

class _CartTapState extends State<CartTap> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 160,
        // padding: EdgeInsets.all(5),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: FutureBuilder<List<ProductModel>>(
            future: ProductAPI().getAllProducts(),
            builder: (context, snapshot) {
              if ((snapshot.hasError) || (!snapshot.hasData)) {
                return Container(
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

              return Consumer<ProductProvider>(
                builder: (context, value, child) {
                  final products = value.products;
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return CartItem(
                        product: product,
                        productCartItem: widget.productCartItem,
                        productId: widget.productId,
                        sku: widget.sku,
                        productCart: widget.productCart,
                        quantity: widget.quantity,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatefulWidget {
  ProductModel product;
  final productId;
  final sku;
  final quantity;
  final productCart;
  final productCartItem;
  CartItem({
    required this.product,
    required this.productCartItem,
    required this.productId,
    required this.sku,
    required this.productCart,
    required this.quantity,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool isThumbnail = false;
  bool checked = true;
  int valueChecked = 0;

  final formatCurrency =
      new NumberFormat.currency(locale: 'id', decimalDigits: 0, name: 'đ');

  @override
  void initState() {
    super.initState();
  }

  void inCrementQuantity(int index) {
    setState(() {
      widget.productCart.product[index].quantity++;
    });
    CartApi().updateCart(
      context: context,
      productId: widget.productCart.product[index].productId,
      sku: widget.productCart.product[index].sku,
      quantity: widget.productCart.product[index].quantity,
    );
  }

  void deCrementQuantity(int index) {
    setState(() {
      if (widget.productCart.product[index].quantity > 1) {
        widget.productCart.product[index].quantity--;
      } else {
        return;
      }
    });
    CartApi().updateCart(
      context: context,
      productId: widget.productCart.product[index].productId,
      sku: widget.productCart.product[index].sku,
      quantity: widget.productCart.product[index].quantity,
    );
  }

  void deleteProductCart(int index) {
    setState(() {
      widget.productCart.product[index].quantity = 0;
    });
    CartApi().updateCart(
      context: context,
      productId: widget.productCart.product[index].productId,
      sku: widget.productCart.product[index].sku,
      quantity: widget.productCart.product[index].quantity,
    );
  }

  // int getquantity() {
  //   int totalQuantity = 0;
  //   for (int i = 0; i < widget.productCart.product.length; i++) {
  //     totalQuantity += widget.productCart.product[i].quantity;
  //   }
  //   return totalQuantity;
  // }

  // double getCartTotal() {
  //   double total = 0;
  //   for (int i = 0; i < widget.productCart.product.length; i++) {
  //     total += widget.productCart.product[i].quantity * price[i];
  //   }
  //   return total;
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.product.id == widget.productId) {
      return Dismissible(
        key: Key(widget.productId),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          // deleteProductCart();
        },
        background: Container(
          width: 10,
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 16),
          child: Center(
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        child: Container(
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          // margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          // padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.product.variations.length,
                  itemBuilder: (context, index) {
                    final variation = widget.product.variations[index];
                    if (variation.sku == widget.sku) {
                      return Row(
                        children: [
                          Checkbox(
                            value: checked,
                            onChanged: (val) {
                              setState(() {
                                checked = !checked;
                              });
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150, // Adjust the height as needed
                                width: 90,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: variation.images.length,
                                  itemBuilder: (context, index) {
                                    final image = variation.images[index];
                                    if (image.isThumbnail == true) {
                                      return Image(
                                        image: NetworkImage('${image.url}'),
                                        height: 90,
                                        width: 90,
                                      );
                                    }
                                    return SizedBox();
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.product.name}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text('Phân loại:'),
                                  Container(
                                    height: 15, // Adjust the height as needed
                                    width: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: variation.attributes.length,
                                      itemBuilder: (context, index) {
                                        final attribute =
                                            variation.attributes[index];
                                        return Text(
                                          ' ${attribute.v.toUpperCase()} ${attribute.u ?? ''}',
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    '${formatCurrency.format(variation.price.sale)}',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '-',
                                    style: TextStyle(
                                      color: Colors.grey.withOpacity(1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '${formatCurrency.format(variation.price.base)}',
                                    style: TextStyle(
                                      color: Colors.grey.withOpacity(1),
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      deCrementQuantity(index);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.redAccent,
                                          width: 0.5,
                                        ),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.redAccent,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.redAccent,
                                        width: 0.5,
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 0.5,
                                      ),
                                      child: Text(
                                        '${widget.quantity.toString()}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      inCrementQuantity(index);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.redAccent,
                                          width: 0.5,
                                        ),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.redAccent,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      deleteProductCart(index);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.redAccent,
                                          width: 0.5,
                                        ),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Spacer(),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }

  // openDiaologAddress() {
  //   return showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       List<AddressModel> addressUser =
  //           Provider.of<UserProvider>(context, listen: false).user.address;
  //       return Column(
  //         children: [
  //           Expanded(
  //             child: ListView.builder(
  //               itemCount: addressUser.length,
  //               itemBuilder: (context, index) {
  //                 return Column(
  //                   children: [
  //                     Container(
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         border: Border(
  //                           bottom: BorderSide(
  //                             color: Colors.grey.withOpacity(0.5),
  //                             width: 1,
  //                           ),
  //                         ),
  //                       ),
  //                       padding: const EdgeInsets.only(top: 10, bottom: 10),
  //                       child: Row(
  //                         children: [
  //                           Radio(
  //                             activeColor: primaryColors,
  //                             value: index,
  //                             groupValue: valueChecked,
  //                             onChanged: (val) {
  //                               setState(
  //                                 () {
  //                                   valueChecked = val!;
  //                                 },
  //                               );
  //                             },
  //                           ),
  //                           Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Padding(
  //                                 padding: const EdgeInsets.only(
  //                                     left: 10.0, bottom: 5),
  //                                 child: Row(
  //                                   children: [
  //                                     Container(
  //                                       constraints: BoxConstraints(
  //                                           maxWidth: MediaQuery.of(context)
  //                                                   .size
  //                                                   .width *
  //                                               0.5),
  //                                       child: Text(
  //                                         addressUser[index].customerName,
  //                                         style: const TextStyle(
  //                                             fontSize: 16,
  //                                             fontWeight: FontWeight.w500),
  //                                         maxLines: 1,
  //                                         overflow: TextOverflow.ellipsis,
  //                                       ),
  //                                     ),
  //                                     const SizedBox(width: 15),
  //                                     const SizedBox(
  //                                       height: 18,
  //                                       child: VerticalDivider(
  //                                         color: Colors.black,
  //                                         thickness: 1,
  //                                       ),
  //                                     ),
  //                                     SizedBox(
  //                                       width:
  //                                           MediaQuery.of(context).size.width *
  //                                               0.3,
  //                                       child: Text(
  //                                         addressUser[index].phoneNumbers,
  //                                         style: const TextStyle(
  //                                           color: Colors.grey,
  //                                           fontSize: 16,
  //                                           fontWeight: FontWeight.w500,
  //                                         ),
  //                                       ),
  //                                     )
  //                                   ],
  //                                 ),
  //                               ),
  //                               Row(
  //                                 mainAxisAlignment: MainAxisAlignment.start,
  //                                 children: [
  //                                   Padding(
  //                                     padding: const EdgeInsets.only(
  //                                         left: 10.0, top: 5),
  //                                     child: Text(
  //                                       addressUser[index].detail,
  //                                       style: const TextStyle(
  //                                         color: Colors.grey,
  //                                         fontSize: 14,
  //                                         fontWeight: FontWeight.w500,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(10.0),
  //                                 child: Text(
  //                                   '${addressUser[index].wardLevel.wardName}, ',
  //                                   style: const TextStyle(
  //                                     color: Colors.grey,
  //                                     fontSize: 14,
  //                                     fontWeight: FontWeight.w500,
  //                                   ),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.only(left: 10.0),
  //                                 child: Row(
  //                                   children: [
  //                                     Text(
  //                                       '${addressUser[index].districtLevel.district_name}, ',
  //                                       style: const TextStyle(
  //                                         color: Colors.grey,
  //                                         fontSize: 14,
  //                                         fontWeight: FontWeight.w500,
  //                                       ),
  //                                     ),
  //                                     Text(
  //                                       addressUser[index]
  //                                           .provinceLevel
  //                                           .province_name,
  //                                       style: const TextStyle(
  //                                         color: Colors.grey,
  //                                         fontSize: 14,
  //                                         fontWeight: FontWeight.w500,
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                               const SizedBox(height: 5),
  //                             ],
  //                           ),
  //                           const Spacer(),
  //                           TextButton(
  //                             onPressed: () {
  //                               Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                   builder: ((context) => ChangeAddress(
  //                                         addressUser: addressUser[index],
  //                                         index: index,
  //                                       )),
  //                                 ),
  //                               );
  //                             },
  //                             child: const Text(
  //                               'Sửa',
  //                               style: TextStyle(
  //                                 fontSize: 18,
  //                                 fontWeight: FontWeight.w700,
  //                                 color: primaryColors,
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 );
  //               },
  //             ),
  //           ),
  //           InkWell(
  //             onTap: () {
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => AddAddressTap()));
  //             },
  //             child: Container(
  //               padding: const EdgeInsets.only(top: 20, bottom: 20),
  //               decoration: const BoxDecoration(
  //                 color: Colors.white,
  //               ),
  //               child: const Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Icon(
  //                     CupertinoIcons.add_circled,
  //                     size: 30,
  //                     color: primaryColors,
  //                   ),
  //                   SizedBox(width: 10),
  //                   Text(
  //                     'Thêm Địa Chỉ Mới',
  //                     style: TextStyle(
  //                       color: primaryColors,
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: ButtonSendrequest(
  //               text: "Xác nhận",
  //               submit: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => ConfirmOrder(
  //                       totalOrder: getCartTotal(),
  //                       totalQuantity: getquantity(),
  //                       image: imageList,
  //                       price: price,
  //                       title: productTitle,
  //                       indexAddress: valueChecked,
  //                       product: productCart.product,
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
