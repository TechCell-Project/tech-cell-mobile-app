// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/models/product_model.dart';
import 'package:my_app/utils/constant.dart';

class BuyNow extends StatefulWidget {
  final List<Variation> variations;
  final id;
  final handleSelectVariation;
  const BuyNow({
    required this.variations,
    required this.id,
    required this.handleSelectVariation,
  });

  @override
  State<BuyNow> createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  late Map<String, Attributes> selectedAttributes;
  String? selectedVariation;

  @override
  void initState() {
    super.initState();
    selectedAttributes = {};
    selectedVariation = null;
    _selectFirstAttribute();
  }

  void _selectFirstAttribute() {
    final firstAttribute = widget.variations.first.attributes.first;
    setState(() {
      selectedAttributes = {firstAttribute.k: firstAttribute};
    });
  }

  void _handleAttributeSelection(Attributes attribute) {
    setState(() {
      selectedAttributes[attribute.k] = attribute;

      // Find the index of the current attribute group
      final currentIndex = widget.variations.first.attributes
          .indexWhere((attr) => attr.k == attribute.k);

      // Remove the selections of the subsequent attribute groups
      for (var i = currentIndex + 1;
          i < widget.variations.first.attributes.length;
          i++) {
        selectedAttributes.remove(widget.variations.first.attributes[i].k);
        selectedVariation = null;
      }
    });
  }

  void _handleSelectVariation() {
    if (selectedAttributes.length ==
        widget.variations.first.attributes.length) {
      final matchingVariation = widget.variations.firstWhereOrNull(
          (variation) => variation.attributes.every((attribute) =>
              selectedAttributes[attribute.k]?.v == attribute.v));

      setState(() {
        selectedVariation = matchingVariation?.sku;
      });

      widget.handleSelectVariation(selectedVariation);
    }
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

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: GridView.builder(
            itemCount: attributeKeys.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              final key = attributeKeys[index];
              final attributes = groupedAttributes[key]!;

              return Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        attributes.values.first.name.toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        itemCount: attributes.length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final attribute = attributes.values.elementAt(index);
                          final selectedAttributesForOtherKeys =
                              Map.from(selectedAttributes)..remove(key);

                          final variationsWithSelectedAttributesForOtherKeys =
                              widget.variations.where((variation) =>
                                  selectedAttributesForOtherKeys.values.every(
                                      (selectedAttribute) => variation
                                          .attributes
                                          .any((variationAttribute) =>
                                              variationAttribute.k ==
                                                  selectedAttribute.k &&
                                              variationAttribute.v ==
                                                  selectedAttribute.v)));

                          // final variantThumbnail = index == 0
                          //     ? widget.variations
                          //         .firstWhereOrNull((variation) => variation.attributes
                          //             .any((attr) =>
                          //                 attr.k == attribute.k &&
                          //                 attr.v == attribute.v))
                          //         ?.images
                          //         .firstWhereOrNull((image) => image.isThumbnail)
                          //     : null;

                          final isAttributeInVariations =
                              variationsWithSelectedAttributesForOtherKeys.any(
                                  (variation) => variation.attributes.any(
                                      (variationAttribute) =>
                                          variationAttribute.k == attribute.k &&
                                          variationAttribute.v == attribute.v));

                          final isSelected =
                              selectedAttributes[key]?.v == attribute.v;

                          final isSelectable = index == isAttributeInVariations
                              ? true
                              : isAttributeInVariations;
                          return ElevatedButton(
                            onPressed: isSelectable
                                ? () => _handleAttributeSelection(attribute)
                                : null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                isSelected ? primaryColors : Colors.white,
                              ),
                              foregroundColor: MaterialStateProperty.all(
                                isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            child:
                                // variantThumbnail != null
                                //     ? Image.network(
                                //         variantThumbnail.url,
                                //         width: 50,
                                //         height: 50,
                                //         fit: BoxFit.cover,
                                //       )
                                //     :
                                Text(
                                    '${attribute.v.toUpperCase()} ${attribute.u}'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Container(
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
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
        ),
      ],
    );
  }
}
