// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:my_app/API/api_order.dart';
import 'package:my_app/Pages/Tabs/order_detail.dart';
import 'package:my_app/Providers/product_provider.dart';
import 'package:my_app/models/cart_model.dart';
import 'package:my_app/models/order_model.dart';
import 'package:my_app/models/product_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:provider/provider.dart';

class OrderUserTap extends StatefulWidget {
  const OrderUserTap({super.key});

  @override
  State<OrderUserTap> createState() => _OrderUserTapState();
}

class _OrderUserTapState extends State<OrderUserTap>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ScrollController _scrollController = ScrollController();
  OrderResponse orderUser = OrderResponse(
    data: [],
    page: 1,
    pageSize: 1,
    totalPage: 1,
    totalRecord: 1,
  );
  CartModel productCart = CartModel(
    id: '',
    userId: '',
    cartCountProduct: 0,
    product: [],
    cartState: '',
  );
  Map<String, OrderResponse> orderData = {
    'pending': OrderResponse(
        page: 1, pageSize: 5, totalPage: 11, totalRecord: 11, data: []),
    'cancelled': OrderResponse(
        page: 1, pageSize: 5, totalPage: 11, totalRecord: 11, data: []),
    'processing': OrderResponse(
        page: 1, pageSize: 5, totalPage: 11, totalRecord: 11, data: []),
    'shipping': OrderResponse(
        page: 1, pageSize: 5, totalPage: 11, totalRecord: 11, data: []),
    'completed': OrderResponse(
        page: 1, pageSize: 5, totalPage: 11, totalRecord: 11, data: []),
  };
  Future<void> fetchDataForOrders() async {
    for (var entry in orderData.entries) {
      try {
        OrderResponse orders =
            await OrderApi().getOrderUser(context, entry.key);

        setState(() {
          orderData[entry.key] = orders;
        });
      } catch (e) {
        print('Error fetching data for ${entry.key}: $e');
      }
    }
  }

  int getTotalQuantity(int index) {
    if (orderUser.data.isEmpty) {
      return 1;
    }
    int total = orderData[index]!.data[index].product.length;
    // int total = orderUser.data[index].product.length;

    return total;
  }

  int getTotalOrder() {
    int total = orderData.length;
    // int total = orderUser.data.length;
    return total;
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 5, initialIndex: 0, vsync: this);
    _tabController.addListener(_handleTabSelection);
    fetchDataForOrders();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Đơn hàng của bạn',
            style: TextStyle(color: Colors.black),
          ),
          foregroundColor: primaryColors,
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: _tabController,
            labelColor: primaryColors,
            unselectedLabelColor: Colors.black.withOpacity(0.5),
            isScrollable: true,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 3, color: primaryColors),
            ),
            labelPadding: EdgeInsets.symmetric(horizontal: 20),
            tabs: [
              Tab(text: 'Chờ xác nhận'),
              Tab(text: 'Chờ lấy hàng'),
              Tab(text: 'Chờ giao hàng'),
              Tab(text: 'Đã giao'),
              Tab(text: 'Đã hủy'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            buildOrderWidget(orderData['pending']),
            buildOrderWidget(orderData['processing']),
            buildOrderWidget(orderData['shipping']),
            buildOrderWidget(orderData['completed']),
            buildOrderWidget(orderData['cancelled']),
          ],
        ),
      ),
    );
  }

  Widget buildOrderWidget(OrderResponse? orders) {
    List<ProductModel> productProvider =
        Provider.of<ProductProvider>(context, listen: false).products;
    if (orders == null || orders.data.isEmpty) {
      return Center(child: Text('No orders found'));
    } else {
      return SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 231, 231, 231),
          child: Column(
            children: [
              ListView.builder(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: orders.data.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderDetail(
                                      orderUser: orders.data[index])));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.store),
                                      Text('Techcell'),
                                    ],
                                  ),
                                  const Spacer(),
                                  getOrderStatus(
                                      orders.data[index].oderStatus,
                                      _getStatusText(
                                          orders.data[index].oderStatus)),
                                ],
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: orders.data[index].product.length =
                                    1,
                                itemBuilder: (context, indexFirst) {
                                  final itemCart =
                                      orders.data[index].product[indexFirst];
                                  return Container(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: productProvider.length,
                                      itemBuilder: (context, indexSecond) {
                                        final itemProduct =
                                            productProvider[indexSecond];
                                        if (itemCart.productId ==
                                            itemProduct.id) {
                                          return Container(
                                            width: 400,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: itemProduct
                                                        .variations.length,
                                                    itemBuilder:
                                                        (context, indexThird) {
                                                      final variation =
                                                          itemProduct
                                                                  .variations[
                                                              indexThird];

                                                      if (itemCart.sku ==
                                                          variation.sku) {
                                                        return Row(
                                                          children: [
                                                            Container(
                                                              height: 120,
                                                              width: 120,
                                                              child: ListView
                                                                  .builder(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                itemCount:
                                                                    variation
                                                                        .images
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  final image =
                                                                      variation
                                                                              .images[
                                                                          index];
                                                                  if (image
                                                                          .isThumbnail ==
                                                                      true) {
                                                                    return Image(
                                                                      image: NetworkImage(
                                                                          '${image.url}'),
                                                                    );
                                                                  } else if (index ==
                                                                      0) {
                                                                    return Image(
                                                                      image: NetworkImage(
                                                                          '${image.url}'),
                                                                    );
                                                                  }
                                                                  return Container();
                                                                },
                                                              ),
                                                            ),

                                                            // SizedBox(width: 10),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: 200,
                                                                  child: Text(
                                                                    '${itemProduct.name}',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 2,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        'Phân loại:'),
                                                                    Container(
                                                                      height:
                                                                          15, // Adjust the height as needed
                                                                      width:
                                                                          150,
                                                                      child: ListView
                                                                          .builder(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        itemCount: variation
                                                                            .attributes
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          final attribute =
                                                                              variation.attributes[index];
                                                                          return Text(
                                                                            ' ${attribute.v.toUpperCase()}${attribute.u ?? ''}',
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                if (variation
                                                                            .price
                                                                            .sale !=
                                                                        variation
                                                                            .price
                                                                            .base &&
                                                                    variation
                                                                            .price
                                                                            .sale !=
                                                                        0)
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        '${formatCurrency.format(variation.price.sale)}',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.red,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              5),
                                                                      Text(
                                                                        '-',
                                                                        style:
                                                                            TextStyle(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(1),
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              5),
                                                                      Text(
                                                                        '${formatCurrency.format(variation.price.base)}',
                                                                        style:
                                                                            TextStyle(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(1),
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          decoration:
                                                                              TextDecoration.lineThrough,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                else if (variation
                                                                        .price
                                                                        .special !=
                                                                    0)
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        '${formatCurrency.format(variation.price.special)}',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.red,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              5),
                                                                      Text(
                                                                        '-',
                                                                        style:
                                                                            TextStyle(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(1),
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              5),
                                                                      Text(
                                                                        '${formatCurrency.format(variation.price.base)}',
                                                                        style:
                                                                            TextStyle(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(1),
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          decoration:
                                                                              TextDecoration.lineThrough,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                else
                                                                  Text(
                                                                    '${formatCurrency.format(variation.price.base)}',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                  'Số lượng: ${itemCart.quantity.toString()}',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
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
                                          );
                                        }
                                        return Container();
                                      },
                                    ),
                                  );
                                },
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${orders.data[index].product.length.toString()} sản phẩm",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const Spacer(),
                                  const Image(
                                    image: AssetImage(
                                      'assets/logos/favicon.ico',
                                    ),
                                    width: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text("Thành tiền: "),
                                  Text(
                                    ' ${formatCurrency.format(orders.data[index].checkoutOrder.totalPrice)}',
                                    style: const TextStyle(
                                        color: primaryColors, fontSize: 16),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                  );
                }),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget styleOrderStatus(Color color, String text) {
    return Row(
      children: [
        Icon(Icons.local_shipping_outlined, color: color),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(fontSize: 15, color: color),
        ),
      ],
    );
  }

  Widget getOrderStatus(String status, String text) {
    Color statusColor;
    switch (status) {
      case 'pending':
        statusColor = Colors.yellow[800] ?? Colors.transparent;
        break;
      case 'completed':
        statusColor = Colors.green;
        break;
      case 'cancelled':
        statusColor = Colors.red;
      default:
        statusColor = Colors.transparent;
        break;
    }
    return Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            styleOrderStatus(statusColor, _getStatusText(status)),
          ],
        ));
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Đang chờ xác nhận';
      case 'completed':
        return 'Đã hoàn thành';
      case 'cancelled':
        return 'Đơn hàng đã hủy';
      default:
        return 'Đang chờ xử lý';
    }
  }
}
