import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/API/api_cart.dart';
import 'package:my_app/Pages/Tabs/add_address._tap.dart';
import 'package:my_app/Pages/Tabs/change_address.dart';
import 'package:my_app/Pages/Tabs/confirm_order.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/models/address_model.dart';
import 'package:my_app/models/cart_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:provider/provider.dart';

class CartTap extends StatefulWidget {
  const CartTap({super.key});

  @override
  State<CartTap> createState() => _CartTapState();
}

class _CartTapState extends State<CartTap> {
  CartModel productCart = CartModel(
    id: '',
    userId: '',
    cartCountProduct: 0,
    product: [],
    cartState: '',
  );
  List<Product> product = [];
  bool checked = true;
  int valueChecked = 0;
  List<String> imageList = [
    'assets/images/galaxy-z-fold-5-xanh-1.png',
    'assets/images/galaxys23ultra_front_green_221122_2.png',
    'assets/images/samsung_galaxy_z_flip_m_i_2022-1_1.png',
    'assets/images/sm-s908_galaxys22ultra_front_phantomblack_211119_2.png',
  ];
  List<String> productTitle = [
    'Samsung 1Galaxy Z Flip 5',
    'Samsung 2Galaxy Z Fold 5',
    'Samsung 3Galaxy S23 Ultra',
    'Samsung 4Galaxy Z Flip 4',
  ];
  List<int> price = [
    19990000,
    34990000,
    23590000,
    14990000,
  ];
  @override
  void initState() {
    super.initState();
    CartApi().getCart(context).then((data) {
      setState(() {
        productCart = data;
      });
    });
  }

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
  }

  int getquantity() {
    int totalQuantity = 0;
    for (int i = 0; i < productCart.product.length; i++) {
      totalQuantity += productCart.product[i].quantity;
    }
    return totalQuantity;
  }

  double getCartTotal() {
    double total = 0;
    for (int i = 0; i < productCart.product.length; i++) {
      total += productCart.product[i].quantity * price[i];
    }
    return total;
  }

  openDiaologAddress() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          List<AddressModel> addressUser =
              Provider.of<UserProvider>(context, listen: false).user.address;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: addressUser.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Radio(
                                activeColor: primaryColors,
                                value: index,
                                groupValue: valueChecked,
                                onChanged: (val) {
                                  setState(
                                    () {
                                      valueChecked = val!;
                                    },
                                  );
                                },
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, bottom: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5),
                                          child: Text(
                                            addressUser[index].customerName,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        const SizedBox(
                                          height: 18,
                                          child: VerticalDivider(
                                            color: Colors.black,
                                            thickness: 1,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Text(
                                            addressUser[index].phoneNumbers,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 5),
                                        child: Text(
                                          addressUser[index].detail,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${addressUser[index].wardLevel.wardName}, ',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${addressUser[index].districtLevel.district_name}, ',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          addressUser[index]
                                              .provinceLevel
                                              .province_name,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                ],
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => ChangeAddress(
                                            addressUser: addressUser[index],
                                            index: index,
                                          )),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sửa',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: primaryColors,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddAddressTap()));
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.add_circled,
                        size: 30,
                        color: primaryColors,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Thêm Địa Chỉ Mới',
                        style: TextStyle(
                          color: primaryColors,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonSendrequest(
                    text: "Xác nhận",
                    submit: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmOrder(
                                    totalOrder: getCartTotal(),
                                    totalQuantity: getquantity(),
                                    image: imageList,
                                    price: price,
                                    title: productTitle,
                                    indexAddress: valueChecked,
                                    product: productCart.product,
                                  )));
                    }),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColors,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFEDECF2)),
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: productCart.product.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(productCart.product[index].productId),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        product.removeAt(index);
                      });
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16.0),
                      child: const Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                    ),
                    child: Container(
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Checkbox(
                            value: checked,
                            onChanged: (val) {
                              setState(() {
                                checked = !checked;
                              });
                            },
                          ),
                          Container(
                            height: 70,
                            width: 70,
                            margin: const EdgeInsets.only(right: 15),
                            child: Image.asset(
                              'assets/images/galaxy-z-fold-5-xanh-1.png',
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    productCart.product[index].sku,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${price[index]} VND',
                                  style: const TextStyle(
                                      color: primaryColors,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  deCrementQuantity(index);
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 10,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      size: 15,
                                    )),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  productCart.product[index].quantity
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  inCrementQuantity(index);
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 10,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 15,
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: const EdgeInsets.all(15),
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
                  const Text(
                    'Tổng giá',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    " ${getCartTotal().toString()} VND",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: ButtonSendrequest(
                  text: 'Thanh toan',
                  submit: openDiaologAddress,
                ))
          ],
        ),
      ),
    );
  }
}
