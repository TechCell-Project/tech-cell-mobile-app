import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/utils/constant.dart';

void showSnackBarError(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            size: 30,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    ),
    showCloseIcon: true,
    closeIconColor: Colors.white,
    behavior: SnackBarBehavior.floating,
    backgroundColor: primaryColors,
  )
      // SnackBar(
      //   content: Container(
      //     padding: const EdgeInsets.all(8),
      //     height: 100,
      //     decoration: const BoxDecoration(
      //       color: Colors.red,
      //       borderRadius: BorderRadius.all(
      //         Radius.circular(20),
      //       ),
      //     ),
      //     child: Row(
      //       children: [
      //         const Icon(
      //           Icons.error_outline,
      //           size: 30,
      //           color: Colors.white,
      //         ),
      //         const SizedBox(width: 20),
      //         Expanded(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               const Text(
      //                 'Thất bại',
      //                 style: TextStyle(
      //                   fontSize: 18,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //               Text(text)
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      //   showCloseIcon: true,
      //   behavior: SnackBarBehavior.floating,
      //   backgroundColor: const Color.fromARGB(255, 255, 239, 239),
      // ),
      );
}

void showSnackBarSuccess(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              size: 30,
              color: Colors.white,
            ),
            SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
    ),
    // SnackBar(
    //   content: Container(
    //     padding: EdgeInsets.all(8),
    //     height: 80,
    //     decoration: BoxDecoration(
    //       color: Colors.green,
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(20),
    //       ),
    //     ),
    //     child: Row(
    //       children: [
    //         Icon(
    //           Icons.check_circle,
    //           size: 30,
    //           color: Colors.white,
    //         ),
    //         SizedBox(width: 10),
    //         Expanded(
    //           child: Text(
    //             text,
    //             style: TextStyle(
    //               fontSize: 20,
    //               color: Colors.white,
    //             ),
    //           ),
    //         ),
    //         // Expanded(
    //         //   child: Column(
    //         //     crossAxisAlignment: CrossAxisAlignment.start,
    //         //     children: [
    //         //       // const Text(
    //         //       //   'Thành công',
    //         //       //   style: TextStyle(
    //         //       //     fontSize: 18,
    //         //       //     color: Colors.white,
    //         //       //   ),
    //         //       // ),
    //         //       Text(
    //         //         text,
    //         //         style: TextStyle(
    //         //           fontSize: 18,
    //         //           color: Colors.white,
    //         //         ),
    //         //       )
    //         //     ],
    //         //   ),
    //         // ),
    //       ],
    //     ),
    //   ),
    //   showCloseIcon: true,
    //   behavior: SnackBarBehavior.floating,
    //   backgroundColor: Color.fromARGB(255, 255, 239, 239),
    // ),
  );
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 201:
      onSuccess();
      break;
    case 400:
      showSnackBarError(
        context,
        'Loi 400',
      );
      break;
    case 401:
      showSnackBarError(
        context,
        'Tài khoản hoặc mật khẩu sai',
      );
    case 403:
      showSnackBarError(context, 'Tài khoản của bạn bị khóa!');
    case 404:
      showSnackBarError(
        context,
        'Tài khoản hoặc mật khẩu bị sai',
      );
      break;
    case 406:
      showSnackBarError(
        context,
        'Tài khoản của bạn chưa được xác thực',
      );
      break;
    case 422:
      showSnackBarError(
        context,
        'Tài khoản đã được sử dụng',
      );
      break;
    case 429:
      showSnackBarError(
        context,
        jsonDecode(response.body)['error'],
      );
      break;
    case 502:
      showSnackBarError(context, 'loi o day');
    default:
      showSnackBarError(context, response.body);
  }
}
