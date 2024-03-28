import 'package:flutter/material.dart';
import 'package:my_app/API/api_cart.dart';
import 'package:my_app/API/api_product.dart';
import 'package:my_app/Pages/Tabs/product_detail.dart';
import 'package:my_app/Providers/product_provider.dart';
import 'package:my_app/Widgets/Cart/open_diaolog_address.dart';
import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/models/cart_model.dart';
import 'package:my_app/models/product_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';
import 'package:provider/provider.dart';

class CartTap extends StatefulWidget {
  const CartTap({Key? key}) : super(key: key);

  @override
  State<CartTap> createState() => _CartTapState();
}

class _CartTapState extends State<CartTap> {
  final ScrollController scrollController = ScrollController();

  CartModel productCart = CartModel(
    id: '',
    userId: '',
    cartCountProduct: 0,
    product: [],
    cartState: '',
  );

  List<bool> productSelected = [];
  bool selectAll = false;
  int valueChecked = 0;

  void inCrementQuantity(int index) {
    setState(() {
      productCart.product[index].quantity++;
    });
    CartApi().updateCart(
      context: context,
      productId: productCart.product[index].productId,
      sku: productCart.product[index].sku,
      quantity: productCart.product[index].quantity,
    );
    showSnackBarSuccess(context, 'Thành công');
  }

  void deCrementQuantity(int index) {
    setState(() {
      if (productCart.product[index].quantity > 1) {
        productCart.product[index].quantity--;
      } else {
        return;
      }
    });
    CartApi().updateCart(
      context: context,
      productId: productCart.product[index].productId,
      sku: productCart.product[index].sku,
      quantity: productCart.product[index].quantity,
    );
    showSnackBarSuccess(context, 'Thành công');
  }

  void deleteCart(int index) {
    CartApi().updateCart(
      context: context,
      productId: productCart.product[index].productId,
      sku: productCart.product[index].sku,
      quantity: 0,
    );
    showSnackBarSuccess(context, 'Xóa thành công');
  }

  double getTotalAmount() {
    double total = 0;
    for (var i = 0; i < productCart.product.length; i++) {
      if (productSelected[i]) {
        final itemCart = productCart.product[i];
        final itemProduct = Provider.of<ProductProvider>(context, listen: false)
            .products
            .firstWhere((product) => product.id == itemCart.productId);
        final variation = itemProduct.variations
            .firstWhere((variation) => variation.sku == itemCart.sku);
        total += itemCart.quantity * variation.price.special;
      }
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    CartApi().getCart(context).then((data) {
      setState(() {
        productCart = data;
        productSelected =
            List.generate(productCart.product.length, (index) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Giỏ hàng',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColors,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                productCart.product.isEmpty
                    ? _buildCartEmpty()
                    : _buildProductInCart()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildTotalAmountAndPayment(),
    );
  }

  Widget _buildCartEmpty() {
    return SizedBox(
      height: 100,
      child: Center(
        child: Text(
          'Bạn chưa thêm sản phẩm nào vào giỏ hàng',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildProductInCart() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              SizedBox(
                width: 10,
                child: Checkbox(
                  value: selectAll,
                  activeColor: primaryColors,
                  onChanged: (bool? value) {
                    setState(() {
                      selectAll = value ?? false;
                      for (int i = 0; i < productSelected.length; i++) {
                        productSelected[i] = selectAll;
                      }
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Chọn tất cả',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: productCart.product.length,
            itemBuilder: (context, indexCart) {
              final itemCart = productCart.product[indexCart];
              return FutureBuilder<List<ProductModel>>(
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

                  List<ProductModel>? products = snapshot.data;
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: products?.length,
                      itemBuilder: (context, indexProduct) {
                        final itemProduct = products?[indexProduct];
                        if (itemCart.productId == itemProduct!.id) {
                          return Dismissible(
                            key: Key(itemCart.productId),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              deleteCart(indexCart);
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
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
                              padding: EdgeInsets.symmetric(vertical: 10),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 240, 239, 239),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: SizedBox(
                                      width: 15,
                                      child: Checkbox(
                                        activeColor: primaryColors,
                                        value: productSelected[indexCart],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            productSelected[indexCart] =
                                                value ?? false;
                                            if (!value!) {
                                              selectAll = false;
                                            } else {
                                              selectAll = productSelected.every(
                                                  (isSelected) => isSelected);
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: itemProduct.variations.length,
                                      itemBuilder: (context, indexVariation) {
                                        final variation = itemProduct
                                            .variations[indexVariation];

                                        if (itemCart.sku == variation.sku) {
                                          return Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetail(
                                                              productDetail:
                                                                  itemProduct),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 120,
                                                  width: 120,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        variation.images.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final image = variation
                                                          .images[index];
                                                      if (image.isThumbnail ==
                                                          true) {
                                                        return Image(
                                                          image: NetworkImage(
                                                              '${image.url}'),
                                                        );
                                                      } else if (index == 0) {
                                                        return Image(
                                                          image: NetworkImage(
                                                              '${image.url}'),
                                                        );
                                                      }
                                                      return Container();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 220,
                                                    child: Text(
                                                      '${itemProduct.name}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      Text('Phân loại:'),
                                                      Container(
                                                        height:
                                                            15, // Adjust the height as needed
                                                        width: 150,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: variation
                                                              .attributes
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final attribute =
                                                                variation
                                                                        .attributes[
                                                                    index];
                                                            return Text(
                                                              ' ${attribute.v.toUpperCase()}${attribute.u ?? ''}',
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
                                                        '${formatCurrency.format(variation.price.special)}',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        '-',
                                                        style: TextStyle(
                                                          color: Colors.grey
                                                              .withOpacity(1),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        '${formatCurrency.format(variation.price.base)}',
                                                        style: TextStyle(
                                                          color: Colors.grey
                                                              .withOpacity(1),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          deCrementQuantity(
                                                              indexCart);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: Colors
                                                                  .redAccent,
                                                              width: 0.5,
                                                            ),
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        2),
                                                            child: Icon(
                                                              Icons.remove,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(2),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors
                                                                .redAccent,
                                                            width: 0.5,
                                                          ),
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical:
                                                                      2.5),
                                                          child: Text(
                                                            '${itemCart.quantity.toString()}',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          inCrementQuantity(
                                                              indexCart);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: Colors
                                                                  .redAccent,
                                                              width: 0.5,
                                                            ),
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        2),
                                                            child: Icon(
                                                              Icons.add,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
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
                      },
                    ),
                  );
                },
              );
            

  Widget _buildTotalAmountAndPayment() {
    return SizedBox(
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng tiền:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  '${formatCurrency.format(getTotalAmount())} VND',
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
            padding: EdgeInsets.all(15),
            child: productSelected == true
                ? ButtonSendrequest(
                    text: 'Mua hàng',
                    submit: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => OpenDialogAddreess(
                          productSelected: productSelected,
                          productCart: productCart.product,
                        ),
                      );
                    },
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {},
                    child: Text('Mua hang')),
          )

        ],
      ),
    );
  }
}
