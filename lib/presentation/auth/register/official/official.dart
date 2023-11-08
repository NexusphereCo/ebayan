import 'package:bottom_picker/bottom_picker.dart';
import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/auth_controller.dart';
import 'package:ebayan/data/model/barangay_model.dart';
import 'package:ebayan/data/model/municipality_model.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/progress_indicator.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/widgets/shared/appbar_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

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
  final Logger log = Logger();

  // official controller
  RegisterOfficialController registerController = RegisterOfficialController();

  // formkey
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // tab controller
  late TabController _tabController;

  // form step 1 controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  // form step 2 controllers
  final TextEditingController _municipalityController = TextEditingController();
  final TextEditingController _barangayController = TextEditingController();
  final TextEditingController _proofDocController = TextEditingController();

  // form step 3 controllers
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // variables
  bool _showPassword = false;
  bool _isBrgyFieldEnabled = false;

  // tabbar
  int progressCurrentIndex = 1;
  int tabLength = 3;

  List<MunicipalityModel> listOfMunicipalities = [];
  List<BarangayModel> listOfBarangay = [];

  Future<void> _fetchMunicipalities() async {
    registerController.fetchMunicipalities().then((data) {
      listOfMunicipalities = data;
    }).catchError((err) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(snackBar(text: err));
    });
  }

  Future<void> _fetchBarangay(muniUid) async {
    registerController.fetchBarangay(muniUid).then((data) {
      listOfBarangay = data;
    }).catchError((err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar(text: err.toString()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _fetchMunicipalities();

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
    _municipalityController.dispose();
    _barangayController.dispose();
    _proofDocController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _nextTab(GlobalKey<FormState> formKey) {
    if (_tabController.index < _tabController.length - 1) {
      if (formKey.currentState?.validate() == true) {
        _tabController.animateTo(_tabController.index + 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabLength,
      child: Scaffold(
        appBar: EBAppBarBack(
          title: Wrap(
            spacing: Spacing.sm,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              EBTypography.h3(
                text: 'Register',
                color: EBColor.primary,
              ),
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
            Form(
              key: _formKey,
              child: Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    buildPersonalInfo(
                      context: context,
                      firstNameController: _firstNameController,
                      lastNameController: _lastNameController,
                      emailController: _emailController,
                      contactNumberController: _contactNumberController,
                      addressController: _addressController,
                      birthDateController: _birthDateController,
                      birthDateOnSubmitHandler: (date) {
                        setState(() {
                          _birthDateController.text = DateFormat('yyyy-MM-dd').format(date);
                        });
                      },
                      nextTabHandler: () {
                        _nextTab(_formKey);
                      },
                    ),
                    buildBarangayAssociation(
                      context: context,
                      isBrgyFieldEnabled: _isBrgyFieldEnabled,
                      tabController: _tabController,
                      municipalityController: _municipalityController,
                      barangayController: _barangayController,
                      proofDocController: _proofDocController,
                      municipalityOnTapHandler: () {
                        BottomPicker(
                          items: [
                            for (int i = 0; i < listOfMunicipalities.length; i++)
                              Text(
                                listOfMunicipalities[i].municipality,
                                style: const TextStyle(
                                  fontFamily: EBTypography.fontFamily,
                                  fontSize: EBFontSize.normal,
                                ),
                              )
                          ],
                          onSubmit: (index) {
                            setState(() {
                              _municipalityController.text = listOfMunicipalities[index].municipality;
                              _barangayController.text = '';
                              _isBrgyFieldEnabled = true;
                              _fetchBarangay(listOfMunicipalities[index].zipCode.toString());
                            });
                          },
                          title: '',
                          iconColor: EBColor.light,
                          closeIconColor: EBColor.primary,
                          buttonSingleColor: EBColor.primary,
                        ).show(context);
                      },
                      barangayOnTapHandler: () {
                        BottomPicker(
                          items: [
                            for (int i = 0; i < listOfBarangay.length; i++)
                              Text(
                                listOfBarangay[i].name,
                                style: const TextStyle(
                                  fontFamily: EBTypography.fontFamily,
                                  fontSize: EBFontSize.normal,
                                ),
                              )
                          ],
                          onSubmit: (index) {
                            setState(() {
                              _barangayController.text = listOfBarangay[index].name;
                            });
                          },
                          title: '',
                          iconColor: EBColor.light,
                          closeIconColor: EBColor.primary,
                          buttonSingleColor: EBColor.primary,
                        ).show(context);
                      },
                      onClearFieldsHandler: () {
                        _municipalityController.text = '';
                        _barangayController.text = '';
                        _proofDocController.text = '';

                        setState(() => _isBrgyFieldEnabled = false);
                      },
                      nextTabHandler: () {
                        _nextTab(_formKey);
                      },
                    ),
                    buildLoginCred(
                      context: context,
                      tabController: _tabController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      isBrgyFieldEnabled: _isBrgyFieldEnabled,
                      showPassword: _showPassword,
                      togglePassIconHandler: () => setState(() => _showPassword = !_showPassword),
                      onRegisterHandler: () {},
                    ),
                  ],
                ),
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
}
