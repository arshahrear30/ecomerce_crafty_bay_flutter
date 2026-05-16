import 'package:ecomerce_crafty_bay/presentation/ui/screens/auth/verify_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../state_holders/send_email_otp_controller.dart';
import '../../widgets/app_logo.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

//UI class

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //eta dici karon screen e keybord asley na hoy screen kaz korbe na .. kemon screen bengey jaibo
        child: Padding(
          padding: const EdgeInsets.all(
            24.0,
          ), //চারপাশে (top, bottom, left, right) 24 pixel space দেওয়া।Edge = কিনারা/side

          //Insets = ভেতরের দিকে space
          child: Form(
            key: _formKey,

            child: Column(
              children: [
                const SizedBox(height: 160),

                const AppLogo(height: 80),

                const SizedBox(height: 24),

                Text(
                  'Welcome back',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 4),

                Text(
                  'Please enter your email address',
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _emailTEController,
                  decoration: const InputDecoration(hintText: 'Email'),

                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your email';
                    }
                    // TODO: Validate email with Regex
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                //UI Class end
                GetBuilder<SendEmailOtpController>(
                  builder: (controller) {
                    return SizedBox(
                      width: double.infinity,

                      child: Visibility(
                        visible:
                            controller.inProgress ==
                            false, //jdi loading na chole ta hoiley button dekaw

                        replacement: const Center(
                          child:
                              CircularProgressIndicator(), //Next button er replacement e CircularProgressIndicator show korbey
                        ),

                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              //jdi email validate hoy tailey

                              //API call
                              final bool result = //sendOtpToEmail() function একটা result ফেরত দেয় true -OTP success :
                              // false-OTP send fail tai bool use korchi
                              //api call ses hoiley seita result e store hobe . pore ar change kora jabe na ..change jate na kora jay tai final use korchi ..
                              await controller.sendOtpToEmail(  //controller কে বলো OTP পাঠাও এই email এ
                                //await কারণ OTP পাঠানো মানে API call - internet লাগে, time লাগে //এই কাজটা শেষ না হওয়া পর্যন্ত wait করো
                                    _emailTEController.text.trim(),//text ta key trim koira send korbey
                                  );
                              //API call

                              if (result) { //jdi API call sucess hoy
                                Get.to( //notun screen e jaw
                                  () => VerifyOTPScreen(
                                    email: _emailTEController.text.trim(),
                                  ),
                                );
                              } else {
                                Get.showSnackbar(//showSnackbar maney Error message দেখাবে।
                                  GetSnackBar( //Snackbar UI
                                    title: 'Send OTP failed',//error er main karon er uporey title e ata thekbey
                                    message: controller.errorMessage,//error er main karon system detect kora bolbey..

                                    duration: const Duration(seconds: 2),
                                    isDismissible: true,//2 sec por coila jabe//User swipe করে close করতে পারবে।
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('Next'), //UI Text
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
