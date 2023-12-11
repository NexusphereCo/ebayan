import 'dart:async';

import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:ebayan/widgets/layout_components/appbar_top.dart';
import 'package:ebayan/widgets/layout_components/footer.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordOtpVerificationScreen extends StatefulWidget {
  const ForgotPasswordOtpVerificationScreen({super.key});

  @override
  State<ForgotPasswordOtpVerificationScreen> createState() => _ForgotPasswordOtpVerificationScreenState();
}

class _ForgotPasswordOtpVerificationScreenState extends State<ForgotPasswordOtpVerificationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    super.dispose();
    errorController!.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(enablePop: true, noTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              EBTypography.h1(
                text: 'OTP Verification',
                color: EBColor.primary,
                maxLines: 2,
              ),
              EBTypography.text(
                text: 'Enter the OTP code you received in your phone number.',
                muted: true,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: Spacing.xl),
              EBPinCodeTextField(
                textEditingController: otpController,
                errorController: errorController,
                onChangeHandler: (value) {},
                length: 5,
              ),
              const SizedBox(height: Spacing.md),
              SizedBox(
                width: double.infinity,
                child: EBButton(
                  onPressed: () {
                    Navigator.of(context).push(createRoute(route: '/account/forgot_password/reset'));
                  },
                  text: 'Verify Code',
                  icon: Icon(
                    FeatherIcons.arrowRight,
                    color: EBColor.light,
                    size: EBFontSize.h4,
                  ),
                  theme: EBButtonTheme.primary,
                ),
              ),
              const SizedBox(height: Spacing.xxxl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const EBFooter(),
    );
  }
}
