import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/auth/register.dart';
import 'package:ebayan/screens/resident/dashboard.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/footer.dart';
import 'package:ebayan/widgets/form.dart';
import 'package:ebayan/widgets/progress_indicator.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RegisterResidentScreen extends StatefulWidget {
  const RegisterResidentScreen({super.key});

  @override
  State<RegisterResidentScreen> createState() => _RegisterResidentScreenState();
}

class _RegisterResidentScreenState extends State<RegisterResidentScreen> with SingleTickerProviderStateMixin {
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

  Widget _buildPersonalInfo() {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EBTypography.label(text: 'Personal Information'),
            const SizedBox(height: Spacing.formMd),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const EBTextBox(
                  label: 'First Name',
                  icon: FeatherIcons.user,
                  textField: EBTextField(
                    placeholder: 'Enter your first name',
                    type: TextInputType.name,
                  ),
                ),
                const SizedBox(height: Spacing.formMd),
                const EBTextBox(
                  label: 'Last Name',
                  icon: FeatherIcons.user,
                  textField: EBTextField(
                    placeholder: 'Enter your last name',
                    type: TextInputType.name,
                  ),
                ),
                const SizedBox(height: Spacing.formMd),
                const EBTextBox(
                  label: 'Contact Number',
                  icon: FeatherIcons.phone,
                  textField: EBTextField(
                    placeholder: 'Enter your contact number',
                    type: TextInputType.number,
                  ),
                ),
                const SizedBox(height: Spacing.formMd),
                const EBTextBox(
                  label: 'Address',
                  icon: FeatherIcons.mapPin,
                  textField: EBTextField(
                    placeholder: 'Enter your address',
                    type: TextInputType.text,
                  ),
                ),
                const SizedBox(height: Spacing.formMd),
                const EBTextBox(
                  label: 'Birth Date',
                  icon: FeatherIcons.calendar,
                  textField: EBTextField(
                    placeholder: 'Enter your birth date',
                    type: TextInputType.datetime,
                  ),
                ),
                const SizedBox(height: Spacing.formLg),
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
      ],
    );
  }

  Widget _buildLoginCred() {
    return ListView(
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
        const SizedBox(height: Spacing.formMd),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            EBTextBox(
              label: 'Username',
              icon: FeatherIcons.user,
              textField: EBTextField(
                placeholder: 'Enter your username',
                type: TextInputType.text,
              ),
            ),
            SizedBox(height: Spacing.formMd),
            EBTextBox(
              label: 'Password',
              icon: FeatherIcons.lock,
              textField: EBTextField(
                placeholder: 'Enter your password',
                type: TextInputType.text,
              ),
            ),
            SizedBox(height: Spacing.formMd),
            EBTextBox(
              label: 'Confirm Password',
              icon: FeatherIcons.lock,
              textField: EBTextField(
                placeholder: 'Re-enter your password',
                type: TextInputType.text,
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.formLg),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {},
              child: EBTypography.text(
                text: 'Clear Information',
                color: EBColor.danger,
                fontWeight: EBFontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.formSm),
        SizedBox(
          width: double.infinity,
          child: EBButton(
            text: 'Register',
            theme: EBButtonTheme.primary,
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const DashboardScreen(),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: Spacing.formSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: EBTypography.text(
                text: 'Already have an account? ',
              ),
            ),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
              child: Flexible(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Global.paddingBody),
                child: Column(
                  children: [
                    const SafeArea(child: EBBackButton(screenDestination: RegisterScreen())),
                    SizedBox(
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
                                text: 'Barangay Resident.',
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
                          const SizedBox(height: Spacing.formMd),
                          EBProgressIndicator(currentIndex: progressCurrentIndex, length: 2),
                          const SizedBox(height: Spacing.formMd),
                        ],
                      ),
                    ),
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
              ),
            ),
            TabBar(
              controller: _tabController,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
              indicator: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: EBColor.primary, width: 2.0),
                ),
              ),
              tabs: const [
                Tab(
                  child: Text(
                    'Personal Information',
                    style: TextStyle(
                      fontFamily: EBTypography.fontFamily,
                      color: EBColor.primary,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Login Credentials',
                    style: TextStyle(
                      fontFamily: EBTypography.fontFamily,
                      color: EBColor.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: const EBFooter(),
      ),
    );
  }
}
