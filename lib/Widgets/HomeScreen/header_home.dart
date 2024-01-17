import 'package:flutter/material.dart';
import 'package:my_app/Pages/Screens/cart_screen.dart';
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
  late Color _backgroundColorSearch;
  late Color _colorIcon;
  late double _opacity;
  late double _offset;

  final _opacityMax = 0.01;

  @override
  void initState() {
    _backgroundColor = primaryColors.withOpacity(0.1);
    _backgroundColorSearch = Colors.white;
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildSearch(),
                    SizedBox(width: 15),
                    _buildCartButton(),
                  ],
                ),
              ),
            ),
          );
  }

  _buildSearch() {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 0),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );

    final sizeIcon = BoxConstraints(minWidth: 40, minHeight: 40);

    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(4),
          focusedBorder: border,
          enabledBorder: border,
          isDense: true,
          hintText: "Tìm kiếm...",
          hintStyle: TextStyle(fontSize: 18, color: primaryColors),
          prefixIcon: Icon(Icons.search),
          prefixIconConstraints: sizeIcon,
          filled: true,
          fillColor: _backgroundColorSearch,
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
          child: Icon(Icons.shopping_cart, color: _colorIcon, size: 35),
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
        _backgroundColorSearch = Colors.white;
        _colorIcon = Colors.white;
        _offset = 0.0;
        _opacity = 0.0;
      } else {
        _backgroundColorSearch = Colors.grey.shade200;
        _colorIcon = primaryColors;
      }

      _backgroundColor = primaryColors.withOpacity(0.1);
    });
  }
}
