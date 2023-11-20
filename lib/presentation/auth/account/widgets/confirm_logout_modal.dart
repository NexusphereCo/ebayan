import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

Future<void> showConfirmLogoutModal({
  required BuildContext context,
  required void Function() onProceedHandler,
}) =>
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(EBBorderRadius.lg),
          topRight: Radius.circular(EBBorderRadius.lg),
        ),
      ),
      backgroundColor: EBColor.light,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(Global.paddingBody),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              EBTypography.h3(text: 'Leaving soon?'),
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
                    onPressed: () => onProceedHandler(),
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
        );
      },
    );
