import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:ebayan/widgets/components/progress_indicator.dart';
import 'package:ebayan/widgets/layout_components/appbar_top.dart';
import 'package:ebayan/widgets/layout_components/footer.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();

  late TabController tabController;
  int progressCurrentIndex = 1;
  int tabLength = 3;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabLength, vsync: this);
  }

  Future<void> sendOTP() async {
    bool isFormValid = formKey.currentState?.validate() == true;
    if (isFormValid) {
      // check if the user account exist
      // allow next step
    }
  }

  void nextTab(GlobalKey<FormState> formKey) {
    // bool isFormValid = formKey.currentState?.validate() == true;

    if (true) {
      if (tabController.index < tabController.length - 1) {
        tabController.animateTo(tabController.index + 1);
      }
    }
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
                text: 'Forgot Password',
                color: EBColor.primary,
                maxLines: 2,
              ),
              EBTypography.text(
                text: 'Enter your account and receive an OTP code on their phone number.',
                muted: true,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: Spacing.xl),
              EBTextBox(
                icon: FeatherIcons.user,
                textField: EBTextField(
                  label: 'Username',
                  type: TextInputType.emailAddress,
                  validator: (value) {
                    value = value?.trim();
                    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

                    if (value == null || value.isEmpty) {
                      return Validation.missingField;
                    } else if (!emailRegExp.hasMatch(value)) {
                      return Validation.invalidEmail;
                    }
                    return null;
                  },
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: Spacing.md),
              SizedBox(
                width: double.infinity,
                child: EBButton(
                  onPressed: () {},
                  text: 'Send OTP',
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
      bottomNavigationBar: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          EBProgressIndicator(currentIndex: 1, length: 3),
          SizedBox(height: Spacing.md),
          EBFooter(),
        ],
      ),
    );
  }
}
