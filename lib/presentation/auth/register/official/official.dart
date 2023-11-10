import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/auth_controller.dart';
import 'package:ebayan/data/model/barangay_model.dart';
import 'package:ebayan/data/model/municipality_model.dart';
import 'package:ebayan/data/model/register_model.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/progress_indicator.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/widgets/shared/appbar_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'widgets/form_step_1.dart';
import 'widgets/form_step_2.dart';
import 'widgets/form_step_3.dart';
import 'widgets/heading.dart';
import 'widgets/tab_bar.dart';

class RegisterOfficialScreen extends StatefulWidget {
  const RegisterOfficialScreen({Key? key}) : super(key: key);

  @override
  State<RegisterOfficialScreen> createState() => _RegisterOfficialScreenState();
}

class _RegisterOfficialScreenState extends State<RegisterOfficialScreen> with SingleTickerProviderStateMixin {
  final RegisterOfficialController _registerController = RegisterOfficialController();
  final EBLoadingScreen loadingScreen = const EBLoadingScreen();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TabController _tabController;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  final TextEditingController _municipalityController = TextEditingController();
  final TextEditingController _barangayController = TextEditingController();
  final TextEditingController _proofDocController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _showPassword = false;
  bool _isBrgyFieldEnabled = false;
  String _selectedMuniId = '';
  String _selectedBarangayId = '';
  String _docFilePath = '';

  int progressCurrentIndex = 1;
  int tabLength = 3;

  List<MunicipalityModel> listOfMunicipalities = [];
  List<BarangayModel> listOfBarangay = [];

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

  Future<void> _fetchMunicipalities() async {
    loadingScreen.show(context);
    _registerController.fetchMunicipalities().then((data) {
      listOfMunicipalities = data;
    }).catchError((err) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(snackBar(text: err));
    });
    loadingScreen.hide(context);
  }

  Future<void> _fetchBarangay(muniUid) async {
    loadingScreen.show(context);
    _registerController.fetchBarangaysFromMunicipality(muniUid).then((data) {
      listOfBarangay = data;
    }).catchError((err) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(snackBar(text: err));
    });
    loadingScreen.hide(context);
  }

  void _register() async {
    loadingScreen.show(context);

    if (_formKey.currentState?.validate() == true) {
      try {
        // get the document references
        DocumentReference muniDocRef = _registerController.fetchMunicipality(_selectedMuniId);
        DocumentReference brgyDocRef = _registerController.fetchBarangay(_selectedMuniId, _selectedBarangayId);

        // map the data to a [RegisterOfficialModel] model
        RegisterOfficialModel model = RegisterOfficialModel(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          contactNumber: _contactNumberController.text,
          address: _addressController.text,
          birthDate: _birthDateController.text,
          municipality: muniDocRef,
          barangayAssociated: brgyDocRef,
          isApproved: false,
          proofOfOfficial: File(_docFilePath),
          username: _emailController.text,
          password: _passwordController.text,
        );

        // call the controller register() function
        await _registerController.register(model).then((value) {
          Navigator.of(context).push(createRoute('/dashboard'));
        });

        if (context.mounted) loadingScreen.hide(context);
      } catch (err) {
        if (context.mounted) {
          loadingScreen.hide(context);
          ScaffoldMessenger.of(context).showSnackBar(snackBar(text: err.toString()));
        }
      }
    }

    if (context.mounted) loadingScreen.hide(context);
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
                      birthDateOnTapHandler: (date) => _setBirthDate(date),
                      nextTabHandler: () => _nextTab(_formKey),
                    ),
                    buildBarangayAssociation(
                      context: context,
                      isBrgyFieldEnabled: _isBrgyFieldEnabled,
                      tabController: _tabController,
                      municipalityController: _municipalityController,
                      barangayController: _barangayController,
                      proofDocController: _proofDocController,
                      setFilePath: (result) => _setDocFilePath(result),
                      municipalityOnTapHandler: () => _showMunicipalityPicker(),
                      barangayOnTapHandler: () => _showBarangayPicker(),
                      onClearFieldsHandler: _clearFormStep2Fields,
                      nextTabHandler: () => _nextTab(_formKey),
                    ),
                    buildLoginCred(
                      context: context,
                      tabController: _tabController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      showPassword: _showPassword,
                      togglePassIconHandler: () => _setTogglePassword(),
                      onRegisterHandler: _register,
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

  // Frontend scripts
  void _setTogglePassword() => setState(() {
        _showPassword = !_showPassword;
      });

  void _setDocFilePath(result) => setState(() {
        _docFilePath = result.files.single.path!;
      });

  void _setBirthDate(date) => setState(() {
        _birthDateController.text = DateFormat('yyyy-MM-dd').format(date);
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
        setState(() {
          var docId = listOfMunicipalities[index].zipCode.toString();
          var selectedMunicipality = listOfMunicipalities[index].municipality;

          _municipalityController.text = selectedMunicipality;
          _selectedMuniId = docId;
          _barangayController.text = '';
          _isBrgyFieldEnabled = true;

          _fetchBarangay(docId);
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
          _barangayController.text = listOfBarangay[index].name;
          _selectedBarangayId = listOfBarangay[index].code.toString();
        });
      },
      title: '',
      iconColor: EBColor.light,
      closeIconColor: EBColor.primary,
      buttonSingleColor: EBColor.primary,
    ).show(context);
  }

  void _clearFormStep2Fields() {
    _municipalityController.text = '';
    _barangayController.text = '';
    _proofDocController.text = '';
    _docFilePath = '';

    setState(() => _isBrgyFieldEnabled = false);
  }
}
