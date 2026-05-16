import 'package:ecomerce_crafty_bay/presentation/ui/screens/auth/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller_binder.dart';
import 'presentation/ui/utility/app_theme_data.dart';

class CraftyBay extends StatelessWidget {
  const CraftyBay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      theme: AppThemeData.lightThemeData,

      home: SplashScreen(), //home hisebey dicey maney protom e eta kaz korbey
      initialBinding: ControllerBinder(),//initailbinding deyer karon e eta suru tei call hoye loaded obstay thakbey ..tailey user experience valo paibo

    );
  }
}
