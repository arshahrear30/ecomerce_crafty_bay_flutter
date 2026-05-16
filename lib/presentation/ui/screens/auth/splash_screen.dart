import 'package:ecomerce_crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'verify_email_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {//Screen open হওয়ার সাথে সাথে যদি automatically কিছু চালাতে চাও → initState()
    super.initState();//initState->widget create হওয়ার সময় মাত্র ১ বার call হয়।
    moveToNextScreen();
  }

  void moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2),); //eta bobisot e 2 sec porjonto thakbey tai await use korchi

    Get.offAll(const VerifyEmailScreen());//offAll deyar karon e splash screen / ei rokom ager jto screen thakbey seita nevigation stack theke remove hoi jabe .
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( //row column tey center korcey maz khan e acey ekon
        child: Column( //maz khan theke amra sudu column niya kaz korbo
          children: [

            const Spacer(),//maz column er upor nich soman spach dibe doibar nici
            AppLogo(),
            const Spacer(),//nicher theke 16+16 space bad diya upor e jeituku space thake seita devide hoibo

            const CircularProgressIndicator(),

            const SizedBox(height: 16,),
            const Text('Version 1.0'),
            const SizedBox(height: 16,),
          ],
        ), // Column

    ),
    );
  }
}
