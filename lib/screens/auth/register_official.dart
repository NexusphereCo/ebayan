import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/layouts/layout_auth.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:ebayan/widgets/components/progress_indicator.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class RegisterOfficialScreen extends StatefulWidget {
  const RegisterOfficialScreen({super.key});

  @override
  State<RegisterOfficialScreen> createState() => _RegisterOfficialScreenState();
}

class _RegisterOfficialScreenState extends State<RegisterOfficialScreen> with SingleTickerProviderStateMixin {
  int progressCurrentIndex = 1;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        progressCurrentIndex = _tabController.index + 1;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void nextTab() {
    if (_tabController.index < _tabController.length - 1) {
      _tabController.animateTo(_tabController.index + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const EBAppBarBack(),
        body: Column(
          children: [
            _buildHeading(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPersonalInfo(),
                  _buildLoginCred(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: TabBarFooter(tabController: _tabController),
      ),
    );
  }

  SizedBox _buildHeading() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          EBTypography.h1(
            text: 'Be part of a Barangay!',
            color: EBColor.primary,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              EBTypography.text(
                text: 'Register as a ',
                muted: true,
                textAlign: TextAlign.center,
              ),
              EBTypography.text(
                text: 'Barangay Official.',
                muted: true,
                textAlign: TextAlign.center,
                fontWeight: EBFontWeight.bold,
              ),
              EBTypography.text(
                text: ' Fill in your information to get started.',
                muted: true,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: Spacing.md),
          EBProgressIndicator(currentIndex: progressCurrentIndex, length: 2),
          const SizedBox(height: Spacing.md),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EBTypography.label(text: 'Personal Information'),
              const SizedBox(height: Spacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        FeatherIcons.user,
                        color: EBColor.primary,
                      ),
                      const SizedBox(width: Spacing.md),
                      const Flexible(
                        child: EBTextField(
                          label: 'First Name',
                          type: TextInputType.name,
                        ),
                      ),
                      const SizedBox(width: Spacing.sm),
                      const Flexible(
                        child: EBTextField(
                          label: 'Last Name',
                          type: TextInputType.name,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.md),
                  const EBTextBox(
                    icon: FeatherIcons.phone,
                    textField: EBTextField(
                      label: 'Contact Number',
                      type: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: Spacing.md),
                  const EBTextBox(
                    icon: FeatherIcons.mapPin,
                    textField: EBTextField(
                      label: 'Address',
                      type: TextInputType.text,
                    ),
                  ),
                  const SizedBox(height: Spacing.md),
                  const EBTextBox(
                    icon: FeatherIcons.calendar,
                    textField: EBTextField(
                      label: 'Birth Date',
                      type: TextInputType.datetime,
                    ),
                  ),
                  const SizedBox(height: Spacing.md),
                  const EBTextBox(
                    icon: EBIcons.home,
                    textField: EBTextField(
                      label: 'Barangay Associated',
                      type: TextInputType.datetime,
                    ),
                  ),
                  const SizedBox(height: Spacing.md),
                  const EBTextBox(
                    icon: FeatherIcons.file,
                    textField: EBTextField(
                      label: 'Proof of Official',
                      type: TextInputType.datetime,
                    ),
                  ),
                  const SizedBox(height: Spacing.lg),
                  EBButton(
                    text: 'Next',
                    theme: EBButtonTheme.primaryOutlined,
                    onPressed: () {
                      nextTab();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCred() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EBTypography.label(text: 'Login Credentials'),
                  EBTypography.text(
                    text: 'This will be your account details when logging in to this app.',
                    muted: true,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(height: Spacing.md),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  EBTextBox(
                    icon: FeatherIcons.user,
                    textField: EBTextField(
                      label: 'Username',
                      type: TextInputType.text,
                    ),
                  ),
                  SizedBox(height: Spacing.md),
                  EBTextBox(
                    icon: FeatherIcons.lock,
                    textField: EBTextField(
                      label: 'Password',
                      type: TextInputType.text,
                    ),
                  ),
                  SizedBox(height: Spacing.md),
                  EBTextBox(
                    icon: FeatherIcons.lock,
                    textField: EBTextField(
                      label: 'Confirm Password',
                      type: TextInputType.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: EBTypography.text(
                      text: 'Clear Information',
                      color: EBColor.red,
                      fontWeight: EBFontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.sm),
              SizedBox(
                width: double.infinity,
                child: EBButton(
                  text: 'Register',
                  theme: EBButtonTheme.primary,
                  onPressed: () {
                    Navigator.of(context).push(createRoute('/dashboard'));
                  },
                ),
              ),
              const SizedBox(height: Spacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: EBTypography.text(
                      text: 'Already have an account? ',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: TextButton(
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
                      onPressed: () {
                        Navigator.of(context).push(createRoute('/login'));
                      },
                      child: EBTypography.text(
                        text: 'login.',
                        color: EBColor.primary,
                        fontWeight: EBFontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
