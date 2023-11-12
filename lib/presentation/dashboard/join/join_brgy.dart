import 'dart:async';

import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:ebayan/widgets/shared/appbar_bottom.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final StreamController<ErrorAnimationType> _errorController = StreamController<ErrorAnimationType>();

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
                    MultiTextField(
                      onCompleted: (val) {},
                      onChanged: (val) {},
                      errorController: _errorController,
                      validator: (value) {
                        if (value!.length < 5) {
                          _errorController.add(ErrorAnimationType.shake);
                          return Validation.minLengthBrgyCode;
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        EBButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              // join to a new barangay
                            }
                          },
                          text: 'Join',
                          theme: EBButtonTheme.primary,
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
