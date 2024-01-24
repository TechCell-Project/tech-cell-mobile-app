import 'package:flutter/material.dart';
import 'package:my_app/API/api_address_user.dart';
import 'package:my_app/Widgets/Address/button_in_address.dart';
import 'package:my_app/Widgets/Address/textform_address.dart';
import 'package:my_app/models/address_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/validator.dart';

class AddAddressTap extends StatefulWidget {
  const AddAddressTap({super.key});

  @override
  State<AddAddressTap> createState() => _AddAddressTapState();
}

class _AddAddressTapState extends State<AddAddressTap> {
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

//giúp hiện các widget sau khi chọn ở trên
  bool isProvinceSelected = false;
  bool isDistrictSelected = false;

  void addAddress() {
    if (_formKey.currentState!.validate()) {
      address.pathAddress(
        context,
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
          isDefault: false,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    address.getProvinces(context).then((data) {
      setState(() {
        provinceLevel = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Địa chỉ mới',
          style: TextStyle(color: Colors.black),
        ),
        foregroundColor: primaryColors,
        elevation: 0,
        backgroundColor: Colors.white,
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
              TextformAddress(
                controller: fullNameController,
                hint: 'Họ và tên',
                validate: (value) => Validator.validateText(value ?? ''),
              ),
              TextformAddress(
                keyboard: TextInputType.phone,
                controller: phoneNumberController,
                hint: 'Số điện thoại',
                validate: (value) => Validator.validatePhoneNumber(value ?? ''),
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
                      left: 10, right: 10, bottom: 5, top: 5),
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
                            isProvinceSelected = true;
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
              if (isProvinceSelected)
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
                            isDistrictSelected = true;
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
                )
              else
                Container(),
              if (isDistrictSelected)
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
                )
              else
                Container(),
              TextformAddress(
                validate: (value) => Validator.validateText(value ?? ''),
                hint: 'Tên đường, Tòa nhà, Số Nhà',
                controller: detailController,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Cài đặt',
                  style: TextStyle(color: Color.fromARGB(255, 114, 114, 114)),
                ),
              ),
              TextformAddress(
                controller: addressNameController,
                hint: 'Loại địa chỉ: Nhà, Công ty',
                validate: (value) => Validator.validateText(value ?? ''),
              ),
              const SizedBox(height: 50),
              ButtonInAddress(
                functionAddress: addAddress,
                textInAddress: 'Thêm địa chỉ',
              )
            ],
          ),
        ),
      ),
    );
  }
}
