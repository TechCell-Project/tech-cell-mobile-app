import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/API/api_order.dart';
import 'package:my_app/Pages/Tabs/add_address._tap.dart';
import 'package:my_app/Pages/Tabs/change_address.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/models/address_model.dart';
import 'package:my_app/models/cart_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:provider/provider.dart';

class OpenDialogAddreess extends StatefulWidget {
  final productCart;
  final List<bool> productSelected;

  const OpenDialogAddreess({
    required this.productSelected,
    required this.productCart,
  });

  @override
  State<OpenDialogAddreess> createState() => _OpenDialogAddreessState();
}

class _OpenDialogAddreessState extends State<OpenDialogAddreess> {
  int valueChecked = 0;

  void getReviewOrder() {
    List<Product> selectedProducts = [];

    for (int i = 0; i < widget.productCart.length; i++) {
      if (i < widget.productSelected.length && widget.productSelected[i]) {
        selectedProducts.add(widget.productCart[i]);
      }
    }

    OrderApi().reviewOrder(
      context: context,
      addressSelected: valueChecked,
      productSelected: selectedProducts,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Địa chỉ của tôi',
                  style: TextStyle(
                    color: primaryColors,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          _buildMyAddress(),
          _buildNewAddress(),
          Padding(
            padding: EdgeInsets.all(15),
            child: ButtonSendrequest(
              text: "Xác nhận",
              submit: getReviewOrder,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyAddress() {
    List<AddressModel> addressUser =
        Provider.of<UserProvider>(context, listen: false).user.address;

    return Expanded(
      child: ListView.builder(
        itemCount: addressUser.length,
        itemBuilder: (context, index) {
          final userAndAddress = addressUser[index];
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Radio(
                      activeColor: primaryColors,
                      value: index,
                      groupValue: valueChecked,
                      onChanged: (val) {
                        setState(
                          () {
                            valueChecked = val!;
                          },
                        );
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${userAndAddress.customerName}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '|',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${userAndAddress.phoneNumbers}',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${userAndAddress.detail}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              '${userAndAddress.wardLevel.wardName}, ',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${userAndAddress.districtLevel.district_name}, ',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${userAndAddress.provinceLevel.province_name}',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ChangeAddress(
                                    addressUser: userAndAddress,
                                    index: index,
                                  ))),
                        );
                      },
                      child: Text(
                        'Sửa',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: primaryColors,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNewAddress() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddAddressTap()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.add_circled,
              size: 30,
              color: primaryColors,
            ),
            SizedBox(width: 10),
            Text(
              'Thêm Địa Chỉ Mới',
              style: TextStyle(
                color: primaryColors,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
