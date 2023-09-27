import 'package:flutter/material.dart';
import 'package:my_app/utils/constant.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});
  @override
  State<SearchTextField> createState() => _SearchTextField();
}

class _SearchTextField extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.1,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.15 - 60,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 248, 119, 110),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 30,
                    color: primaryColors,
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm',
                  hintStyle: TextStyle(
                    color: primaryColors.withOpacity(0.5),
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: primaryColors.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
