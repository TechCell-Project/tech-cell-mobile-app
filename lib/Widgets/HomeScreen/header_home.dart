import 'package:flutter/material.dart';
import 'package:my_app/Pages/Screens/cart_screen.dart';
import 'package:my_app/Pages/Tabs/search_product.dart';
import 'package:my_app/utils/constant.dart';
import 'package:badges/badges.dart' as badges;

class HeaderHome extends StatefulWidget {
  HeaderHome(this.scrollController);
  final TrackingScrollController scrollController;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<HeaderHome> {
  late Color _backgroundColor;
  // late Color _backgroundColorSearch;
  late Color _colorIcon;
  late double _opacity;
  late double _offset;

  final _opacityMax = 0.01;

  @override
  void initState() {
    super.initState();
    _backgroundColor = primaryColors.withOpacity(0.1);
    // _backgroundColorSearch = Colors.white;
    _colorIcon = Colors.black;
    _opacity = 0.0;
    _offset = 0.0;
    widget.scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return widget.scrollController.offset <= -50
        ? SizedBox()
        : Container(
            color: _backgroundColor,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildSearch(),
                    _buildCartButton(),
                  ],
                ),
              ),
            ),
          );
  }

  _buildSearch() {
    return InkWell(
      onTap: () {
        showSearch(context: context, delegate: SearchProduct());
      },
      child: Container(
        height: 40,
        width: 310,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Icon(Icons.search, color: Colors.black),
            ),
            Text(
              'Tìm kiếm...',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildCartButton() {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartScreen()));
        },
        child: badges.Badge(
          badgeContent: Text('0', style: TextStyle(color: Colors.white)),
          child: Icon(Icons.shopping_cart, color: _colorIcon, size: 40),
        ),
      ),
    );
  }

  _onScroll() {
    final scrollOffset = widget.scrollController.offset;
    if (scrollOffset >= _offset && scrollOffset > 5) {
      _opacity = double.parse((_opacity + _opacityMax).toStringAsFixed(2));
      if (_opacity >= 1.0) {
        _opacity = 1.0;
      }
      _offset = scrollOffset;
    } else if (scrollOffset < 100) {
      _opacity = double.parse((_opacity - _opacityMax).toStringAsFixed(2));
      if (_opacity <= 0.0) {
        _opacity = 0.0;
      }
    }

    setState(() {
      if (scrollOffset <= 0) {
        // _backgroundColorSearch = Colors.white;
        _colorIcon = Colors.black;
        _offset = 0.0;
        _opacity = 0.0;
      } else {
        // _backgroundColorSearch = Colors.grey.shade200;
        _colorIcon = primaryColors;
      }

      _backgroundColor = primaryColors.withOpacity(0.1);
    });
  }
}
