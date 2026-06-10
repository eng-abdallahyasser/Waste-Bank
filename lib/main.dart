import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waste_bank/routes/app_pages.dart';
import 'package:waste_bank/routes/app_routes.dart';

void main() async {
  await GetStorage.init();

  // Check if user is already logged in via stored token
  final isLoggedIn = GetStorage().hasData('auth_token');

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Waste Bank',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: isLoggedIn ? Routes.MAIN : AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
