import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/home/cloud_binding.dart';
import 'package:flutter_application_1/src/ui/home/cloud_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => CloudScreen(),
          binding: CloudBinding(),
        )
      ],
    );
    
  }
}
