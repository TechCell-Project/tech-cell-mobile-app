// ignore_for_file: unused_field

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/Tabs/login_tap.dart';
import 'package:my_app/Providers/token_manager.dart';
import 'package:my_app/Widgets/HomeScreen/product_hot_sale.dart';
import 'package:my_app/Widgets/HomeScreen/title_with_more_btn.dart';
import 'package:my_app/Widgets/ProductDetail/buy_now.dart';
import 'package:my_app/Widgets/ProductDetail/header_product.dart';
import 'package:my_app/Widgets/ProductDetail/add_to_store.dart';
import 'package:my_app/models/product_model.dart';
import 'package:my_app/models/user_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ProductDetail extends StatefulWidget {
  final ProductModel productDetail;
  const ProductDetail({super.key, required this.productDetail});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final ScrollController scrollController = ScrollController();
  final CarouselController _carouselController = CarouselController();
  late PageController _pageController;

  bool showMoreInfo = false;
  bool showMoreDescrip = false;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _current;
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          _buildSliderImgProduct(),
                          _buildAnimateToSlider(),
                          _buildInforProduct(),
                        ],
                      ),
                    ),
                    _builPurchaseSuggestions(),
                  ],
                ),
              ),
              HeaderProductDetail(scrollController),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottom(),
    );
  }

  Widget _buildSliderImgProduct() {
    return Container(
      height: 250,
      margin: EdgeInsets.only(top: 65),
      child: CarouselSlider.builder(
        carouselController: _carouselController,
        options: CarouselOptions(
          aspectRatio: 1.873,
          viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
        itemCount: widget.productDetail.generalImages.length,
        itemBuilder: (BuildContext context, int index, int pageViewIndex) {
          var image;
          try {
            final generalImages = widget.productDetail.generalImages[index];
            image = Container(
              child: Image(
                image: NetworkImage('${generalImages.url}'),
                fit: BoxFit.cover,
              ),
            );
          } catch (e) {
            image = Container(
              margin: EdgeInsets.only(top: 25),
              child: Image.asset(
                "assets/images/no_image.jpg",
                fit: BoxFit.cover,
              ),
            );
          }
          return Container(
            child: image,
          );
        },
      ),
    );
  }

  Widget _buildAnimateToSlider() {
    return Container(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.productDetail.generalImages.length,
        itemBuilder: (context, index) {
          final generalImages = widget.productDetail.generalImages[index];
          return Container(
            width: 110,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              border: Border.all(
                  color: _current == index ? primaryColors : Colors.black26),
              borderRadius: BorderRadius.circular(5),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _current = index;
                });
                _carouselController.animateToPage(index,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
              },
              child: Image(
                image: NetworkImage('${generalImages.url}'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInforProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          '${widget.productDetail.name}',
          maxLines: 2,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w900,
            fontSize: 25,
          ),
        ),
        SizedBox(height: 10),
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.productDetail.variations.length,
            itemBuilder: (context, index) {
              final variation = widget.productDetail.variations[index];
              if (index == 0) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${formatCurrency.format(variation.price.special)}',
                          style: TextStyle(
                            color: primaryColors,
                            fontWeight: FontWeight.w500,
                            fontSize: 28,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${formatCurrency.format(variation.price.base)}',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(
                              '4.9/5',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 5),
                        Text(
                          '|',
                          style: TextStyle(
                            color: Colors.grey.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Đã bán' + ' ' + '${variation.stock}' + '+',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.workspace_premium,
                              color: Colors.amber,
                            ),
                            Text(
                              'Hàng chính hãng - Bảo hành 12 Tháng',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.local_shipping,
                              color: Colors.amber,
                            ),
                            Text(
                              'Giao hàng toàn quốc',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
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
        SizedBox(height: 15),
        Container(
          width: 400,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 400,
                color: Color.fromARGB(255, 210, 210, 210),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    'ƯU ĐÃI THÊM',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  '- Giảm thêm tới 1% cho thành viên Smember (áp dụng tùy sản phẩm)',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  '- Giảm thêm tới 1% cho thành viên Smember (áp dụng tùy sản phẩm)',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  '- Giảm thêm tới 1% cho thành viên Smember (áp dụng tùy sản phẩm)',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Thông số kỹ thuật',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: showMoreInfo ? null : 190,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.productDetail.generalAttributes.length,
                  itemBuilder: (context, index) {
                    final generalAttributes =
                        widget.productDetail.generalAttributes[index];
                    return Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      border: TableBorder.all(width: 1, color: Colors.black26),
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                '${generalAttributes.name}'.capitalize(),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                '${generalAttributes.v}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showMoreInfo = !showMoreInfo;
                      });
                    },
                    child: Text(
                      showMoreInfo ? 'Ẩn bớt' : 'Xem cấu hình chi tiết',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                child: Text(
                  'Đặc điểm chi tiết, nổi bật:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: showMoreDescrip ? null : 220,
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: HtmlWidget('${widget.productDetail.description}'),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showMoreDescrip = !showMoreDescrip;
                      });
                    },
                    child: Text(
                      showMoreDescrip ? 'Ẩn bớt' : 'Xem thêm',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _builPurchaseSuggestions() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            child: TitleWithMoreBtn(text: 'Sản phẩm nổi bật:'),
          ),
          ProductHotSale(),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return Container(
      height: 90,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => FutureBuilder<User?>(
                    future: TokenManager.getUserfromStorage(),
                    builder: (context, snapshoot) {
                      if (snapshoot.data == null) {
                        return LoginTap();
                      } else {
                        return AddToStore(
                          productId: widget.productDetail.id,
                          variations: widget.productDetail.variations,
                        );
                      }
                    },
                  ),

                  //  Provider.of<UserProvider>(context)
                  //         .user
                  //         .accessToken
                  //         .isEmpty
                  //     ? LoginTap()
                  //     : AddToStore(
                  //         productId: widget.productDetail.id,
                  //         variations: widget.productDetail.variations,
                  //       ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(
                  width: 0.5,
                  color: primaryColors,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: primaryColors,
                    ),
                    Text(
                      "Thêm vào giỏ hàng",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryColors,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => BuyNow(
                    variations: widget.productDetail.variations,
                    id: widget.productDetail.id,
                    handleSelectVariation: {},
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColors,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 55, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Mua ngay",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
