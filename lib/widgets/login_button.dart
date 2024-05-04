import 'package:flutter/material.dart';

import '../utils/constant/string_constants.dart';

class SocialLoginButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String? buttonIcon;
  final AuthPlatform? loginButtonType;
  final VoidCallback? onTap;

  const SocialLoginButton({
    super.key,
    this.buttonColor = Colors.blue,
    this.textColor = Colors.white,
    this.loginButtonType,
    this.buttonIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        margin: const EdgeInsets.symmetric(horizontal: 32.0),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: buttonIcon != null ? Image.asset(buttonIcon!, width: 32, height: 32) : Icon(Icons.phone, color: textColor),
              ),
            ),
            Center(
              child: Text(
                _getLoginButtonName(loginButtonType),
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getLoginButtonName(AuthPlatform? loginButtonType) {
    switch (loginButtonType) {
      case AuthPlatform.Google:
        return StringConstants.google;
      case AuthPlatform.Phone:
        return StringConstants.phone;
      default:
        return '';
    }
  }
}

enum AuthPlatform {
  Google,
  Phone,
}
