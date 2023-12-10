import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/auth_controller.dart';
import 'package:ebayan/controller/brgy_controller.dart';
import 'package:ebayan/data/model/barangay_model.dart';
import 'package:ebayan/data/model/municipality_model.dart';
import 'package:ebayan/data/model/user_model.dart';
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

import 'widgets/form_step_1.dart';
import 'widgets/form_step_2.dart';
import 'widgets/form_step_3.dart';
import 'widgets/heading.dart';
import 'widgets/tab_bar.dart';

class RegisterOfficialScreen extends StatefulWidget {
  const RegisterOfficialScreen({super.key});

  @override
  State<RegisterOfficialScreen> createState() => _RegisterOfficialScreenState();
}

class _RegisterOfficialScreenState extends State<RegisterOfficialScreen> with SingleTickerProviderStateMixin {
  final RegisterController registerController = RegisterController();
  final BarangayController brgyController = BarangayController();
  final EBCustomLoadingScreen loadingScreen = const EBCustomLoadingScreen();

  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();

  late TabController tabController;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  final TextEditingController municipalityController = TextEditingController();
  final TextEditingController barangayController = TextEditingController();
  final TextEditingController proofDocController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool showPassword = false;
  bool isBrgyFieldEnabled = false;
  String selectedBarangayId = '';
  String docFilePath = '';

  int progressCurrentIndex = 1;
  int tabLength = 3;

  List<MunicipalityModel> listOfMunicipalities = [];
  List<BarangayModel> listOfBarangay = [];

  @override
  void initState() {
    connectionHandler(context);
    super.initState();

    _fetchMunicipalities();

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
    municipalityController.dispose();
    barangayController.dispose();
    proofDocController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _nextTab(GlobalKey<FormState> formKey) {
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

  void _fetchMunicipalities() {
    brgyController.fetchMunicipalities().then((data) {
      listOfMunicipalities = data;
    }).catchError((err) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(EBSnackBar.info(text: err));
    });
  }

  void _fetchBarangay(muniUid) {
    brgyController.fetchBarangaysFromMunicipality(muniUid).then((data) {
      listOfBarangay = data;
    }).catchError((err) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(EBSnackBar.info(text: err));
    });
  }

  void _register() async {
    loadingScreen.show(context);

    bool isForm1Valid = formKey1.currentState?.validate() == true;
    bool isForm2Valid = formKey2.currentState?.validate() == true;
    bool isForm3Valid = formKey3.currentState?.validate() == true;

    if (isForm1Valid && isForm2Valid && isForm3Valid) {
      try {
        UserModel model = UserModel(
          userType: UserType.official,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          contactNumber: contactNumberController.text,
          address: addressController.text,
          birthDate: birthDateController.text,
          barangayAssociated: selectedBarangayId,
          isApproved: false,
          proofOfOfficial: File(docFilePath),
          username: emailController.text,
          password: passwordController.text,
        );

        // call the controller register function
        await registerController.registerAsOfficial(model);

        if (context.mounted) {
          loadingScreen.hide(context);
          Navigator.of(context).pushReplacement(createRoute(route: Routes.registerOfficialWaitlist, args: {'email': model.email}));
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
                        nextTabHandler: () => _nextTab(formKey1),
                      ),
                    ),
                  ),
                  KeepAliveWrapper(
                    child: Form(
                      key: formKey2,
                      child: buildBarangayAssociation(
                        context: context,
                        isBrgyFieldEnabled: isBrgyFieldEnabled,
                        tabController: tabController,
                        municipalityController: municipalityController,
                        barangayController: barangayController,
                        proofDocController: proofDocController,
                        setFilePath: (result) => _setDocFilePath(result),
                        municipalityOnTapHandler: () => _showMunicipalityPicker(),
                        barangayOnTapHandler: () => _showBarangayPicker(),
                        onClearFieldsHandler: _clearFormStep2Fields,
                        nextTabHandler: () => _nextTab(formKey2),
                      ),
                    ),
                  ),
                  KeepAliveWrapper(
                    child: Form(
                      key: formKey3,
                      child: buildLoginCred(
                        context: context,
                        tabController: tabController,
                        usernameController: usernameController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        showPassword: showPassword,
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
        showPassword = !showPassword;
      });

  void _setDocFilePath(result) => setState(() {
        docFilePath = result.files.single.path!;
      });

  void _setBirthDate(date) => setState(() {
        birthDateController.text = DateFormat('yyyy-MM-dd').format(date);
      });

  void _showMunicipalityPicker() {
    BottomPicker(
      items: listOfMunicipalities
          .map(
            (municipality) => Text(
              municipality.municipality,
              style: const TextStyle(
                fontFamily: EBTypography.fontFamily,
                fontSize: EBFontSize.normal,
              ),
            ),
          )
          .toList(),
      onSubmit: (index) {
        var docId = listOfMunicipalities[index].zipCode.toString();
        var selectedMunicipality = listOfMunicipalities[index].municipality;

        municipalityController.text = selectedMunicipality;
        barangayController.text = '';

        setState(() {
          isBrgyFieldEnabled = false;
        });

        _fetchBarangay(docId);

        setState(() {
          isBrgyFieldEnabled = true;
        });
      },
      title: 'Select a municipality',
      iconColor: EBColor.light,
      closeIconColor: EBColor.primary,
      buttonSingleColor: EBColor.primary,
    ).show(context);
  }

  void _showBarangayPicker() {
    BottomPicker(
      items: listOfBarangay
          .map(
            (barangay) => Text(
              barangay.name,
              style: const TextStyle(
                fontFamily: EBTypography.fontFamily,
                fontSize: EBFontSize.normal,
              ),
            ),
          )
          .toList(),
      onSubmit: (index) {
        setState(() {
          barangayController.text = listOfBarangay[index].name;
          selectedBarangayId = listOfBarangay[index].code.toString();
        });
      },
      title: '',
      iconColor: EBColor.light,
      closeIconColor: EBColor.primary,
      buttonSingleColor: EBColor.primary,
    ).show(context);
  }

  void _clearFormStep2Fields() {
    municipalityController.text = '';
    barangayController.text = '';
    proofDocController.text = '';
    docFilePath = '';

    setState(() => isBrgyFieldEnabled = false);
  }
}
