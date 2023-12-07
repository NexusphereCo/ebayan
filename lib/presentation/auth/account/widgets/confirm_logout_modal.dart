import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class LogoutModal extends StatelessWidget {
  final EBLoadingScreen _loadingScreen = const EBLoadingScreen();
  final UserController _userController = UserController();

  LogoutModal({super.key});

  Future<void> _logOut(BuildContext context) async {
    _loadingScreen.show(context);

    await _userController.logOut();

    if (context.mounted) {
      _loadingScreen.hide(context);
      Navigator.of(context).push(createRoute(route: Routes.login));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: EBColor.light,
        borderRadius: BorderRadius.circular(EBBorderRadius.lg),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 30,
            color: EBColor.green[600]!.withOpacity(0.25),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(Global.paddingBody),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            EBTypography.h3(text: 'Leaving so soon?'),
            const SizedBox(height: Spacing.xs),
            EBTypography.text(
              text: 'Logging out will end your current session, requiring you to sign in again. \n\nAre you sure you want to proceed?',
              muted: true,
            ),
            const SizedBox(height: Spacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: EBTypography.text(text: 'Cancel', color: EBColor.red),
                ),
                const SizedBox(width: Spacing.md),
                EBButton(
                  onPressed: () => _logOut(context),
                  text: 'Proceed',
                  theme: EBButtonTheme.primaryOutlined,
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
    );
  }
}
