// ignore_for_file: unused_field

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/Tabs/login_tap.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/Widgets/ProductDetail/buy_now.dart';
import 'package:my_app/Widgets/ProductDetail/header_product.dart';
import 'package:my_app/Widgets/ProductDetail/add_to_store.dart';
import 'package:my_app/models/product_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart' as htmlParser;

class ProductDetail extends StatefulWidget {
  final ProductModel producdetail;
  const ProductDetail({super.key, required this.producdetail});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final TrackingScrollController _scrollController = TrackingScrollController();
  final CarouselController _controller = CarouselController();

  late int _current;
  bool showMoreInfo = false;

  String parseHtmlToPlainText(String htmlString) {
    var document = htmlParser.parse(htmlString);
    String parsedString =
        htmlParser.parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  @override
  void initState() {
    _current = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    children: [
                      _sliderImgProduct(),
                      _buildAnimateToSlider(),
                      _informationProduct(),
                    ],
                  ),
                ),
              ),
              HeaderProductDetail(_scrollController),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottom(),
    );
  }

  _sliderImgProduct() {
    return Container(
      height: 250,
      child: CarouselSlider.builder(
        carouselController: _controller,
        options: CarouselOptions(
          aspectRatio: 1.873,
          viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
        itemCount: widget.producdetail.generalImages.length,
        itemBuilder: (BuildContext context, int index, int pageViewIndex) {
          var image;
          try {
            final generalImages = widget.producdetail.generalImages[index];
            image = Container(
              margin: EdgeInsets.only(top: 25),
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

  _buildAnimateToSlider() {
    return Container(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.producdetail.generalImages.length,
        itemBuilder: (context, index) {
          final generalImages = widget.producdetail.generalImages[index];
          return Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 2),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(
                  color: _current == index ? Colors.redAccent : Colors.black26),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _current == _controller.animateToPage(index);
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
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

  _informationProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          '${widget.producdetail.name}',
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
            physics: BouncingScrollPhysics(),
            itemCount: widget.producdetail.variations.length,
            itemBuilder: (context, index) {
              final variation = widget.producdetail.variations[index];
              if (index == 0) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${formatCurrency.format(variation.price.special)}',
                          style: TextStyle(
                            color: Colors.red,
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
                  ],
                );
              }
              return Container();
            },
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
                  itemCount: widget.producdetail.generalAttributes.length,
                  itemBuilder: (context, index) {
                    final generalAttributes =
                        widget.producdetail.generalAttributes[index];
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
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Đặc điểm chi tiết, nổi bật',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '${parseHtmlToPlainText(widget.producdetail.description)}',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildBottom() {
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
                  builder: (context) => Provider.of<UserProvider>(context)
                          .user
                          .accessToken
                          .isEmpty
                      ? LoginTap()
                      : AddToStore(
                          productId: widget.producdetail.id,
                          variations: widget.producdetail.variations,
                        ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(
                  width: 1,
                  color: Colors.red.withOpacity(0.5),
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
                    variations: widget.producdetail.variations,
                    id: widget.producdetail.id,
                    handleSelectVariation: {},
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
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
