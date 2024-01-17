// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/API/api_image.dart';
import 'package:my_app/API/api_profile.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/models/user_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';
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
  final ProfileUser userClass = ProfileUser();
  final Avatar avatar = Avatar();
  File? _selectedImage;
  bool checkavatar = true;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;

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
                            : NetworkImage(user.avatar.url) as ImageProvider,
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
              if (checkavatar)
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextButton(
                    onPressed: () {
                      updateAvatar(context);
                    },
                    child: const Text('thay avatar'),
                  ),
                )
              else
                Container(),
              const SizedBox(height: 30),
              buildTextField("Họ", user.lastName, 'Thay ten', 'lastName',
                  lastNameController),
              buildTextField("Tên", user.firstName, 'Thay ho', 'firstName',
                  fisrtNameController),
              buildTextField('Tên tài khoản', user.userName,
                  'Thay ten tai khoan', 'userName', userNameController),
            ],
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

  Widget buildTextField(String label, String info, String title, String body,
      TextEditingController changeInfo) {
    return InkWell(
      onTap: () {
        openDialog(
          title,
          body,
          changeInfo,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
                    color: Color.fromARGB(255, 89, 89, 89),
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
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  CupertinoIcons.right_chevron,
                  size: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future openDialog(
          String title, String body, TextEditingController changeInfo) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: TextField(
            controller: changeInfo,
            decoration: const InputDecoration(hintText: 'nhap vao day'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                submit(
                  changeInfo,
                  body,
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      );
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
}
