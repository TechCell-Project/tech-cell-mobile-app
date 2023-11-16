import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_app/API/api_image.dart';
import 'package:my_app/API/api_profile.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

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
  final ProfileUser user = ProfileUser();
  final Avatar avatar = Avatar();
  File? _selectedImage;

  void getUserProfile() {
    user.getProfileUser(context);
  }

  void changeProfile() {
    user.changeProfile(
      firstName: fisrtNameController.text,
      lastName: lastNameController.text,
      userName: userNameController.text,
      avatarPublicId: avatarPublicId.text,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    fisrtNameController.text = user.firstName;
    userNameController.text = user.userName;
    emailController.text = user.email;
    lastNameController.text = user.lastName;

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
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 15,
          top: 20,
          right: 15,
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
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
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/icons/profile.png'),
                        // backgroundImage: _selectedImage != null
                        //     ? FileImage(_selectedImage!)
                        //     : NetworkImage(user.avatar.url) as ImageProvider,
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
              const SizedBox(height: 30),
              buildTextField("Tên", fisrtNameController),
              buildTextField("Họ", lastNameController),
              buildTextField('Tên tài khoản', userNameController),
              ElevatedButton(
                onPressed: changeProfile,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(55),
                  backgroundColor: primaryColors,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Cập nhật thông tin',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future uploadAvatar(FormData image) async {
    final response = await avatar.postImage(context: context, image: image);
    return response;
  }

  Future pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
    if (_selectedImage is bool) {
      // final formData = FormData();
      return uploadAvatar(_selectedImage as FormData);
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
                    pickImageFromGallery();
                  },
                  icon: const Icon(Icons.image)),
            ],
          )
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 89, 89, 89),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
