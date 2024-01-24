// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/API/api_image.dart';
import 'package:my_app/API/api_profile.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/models/user_models.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class InformationUser extends StatefulWidget {
  const InformationUser({super.key});

  @override
  State<InformationUser> createState() => _InformationUserState();
}

class _InformationUserState extends State<InformationUser> {
  TextEditingController fisrtNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController avatarPublicId = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ProfileUser userClass = ProfileUser();
  File? _selectedImage;
  bool checkavatar = true;
  bool isButtonEnabled = false;
  String role = '';

  @override
  void initState() {
    super.initState();
    ProfileUser().getProfileUser(context);
    User user = Provider.of<UserProvider>(context, listen: false).user;
    fisrtNameController.text = user.firstName;
    userNameController.text = user.userName;
    lastNameController.text = user.lastName;
  }

  @override
  void dispose() {
    fisrtNameController.dispose();
    userNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: primaryColors,
        title: const Text(
          'Thông tin người dùng',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (checkavatar == true) {
                updateAvatar(context);
              } else {
                return;
              }
            },
            icon: const Icon(CupertinoIcons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 245, 245, 245)),
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: GestureDetector(
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Colors.white,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : (user.avatar.url.isNotEmpty
                                  ? NetworkImage(user.avatar.url)
                                      as ImageProvider
                                  : const AssetImage(
                                      'assets/icons/profile.png')),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: ((context) => bottomSheet(context)));
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Colors.white,
                              ),
                              color: primaryColors,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Text(
                      "${user.lastName} ${user.firstName}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (user.role == "Admin")
                      const Text('Quản trị viên')
                    else if (user.role == 'User')
                      const Text('Khách hàng'),
                  ],
                ),
                const SizedBox(height: 30),
                buildTextField('Id:', user.id),
                buildTextField('Email:', user.email),
                buildTextField('Tên tài khoản:', user.userName),
                buildTextField(
                    'Được tạo lúc:', formatTimestamp(user.createdAt)),
                buildTextField('cập nhật ', formatTimestamp(user.updatedAt)),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ButtonSendrequest(
                    text: "Chỉnh sửa thông tin",
                    submit: () {
                      openDialog(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final returnedImage = await picker.pickImage(source: ImageSource.gallery);
    if (returnedImage == null) {
      return;
    } else {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
  }

  Future pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) {
      return;
    } else {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text(
            'Chọn ảnh',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    pickImageFromCamera();
                  },
                  icon: const Icon(Icons.camera)),
              IconButton(
                  onPressed: () {
                    pickImageFromGallery(context);
                  },
                  icon: const Icon(Icons.image)),
            ],
          )
        ],
      ),
    );
  }

  Widget buildTextField(String label, String info) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 151, 151, 151),
              ),
            ),
            const Spacer(),
            Text(
              info,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 89, 89, 89),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chỉnh sửa thông tin '),
          content: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 100,
              minWidth: double.infinity,
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    textFieldChangeInfo(
                      context,
                      fisrtNameController,
                      'Tên',
                      () {
                        submit(fisrtNameController, 'firstName');
                      },
                    ),
                    const SizedBox(height: 20),
                    textFieldChangeInfo(
                      context,
                      lastNameController,
                      'Họ',
                      () {
                        submit(lastNameController, 'lastName');
                      },
                    ),
                    const SizedBox(height: 20),
                    textFieldChangeInfo(
                      context,
                      userNameController,
                      'Tên đăng nhập',
                      () {
                        submit(userNameController, 'userName');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: primaryColors),
                child: const Text(
                  'Hoàn thành',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future submit(TextEditingController changeInfo, String body) async {
    userClass.changeProfile(
      context: context,
      body: body,
      changeInfo: changeInfo.text,
    );
    Navigator.pop(context);
  }

  Future updateAvatar(BuildContext context) async {
    ImageModel? newAvatar = await Avatar().postImage(
      context: context,
      image: _selectedImage,
    );
    if (newAvatar != null) {
      userClass.changeProfile(
        context: context,
        body: 'avatarPublicId',
        changeInfo: newAvatar.publicId,
      );
      checkavatar = false;
    } else {
      showSnackBarError(context, 'loi roi');
    }
  }

  Widget textFieldChangeInfo(
    BuildContext context,
    TextEditingController textEditingController,
    String label,
    Function()? submit,
  ) {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          controller: textEditingController,
          onChanged: (value) {
            setState(() {
              isButtonEnabled =
                  value.isNotEmpty && value != textEditingController.text;
            });
          },
          decoration: InputDecoration(
            label: Text(label),
            border: const OutlineInputBorder(),
            suffixIcon: TextButton(
                onPressed: isButtonEnabled
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          return;
                        }
                      }
                    : submit,
                child: const Text(
                  'Thay đổi',
                  style: TextStyle(
                    color: primaryColors,
                  ),
                )),
          ),
        )),
      ],
    );
  }

  String formatTimestamp(String timestamp) {
    // Parse the input timestamp
    DateTime dateTime = DateTime.parse(timestamp);

    // Format the date and time
    String formattedDate =
        DateFormat('HH:mm || dd \'Tháng\' M, y').format(dateTime);

    return formattedDate;
  }
}
