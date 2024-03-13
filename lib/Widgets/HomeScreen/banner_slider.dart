import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _current = 0;
  final List<String> _imgList = [
    'assets/images/carousel_img/img1.png',
    'assets/images/carousel_img/img2.jpg',
    'assets/images/carousel_img/img3.png',
    'assets/images/carousel_img/img4.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _current;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSlider(),
        _buildDotTransfer(),
        _buildBanner(),
      ],
    );
  }

  Widget _buildSlider() {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 1.873,
          viewportFraction: 1.0,
          autoPlay: true,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
        items: _imgList
            .map(
              (item) => Container(
                margin: EdgeInsets.only(top: 92),
                child: Image.asset(
                  item,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildDotTransfer() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _imgList.map(
          (url) {
            int index = _imgList.indexOf(url);
            return Container(
              width: 8,
              height: _current == index ? 8 : 1,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                shape: _current == index ? BoxShape.circle : BoxShape.rectangle,
                color: Colors.grey,
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      child: Row(
        children: [
          Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/banner/banner_1.jpg',
                height: 305,
                width: 205,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 110,
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'APPLE',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Đặc quyền sinh viên giảm thêm 5% tối đa 300k',
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 5),
          Column(
            children: [
              Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/images/banner/banner_2.jpg',
                    height: 150,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 30,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SAMSUNG',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Tưng bừng lễ hội nhập hội galaxy tab series',
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/images/banner/banner_3.jpg',
                    height: 150,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 30,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SẢN PHẨM, PHỤ KIỆN',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Mua ngay, săn deal hời với Techcell',
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
