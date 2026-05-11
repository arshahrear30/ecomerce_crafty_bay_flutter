
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../utility/app_colours.dart';
import '../../widgets/app_logo.dart';
import 'complete_profile_screen.dart';

class VerifyOTPScreen extends StatelessWidget {
  const VerifyOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              const AppLogo(
                height: 80,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Enter OTP Code',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'A 4 digit otp code has sent',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 16,
              ),


              PinCodeTextField(  //  pin_code_fields: ^8.0.1 er next vertion gula tey PinCodeTextField ar kaz korbey na ..
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.transparent,
                    inactiveFillColor: Colors.transparent,//otp box background color
                    inactiveColor: AppColors.primaryColor,//otp box er border color
                    selectedFillColor: Colors.transparent,
                    selectedColor: AppColors.primaryColor,

                ), // PinTheme
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                onCompleted: (v) {
                  print("Completed");
                },
                appContext: context,
              ), // PinCodeTextField

              const SizedBox(
                height: 24,
              ), // SizedBox


              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(const CompleteProfileScreen());
                  },
                  child: const Text('Next',),
                ),
              ),


              const SizedBox(
                height: 24,
              ), // SizedBox


              RichText(text: TextSpan(
                  style: TextStyle(
                    color: Colors.grey,
                  ), // TextStyle
                  children: [
                    TextSpan(
                        text: 'This code will expire '
                    ), // TextSpan
                    TextSpan(
                        text: '120s', //HW : make the timer workable
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600
                        ) // TextStyle
                    ) // TextSpan
                  ]
              ),), // TextSpan, RichText
              
              TextButton(onPressed:  (){}, child: const Text('Resend OTP', style: TextStyle(color: Colors.grey),),)


            ],
          ),
        ),
      ),
    );
  }
}