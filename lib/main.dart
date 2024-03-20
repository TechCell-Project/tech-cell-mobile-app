import 'package:flutter/material.dart';
import 'package:my_app/Pages/Screens/main_screen.dart';
import 'package:my_app/Providers/product_provider.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/utils/constant.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserProvider userProvider = UserProvider();
  await userProvider.loadUserFromStorage();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColors,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}
