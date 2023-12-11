import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/auth_controller.dart';
import 'package:ebayan/data/model/user_model.dart';
import 'package:ebayan/presentation/auth/register/resident/widgets/form_step_1.dart';
import 'package:ebayan/presentation/auth/register/resident/widgets/form_step_2.dart';
import 'package:ebayan/presentation/auth/register/resident/widgets/heading.dart';
import 'package:ebayan/presentation/auth/register/resident/widgets/tab_bar.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/progress_indicator.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/widgets/layout_components/appbar_top.dart';
import 'package:ebayan/widgets/utils/keep_alive.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class RegisterResidentScreen extends StatefulWidget {
  const RegisterResidentScreen({super.key});

  @override
  State<RegisterResidentScreen> createState() => _RegisterResidentScreenState();
}

class _RegisterResidentScreenState extends State<RegisterResidentScreen> with SingleTickerProviderStateMixin {
  final RegisterController registerController = RegisterController();
  final EBCustomLoadingScreen loadingScreen = const EBCustomLoadingScreen();

  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  late TabController tabController;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool showPassword = false;

  int progressCurrentIndex = 1;
  int tabLength = 2;

  @override
  void initState() {
    connectionHandler(context);
    super.initState();

    tabController = TabController(length: tabLength, vsync: this);
    tabController.addListener(() {
      setState(() {
        progressCurrentIndex = tabController.index + 1;
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    contactNumberController.dispose();
    addressController.dispose();
    birthDateController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void nextTab(GlobalKey<FormState> formKey) {
    bool isFormValid = formKey.currentState?.validate() == true;

    if (isFormValid) {
      if (tabController.index < tabController.length - 1) {
        tabController.animateTo(tabController.index + 1);

        // this just sets the username disabled textfield on the last page
        if (tabController.index == tabController.length - 1) {
          usernameController.text = emailController.text;
        }
      }
    }
  }

  void register() async {
    loadingScreen.show(context);

    bool isForm1Valid = formKey1.currentState?.validate() == true;
    bool isForm2Valid = formKey2.currentState?.validate() == true;

    if (isForm1Valid && isForm2Valid) {
      try {
        UserModel model = UserModel(
          userType: UserType.resident,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          contactNumber: contactNumberController.text,
          address: addressController.text,
          birthDate: birthDateController.text,
          username: emailController.text,
          password: passwordController.text,
          barangayAssociated: null,
        );

        // call the controller register function
        await registerController.registerAsResident(model);

        if (context.mounted) {
          loadingScreen.hide(context);
          Navigator.of(context).pushReplacement(createRoute(route: Routes.dashboard, args: {'startTutorial': true}));
        }
      } catch (err) {
        if (context.mounted) {
          loadingScreen.hide(context);
          ScaffoldMessenger.of(context).showSnackBar(EBSnackBar.info(text: err.toString()));
        }
      }
    } else {
      if (context.mounted) loadingScreen.hide(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabLength,
      child: Scaffold(
        appBar: EBAppBar(
          enablePop: true,
          title: Wrap(
            spacing: Spacing.sm,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              EBTypography.h3(text: 'Register', color: EBColor.primary),
              SvgPicture.asset(Asset.logoWColor),
            ],
          ),
        ),
        body: Column(
          children: [
            buildTabBar(tabController),
            const SizedBox(height: Spacing.lg),
            buildHeading(),
            const SizedBox(height: Spacing.md),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  KeepAliveWrapper(
                    child: Form(
                      key: formKey1,
                      child: buildPersonalInfo(
                        context: context,
                        firstNameController: firstNameController,
                        lastNameController: lastNameController,
                        emailController: emailController,
                        contactNumberController: contactNumberController,
                        addressController: addressController,
                        birthDateController: birthDateController,
                        birthDateOnTapHandler: (date) => _setBirthDate(date),
                        nextTabHandler: () => nextTab(formKey1),
                      ),
                    ),
                  ),
                  KeepAliveWrapper(
                    child: Form(
                      key: formKey2,
                      child: buildLoginCred(
                        context: context,
                        tabController: tabController,
                        usernameController: usernameController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        showPassword: showPassword,
                        togglePassIconHandler: () => _setTogglePassword(),
                        onRegisterHandler: register,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: Spacing.lg),
          child: EBProgressIndicator(currentIndex: progressCurrentIndex, length: tabLength),
        ),
      ),
    );
  }

  // Frontend scripts
  void _setTogglePassword() => setState(() {
        showPassword = !showPassword;
      });

  void _setBirthDate(date) => setState(() {
        birthDateController.text = DateFormat('yyyy-MM-dd').format(date);
      });
}
