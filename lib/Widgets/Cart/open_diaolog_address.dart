import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/API/api_order.dart';
import 'package:my_app/Pages/Tabs/add_address._tap.dart';
import 'package:my_app/Pages/Tabs/change_address.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/models/address_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:provider/provider.dart';

class OpenDialogAddreess extends StatefulWidget {
  final productCart;
  final List<bool> productSelected;

  const OpenDialogAddreess(
      {Key? key, required this.productSelected, required this.productCart})
      : super(key: key);

  @override
  State<OpenDialogAddreess> createState() => _OpenDialogAddreessState();
}

class _OpenDialogAddreessState extends State<OpenDialogAddreess> {
  int valueChecked = 0;

  void getReviewOrder() {
    OrderApi().reviewOrder(
      context: context,
      addressSelected: valueChecked,
      productSelected: (widget.productCart),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<AddressModel> addressUser =
        Provider.of<UserProvider>(context, listen: false).user.address;
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: addressUser.length,
              itemBuilder: (context, index) {
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
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, bottom: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5),
                                      child: Text(
                                        addressUser[index].customerName,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    const SizedBox(
                                      height: 18,
                                      child: VerticalDivider(
                                        color: Colors.black,
                                        thickness: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Text(
                                        addressUser[index].phoneNumbers,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 5),
                                    child: Text(
                                      addressUser[index].detail,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '${addressUser[index].wardLevel.wardName}, ',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '${addressUser[index].districtLevel.district_name}, ',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      addressUser[index]
                                          .provinceLevel
                                          .province_name,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => ChangeAddress(
                                        addressUser: addressUser[index],
                                        index: index,
                                      )),
                                ),
                              );
                            },
                            child: const Text(
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
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddAddressTap()));
            },
            child: Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Row(
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonSendrequest(
              text: "Xác nhận",
              submit: getReviewOrder,
            ),
          ),
        ],
      ),
    );
  }
}
