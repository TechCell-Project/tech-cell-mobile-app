import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final List<String> _imgList = [
    'assets/images/carousel_img/img1.png',
    'assets/images/carousel_img/img2.jpg',
    'assets/images/carousel_img/img3.png',
    'assets/images/carousel_img/img4.jpg',
  ];

  late int _current;

  @override
  void initState() {
    _current = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBanner(),
        _buildIndicator(),
      ],
    );
  }

  _buildBanner() => Container(
        height: 213,
        width: double.infinity,
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
                  margin: EdgeInsets.only(top: 83),
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

  _buildIndicator() => Positioned(
        bottom: 10,
        left: 0,
        right: 0,
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
                  border: Border.all(color: Colors.white),
                  shape:
                      _current == index ? BoxShape.circle : BoxShape.rectangle,
                  color: Colors.transparent,
                ),
              );
            },
          ).toList(),
        ),
      );
}
