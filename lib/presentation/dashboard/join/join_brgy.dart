import 'dart:async';

import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/brgy_controller.dart';
import 'package:ebayan/presentation/dashboard/join/widgets/pin_code_field.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/widgets/shared/appbar_bottom.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/*
  Authored by: Johcel Gene T. Bitara
  Company: NexusphereCo.
  Project: eBayan
  Feature: [EB-003] Join Barangay Screen
  Description: a screen for brgy. residents to use. in this screen,
    user will be prompted to enter their code (disseminated by their officials)
    unto the textfield (consisting of numerical code).
 */

class JoinBrgyScreen extends StatefulWidget {
  const JoinBrgyScreen({super.key});

  @override
  State<JoinBrgyScreen> createState() => _JoinBrgyScreenState();
}

class _JoinBrgyScreenState extends State<JoinBrgyScreen> {
  final BarangayController _brgyController = BarangayController();

  final EBLoadingScreen loadingScreen = const EBLoadingScreen();
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  StreamController<ErrorAnimationType>? errorController;

  String code = '';

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  Future<void> _join() async {
    try {
      if (_formKey.currentState!.validate() == true) {
        // Allow form submission
        if (context.mounted) loadingScreen.show(context);

        // Check if the code is valid
        bool isCodeValid = await _brgyController.isCodeValid(code);

        if (isCodeValid) {
          // Join them to a barangay
          await _brgyController.joinBrgy(code);

          if (context.mounted) {
            Navigator.of(context).pop();
            loadingScreen.hide(context);
          }
        }
        throw 'Invalid code.';
      }
      throw 'Invalid form.';
    } catch (e) {
      // Triggering error shake animation
      errorController!.add(ErrorAnimationType.shake);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar(text: e.toString()));
        loadingScreen.hide(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(enablePop: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Asset.illustHousesPath),
                    const SizedBox(height: Spacing.lg),
                    EBTypography.h3(
                      text: 'Enter Barangay Sphere Code',
                      textAlign: TextAlign.center,
                    ),
                    EBTypography.text(
                      text: 'This code is disseminated by your barangay official',
                      textAlign: TextAlign.center,
                      muted: true,
                    ),
                    const SizedBox(height: Spacing.lg),
                    buildPinCodeTextField(
                      context: context,
                      textEditingController: textEditingController,
                      errorController: errorController,
                      onChangeHandler: (value) {
                        setState(() => code = value);
                      },
                    ),
                    const SizedBox(height: Spacing.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        EBButton(
                          text: 'Join',
                          icon: const Icon(
                            FeatherIcons.arrowRight,
                            size: EBFontSize.normal,
                          ),
                          theme: EBButtonTheme.primary,
                          onPressed: () {
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
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(Global.paddingBody),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        EBTypography.h3(text: 'Note!'),
                                        const SizedBox(height: Spacing.xs),
                                        EBTypography.text(
                                          text: 'This action will transfer your account from your current barangay to the selected one. \n\nAre you sure you want to proceed?',
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
                                              onPressed: () => _join(),
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
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const EBAppBarBottom(),
    );
  }
}
