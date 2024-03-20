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
          title: Text(
            "Đơn hàng",
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
          bottom: TabBar(
            controller: _tabController,
            labelColor: primaryColors,
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 16),
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
          color: Color.fromARGB(255, 240, 239, 239),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: orders.data.length,
                itemBuilder: (context, index) {
                  final order = orders.data[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetail(orderDetail: order),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                      'assets/logos/favicon.ico',
                                    ),
                                    width: 20,
                                  ),
                                  SizedBox(width: 2),
                                  Text('Techcell'),
                                ],
                              ),
                              Spacer(),
                              getOrderStatus(order.oderStatus,
                                  _getStatusText(order.oderStatus)),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: order.product.length,
                              itemBuilder: (context, indexOrder) {
                                final orderProduct = order.product[indexOrder];
                                if (indexOrder == 0) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: productProvider.length,
                                    itemBuilder: (context, indexProduct) {
                                      final itemProduct =
                                          productProvider[indexProduct];
                                      if (orderProduct.productId ==
                                          itemProduct.id) {
                                        return Container(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                itemProduct.variations.length,
                                            itemBuilder:
                                                (context, indexVariation) {
                                              final variation = itemProduct
                                                  .variations[indexVariation];
                                              if (orderProduct.sku ==
                                                  variation.sku) {
                                                return Row(
                                                  children: [
                                                    Container(
                                                      height: 120,
                                                      width: 120,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: variation
                                                            .images.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final image =
                                                              variation.images[
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
                                                    SizedBox(width: 5),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 250,
                                                          child: Text(
                                                            '${itemProduct.name}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
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
                                                              child: ListView
                                                                  .builder(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                itemCount:
                                                                    variation
                                                                        .attributes
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
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
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              '-',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              '${formatCurrency.format(variation.price.base)}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }
                                              return Container();
                                            },
                                          ),
                                        );
                                      }
                                      return Container();
                                    },
                                  );
                                }
                                return Container();
                              },
                            ),
                          ),
                          Divider(thickness: 1),
                          Row(
                            children: [
                              Text(
                                "${order.product.length.toString()} sản phẩm",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Spacer(),
                              SizedBox(width: 5),
                              Text('Thành tiền: '),
                              Text(
                                '${formatCurrency.format(orders.data[index].checkoutOrder.totalPrice)}',
                                style: TextStyle(
                                  color: primaryColors,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
        SizedBox(width: 5),
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
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          styleOrderStatus(statusColor, _getStatusText(status)),
        ],
      ),
    );
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
