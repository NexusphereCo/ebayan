import 'dart:async';

import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/brgy_controller.dart';
import 'package:ebayan/presentation/join/widgets/confirm_join_modal.dart';
import 'package:ebayan/presentation/join/widgets/pin_code_field.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/widgets/layout_components/appbar_bottom.dart';
import 'package:ebayan/widgets/layout_components/appbar_top.dart';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class JoinBrgyScreen extends StatefulWidget {
  const JoinBrgyScreen({super.key});

  @override
  State<JoinBrgyScreen> createState() => _JoinBrgyScreenState();
}

class _JoinBrgyScreenState extends State<JoinBrgyScreen> {
  final BarangayController brgyController = BarangayController();

  final EBCustomLoadingScreen loadingScreen = const EBCustomLoadingScreen();
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  StreamController<ErrorAnimationType>? errorController;

  String code = '';

  @override
  void initState() {
    connectionHandler(context);
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  Future<void> join() async {
    try {
      // validate the form
      bool isFormValid = formKey.currentState?.validate() == true;
      if (isFormValid) {
        if (context.mounted) loadingScreen.show(context);

        // check if the code is valid
        bool isCodeValid = await brgyController.isCodeValid(code);

        if (isCodeValid) {
          // join them to a barangay
          await brgyController.joinBrgy(code);

          // successfully joined a barangay...
          // hide loading screen and navigate to the dashboard
          if (context.mounted) {
            loadingScreen.hide(context);
            Navigator.of(context).pushReplacement(createRoute(route: Routes.dashboard));
            return;
          }
        } else {
          // hide loading screen, show error, and pop if code is invalid
          if (context.mounted) loadingScreen.hide(context);
          throw 'This code is invalid.';
        }
      }
      throw 'Invalid form. Please make sure to fill in the fields.';
    } catch (e) {
      // triggering error shake animation
      errorController?.add(ErrorAnimationType.shake);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(EBSnackBar.info(text: e.toString()));
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
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Asset.housesCommunity),
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
                          icon: Icon(
                            FeatherIcons.arrowRight,
                            size: EBFontSize.normal,
                            color: EBColor.light,
                          ),
                          theme: EBButtonTheme.primary,
                          onPressed: () {
                            showConfirmJoinModal(context: context, onJoinHandler: join);
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
      bottomNavigationBar: const EBAppBarBottom(activeIndex: 1),
    );
  }
}
