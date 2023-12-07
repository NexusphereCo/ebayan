import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/auth_controller.dart';
import 'package:ebayan/data/model/user_model.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/progress_indicator.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:ebayan/widgets/utils/keep_alive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'widgets/form_step_1.dart';
import 'widgets/form_step_2.dart';
import 'widgets/heading.dart';
import 'widgets/tab_bar.dart';

class RegisterResidentScreen extends StatefulWidget {
  const RegisterResidentScreen({Key? key}) : super(key: key);

  @override
  State<RegisterResidentScreen> createState() => _RegisterResidentScreenState();
}

class _RegisterResidentScreenState extends State<RegisterResidentScreen> with SingleTickerProviderStateMixin {
  final RegisterController _registerController = RegisterController();
  final EBLoadingScreen loadingScreen = const EBLoadingScreen();

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  late TabController _tabController;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _showPassword = false;

  int progressCurrentIndex = 1;
  int tabLength = 2;

  @override
  void initState() {
    connectionHandler(context);
    super.initState();

    _tabController = TabController(length: tabLength, vsync: this);
    _tabController.addListener(() {
      setState(() {
        progressCurrentIndex = _tabController.index + 1;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _contactNumberController.dispose();
    _addressController.dispose();
    _birthDateController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _nextTab(GlobalKey<FormState> formKey) {
    bool isFormValid = formKey.currentState?.validate() == true;

    if (isFormValid) {
      if (_tabController.index < _tabController.length - 1) {
        _tabController.animateTo(_tabController.index + 1);

        // this just sets the username disabled textfield on the last page
        if (_tabController.index == _tabController.length - 1) {
          _usernameController.text = _emailController.text;
        }
      }
    }
  }

  void _register() async {
    loadingScreen.show(context);

    bool isForm1Valid = _formKey1.currentState?.validate() == true;
    bool isForm2Valid = _formKey2.currentState?.validate() == true;

    if (isForm1Valid && isForm2Valid) {
      try {
        UserModel model = UserModel(
          userType: UserType.resident,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          contactNumber: _contactNumberController.text,
          address: _addressController.text,
          birthDate: _birthDateController.text,
          username: _emailController.text,
          password: _passwordController.text,
          barangayAssociated: null,
        );

        // call the controller register function
        await _registerController.registerAsResident(model);

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
              SvgPicture.asset(Asset.logoColorPath),
            ],
          ),
        ),
        body: Column(
          children: [
            buildTabBar(_tabController),
            const SizedBox(height: Spacing.lg),
            buildHeading(),
            const SizedBox(height: Spacing.md),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  KeepAliveWrapper(
                    child: Form(
                      key: _formKey1,
                      child: buildPersonalInfo(
                        context: context,
                        firstNameController: _firstNameController,
                        lastNameController: _lastNameController,
                        emailController: _emailController,
                        contactNumberController: _contactNumberController,
                        addressController: _addressController,
                        birthDateController: _birthDateController,
                        birthDateOnTapHandler: (date) => _setBirthDate(date),
                        nextTabHandler: () => _nextTab(_formKey1),
                      ),
                    ),
                  ),
                  KeepAliveWrapper(
                    child: Form(
                      key: _formKey2,
                      child: buildLoginCred(
                        context: context,
                        tabController: _tabController,
                        usernameController: _usernameController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                        showPassword: _showPassword,
                        togglePassIconHandler: () => _setTogglePassword(),
                        onRegisterHandler: _register,
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
        _showPassword = !_showPassword;
      });

  void _setBirthDate(date) => setState(() {
        _birthDateController.text = DateFormat('yyyy-MM-dd').format(date);
      });
}
