import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/utils/fade_in.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WaitScreen extends StatelessWidget {
  const WaitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final param = ModalRoute.of(context)?.settings.arguments as Map;
    final email = param['email'];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: EBColor.light,
        body: Padding(
          padding: const EdgeInsets.all(Global.paddingBody),
          child: Center(
            child: FadeIn(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Asset.illustWait),
                  const SizedBox(height: Spacing.md),
                  EBTypography.h1(text: 'Account Approval in Progress'),
                  const SizedBox(height: Spacing.md),
                  RichText(
                    text: TextSpan(
                      text: 'Our team is reviewing your information, and we\'ll notify you through this email: ',
                      style: TextStyle(fontFamily: EBTypography.fontFamily, color: EBColor.dark),
                      children: [
                        TextSpan(text: email, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(text: ' once your account is approved. \n\nThis process typically takes one or three business days.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: Spacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      EBButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(createRoute(route: Routes.login));
                        },
                        text: 'Go Home',
                        theme: EBButtonTheme.darkOutlined,
                        icon: const Icon(
                          FeatherIcons.arrowRight,
                          size: EBFontSize.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
