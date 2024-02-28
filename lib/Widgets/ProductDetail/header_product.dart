import 'package:flutter/material.dart';
import 'package:my_app/Pages/Screens/cart_screen.dart';
import 'package:badges/badges.dart' as badges;

class HeaderProductDetail extends StatefulWidget {
  HeaderProductDetail(this.scrollController);
  final TrackingScrollController scrollController;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<HeaderProductDetail> {
  late Color _backgroundColor;
  late Color _colorIcon;
  late double _opacity;
  late double _offset;

  final _opacityMax = 0.01;

  @override
  void initState() {
    _backgroundColor = Colors.transparent;
    _colorIcon = Colors.white;
    _opacity = 0.0;
    _offset = 0.0;
    widget.scrollController.addListener(_onScroll);
    super.initState();
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
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildIconback(),
                    _buildCartButton(),
                  ],
                ),
              ),
            ),
          );
  }

  _buildIconback() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 179, 179, 179),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }

  _buildCartButton() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 179, 179, 179),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartScreen()));
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: badges.Badge(
            badgeContent: Text('0', style: TextStyle(color: Colors.white)),
            child: Icon(Icons.shopping_cart, color: _colorIcon, size: 28),
          ),
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
        _colorIcon = Colors.white;
        _offset = 0.0;
        _opacity = 0.0;
      } else {
        _colorIcon = Colors.white;
      }

      _backgroundColor = Colors.transparent;
    });
  }
}
