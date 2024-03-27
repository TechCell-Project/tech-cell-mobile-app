// ignore_for_file: unused_element, null_check_always_fails

import 'package:flutter/material.dart';
import 'package:my_app/API/api_cart.dart';
import 'package:my_app/Pages/Screens/cart_screen.dart';
import 'package:my_app/models/product_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';

class AddToStore extends StatefulWidget {
  final productId;
  final List<Variation> variations;
  const AddToStore({required this.variations, required this.productId});

  @override
  State<AddToStore> createState() => _AddToStoreState();
}

class _AddToStoreState extends State<AddToStore> {
  Map<String, Attributes> selectedAttributes = {};
  String? selectedSku;

  @override
  void initState() {
    super.initState();
    selectedAttributes = {};
    _selectFirstAttribute();
    selectedSku = widget.variations[0].sku;
  }

  void _selectFirstAttribute() {
    final firstAttribute = widget.variations.first.attributes.first;
    setState(() {
      selectedAttributes = {firstAttribute.k: firstAttribute};
    });
  }

  void handleAttributeSelection(Attributes attribute) {
    setState(() {
      selectedAttributes[attribute.k] = attribute;

      // Tìm biến thể phù hợp với thuộc tính đã chọn
      final matchingVariation = widget.variations.firstWhere(
        (variation) => variation.attributes.every(
          (attr) => selectedAttributes[attr.k]?.v == attr.v,
        ),
        // Dự phòng về biến thể đầu tiên nếu không tìm thấy
        orElse: () => widget.variations.first,
      );

      // Tìm chỉ mục của nhóm thuộc tính hiện tại
      final currentIndex = widget.variations.first.attributes
          .indexWhere((attr) => attr.k == attribute.k);

      // Loại bỏ các lựa chọn của các nhóm thuộc tính
      for (var i = currentIndex + 1;
          i < widget.variations.first.attributes.length;
          i++) {
        selectedAttributes.remove(widget.variations.first.attributes[i].k);
        selectedSku = null;
      }

      selectedSku = matchingVariation.sku;
    });
  }

  void postCart() {
    CartApi().updateCart(
      context: context,
      productId: widget.productId,
      sku: selectedSku.toString(),
      quantity: 1,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(),
      ),
    );
    showSnackBarSuccess(context, 'Thêm thành công');
  }

  @override
  Widget build(BuildContext context) {
    final attributeKeys = widget.variations.first.attributes
        .map((attr) => attr.k)
        .toSet()
        .toList();

    final groupedAttributes = widget.variations.fold(
        {},
        (grouped, variation) =>
            variation.attributes.fold(grouped, (grouped, attribute) {
              grouped[attribute.k] =
                  grouped[attribute.k] ?? <String, Attributes>{};
              grouped[attribute.k][attribute.v] = attribute;
              return grouped;
            }));

    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
      child: Stack(
        children: [
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: widget.variations.length,
              itemBuilder: (context, index) {
                final variation = widget.variations[index];
                if (variation.sku == selectedSku) {
                  return Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200, // Adjust the height as needed
                            width: 160,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: variation.images.length,
                              itemBuilder: (context, index) {
                                final image = variation.images[index];
                                if (image.isThumbnail == true) {
                                  return Image(
                                    image: NetworkImage('${image.url}'),
                                    height: 160,
                                    width: 160,
                                  );
                                } else if (index == 0) {
                                  return Image(
                                    image: NetworkImage('${image.url}'),
                                    height: 160,
                                    width: 160,
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${formatCurrency.format(variation.price.special)}',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '-',
                        style: TextStyle(
                          color: Colors.grey.withOpacity(1),
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '${formatCurrency.format(variation.price.base)}',
                        style: TextStyle(
                          color: Colors.grey.withOpacity(1),
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
          Positioned(
            bottom: 16,
            left: 5,
            right: 5,
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: GridView.builder(
                      itemCount: attributeKeys.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 3,
                      ),
                      itemBuilder: (BuildContext context, int indexFirst) {
                        final key = attributeKeys[indexFirst];
                        final attributes = groupedAttributes[key]!;

                        return Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  '${attributes.values.first.name.toUpperCase()}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: SizedBox.expand(
                                  child: GridView.builder(
                                    itemCount: attributes.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final attribute =
                                          attributes.values.elementAt(index);
                                      final selectedAttributesForOtherKeys =
                                          Map.from(selectedAttributes)
                                            ..remove(key);

                                      final variationsWithSelectedAttributesForOtherKeys =
                                          widget.variations.where((variation) =>
                                              selectedAttributesForOtherKeys
                                                  .values
                                                  .every((selectedAttribute) =>
                                                      variation.attributes.any(
                                                          (variationAttribute) =>
                                                              variationAttribute
                                                                      .k ==
                                                                  selectedAttribute
                                                                      .k &&
                                                              variationAttribute
                                                                      .v ==
                                                                  selectedAttribute
                                                                      .v)));

                                      final isAttributeInVariations =
                                          variationsWithSelectedAttributesForOtherKeys
                                              .any((variation) => variation
                                                  .attributes
                                                  .any((variationAttribute) =>
                                                      variationAttribute.k ==
                                                          attribute.k &&
                                                      variationAttribute.v ==
                                                          attribute.v));

                                      final isSelected =
                                          selectedAttributes[key]?.v ==
                                              attribute.v;

                                      final isSelectable = indexFirst == 0
                                          ? true
                                          : isAttributeInVariations;

                                      return ElevatedButton(
                                        onPressed: isSelectable
                                            ? () => handleAttributeSelection(
                                                attribute)
                                            : null,
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            isSelected
                                                ? primaryColors
                                                : Colors.white,
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                            isSelected
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        child: Text(
                                          '${attribute.v.toUpperCase()} ${attribute.u ?? ''}',
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: postCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 85, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Thêm vào giỏ hàng",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
