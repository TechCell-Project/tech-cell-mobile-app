// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:my_app/API/api_address_user.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/Widgets/Address/switch_defaul_address.dart';
import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/models/address_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/validator.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChangeAddress extends StatefulWidget {
  AddressModel addressUser;
  int index;
  ChangeAddress({
    Key? key,
    required this.addressUser,
    required this.index,
  }) : super(key: key);

  @override
  State<ChangeAddress> createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final TextEditingController addressNameController = TextEditingController();

  Address address = Address();
  List<ProvinceLevel> provinceLevel = [];
  List<DistrictLevel> districtsLevel = [];
  List<WardLevel> wardLevel = [];

  //set values sau khi chọn
  ProvinceLevel? selectedProvince;
  DistrictLevel? selecttedDistricts;
  WardLevel? selectedWards;

  deleteAddressUser(int index) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    List<AddressModel> addressUser = userProvider.user.address;
    if (index >= 0 && index < addressUser.length) {
      setState(() {
        addressUser.removeAt(index);
      });
    }
    await address.changeAddress(context, addressUser);
  }

  updateAddressUser() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    List<AddressModel> addressUser = userProvider.user.address;
    address.updateAddress(
      addressUser,
      AddressModel(
        addressName: detailController.text,
        customerName: fullNameController.text,
        phoneNumbers: phoneNumberController.text,
        provinceLevel: ProvinceLevel(
            province_id: selectedProvince!.province_id,
            province_name: selectedProvince!.province_name),
        districtLevel: DistrictLevel(
            district_id: selecttedDistricts!.district_id,
            district_name: selecttedDistricts!.district_name),
        wardLevel: WardLevel(
            wardCode: selectedWards!.wardCode,
            wardName: selectedWards!.wardName),
        detail: detailController.text,
        isDefault: widget.addressUser.isDefault,
      ),
      widget.index,
    );
    await address.changeAddress(context, addressUser);
  }

  @override
  void initState() {
    super.initState();
    address.getProvinces(context).then((data) {
      setState(() {
        provinceLevel = data;
        selectedProvince = data.isNotEmpty
            ? data.firstWhere(
                (province) =>
                    province.province_id ==
                    widget.addressUser.provinceLevel.province_id,
              )
            : null;
        if (selectedProvince != null) {
          address
              .getDistricts(context, selectedProvince!.province_id)
              .then((value) {
            setState(() {
              districtsLevel = value;
              selecttedDistricts = value.isNotEmpty
                  ? value.firstWhere(
                      (district) =>
                          district.district_id ==
                          widget.addressUser.districtLevel.district_id,
                    )
                  : null;
              if (selecttedDistricts != null) {
                address
                    .getWards(context, selecttedDistricts!.district_id)
                    .then((value) {
                  setState(() {
                    wardLevel = value;
                    selectedWards = value.isNotEmpty
                        ? value.firstWhere((ward) =>
                            ward.wardCode ==
                            widget.addressUser.wardLevel.wardCode)
                        : null;
                  });
                });
              }
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    fullNameController.text = widget.addressUser.customerName;
    phoneNumberController.text = widget.addressUser.phoneNumbers;
    detailController.text = widget.addressUser.detail;
    addressNameController.text = widget.addressUser.addressName;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Địa chỉ mới',
          style: TextStyle(color: Colors.black),
        ),
        foregroundColor: primaryColors,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: primaryColors,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Liên hệ',
                  style: TextStyle(color: Color.fromARGB(255, 114, 114, 114)),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: TextFormField(
                    controller: fullNameController,
                    validator: (value) => Validator.validateText(value ?? ''),
                    decoration: InputDecoration(
                      hintText: 'Họ và tên',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: TextFormField(
                    controller: phoneNumberController,
                    validator: (value) =>
                        Validator.validatePhoneNumber(value ?? ''),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Số điện thoại',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Địa chỉ',
                  style: TextStyle(color: Color.fromARGB(255, 114, 114, 114)),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 5,
                    top: 5,
                  ),
                  child: Row(
                    children: [
                      const Text('Chọn thành phố: '),
                      const Spacer(),
                      DropdownButton<ProvinceLevel>(
                        hint: const Text(''),
                        value: selectedProvince,
                        onChanged: (newValue) {
                          setState(() {
                            selectedProvince = newValue;
                            selecttedDistricts = null;
                            selectedWards = null;
                            address
                                .getDistricts(context, newValue!.province_id)
                                .then((data) {
                              setState(() {
                                districtsLevel = data;
                              });
                            });
                          });
                        },
                        items: provinceLevel.map((ProvinceLevel? item) {
                          return DropdownMenuItem<ProvinceLevel>(
                            value: item,
                            child: Text(item!.province_name),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 5, top: 5),
                  child: Row(children: [
                    const Text('Chọn Quận/Huyện: '),
                    const Spacer(),
                    DropdownButton<DistrictLevel>(
                      hint: const Text(''),
                      value: selecttedDistricts,
                      onChanged: (DistrictLevel? newValue) {
                        setState(() {
                          selecttedDistricts = newValue;
                          selectedWards = null;
                          address
                              .getWards(context, newValue!.district_id)
                              .then((value) {
                            setState(() {
                              wardLevel = value;
                            });
                          });
                        });
                      },
                      items: districtsLevel.map((DistrictLevel? item) {
                        return DropdownMenuItem<DistrictLevel>(
                          value: item,
                          child: Text(item!.district_name),
                        );
                      }).toList(),
                    ),
                  ]),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 5, top: 5),
                  child: Row(children: [
                    const Text('Chọn Xã/Phường: '),
                    const Spacer(),
                    DropdownButton<WardLevel>(
                      hint: const Text(''),
                      value: selectedWards,
                      onChanged: (newValue) {
                        setState(() {
                          selectedWards = newValue;
                        });
                      },
                      items: wardLevel.map((WardLevel? item) {
                        return DropdownMenuItem<WardLevel>(
                          value: item,
                          child: Text(item!.wardName),
                        );
                      }).toList(),
                    ),
                  ]),
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: TextFormField(
                    controller: detailController,
                    validator: (value) => Validator.validateText(value ?? ''),
                    decoration: InputDecoration(
                      hintText: 'Tên đường, Tòa nhà, Số Nhà',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Cài đặt',
                  style: TextStyle(color: Color.fromARGB(255, 114, 114, 114)),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.3),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: TextFormField(
                    controller: addressNameController,
                    validator: (value) => Validator.validateText(value ?? ''),
                    decoration: InputDecoration(
                      hintText: 'Loại địa chỉ: Nhà, Công ty',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Text('Chọn làm mặc định'),
                    const Spacer(),
                    SwitchDefaulAddress(
                      light: widget.addressUser.isDefault,
                      index: widget.index,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    deleteAddressUser(widget.index);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(55),
                    backgroundColor: Colors.white,
                    shadowColor: Colors.white,
                  ),
                  child: const Text(
                    'Xóa địa chỉ',
                    style: TextStyle(
                      color: primaryColors,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              ButtonSendrequest(text: 'Hoàn thành', submit: updateAddressUser)
            ],
          ),
        ),
      ),
    );
  }
}
