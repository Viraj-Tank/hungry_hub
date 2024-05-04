import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hungry_hub/controller/auth_controller.dart';
import 'package:hungry_hub/utils/constant/image_constants.dart';
import 'package:hungry_hub/widgets/please_wait_dialog.dart';
import 'package:hungry_hub/widgets/sized_boxes.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../utils/constant/string_constants.dart';
import '../../widgets/login_button.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => PleaseWaitWidget(
          isProgressRunning: controller.isLoading.value,
          child: Scaffold(
            body: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Image.asset(ImageConstants.burgerIcon),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        SocialLoginButton(
                          loginButtonType: AuthPlatform.Google,
                          buttonIcon: ImageConstants.googleIcon,
                          onTap: () async {
                            if (!await InternetConnectionChecker().hasConnection) {
                              Fluttertoast.showToast(msg: StringConstants.pleaseTurnOnTheInternet);
                              return;
                            }
                            controller.signInWithGoogle();
                          },
                        ),
                        gapH12,
                        const SocialLoginButton(
                          loginButtonType: AuthPlatform.Phone,
                          buttonColor: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
