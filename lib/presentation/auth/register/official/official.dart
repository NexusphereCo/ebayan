import 'package:bottom_picker/bottom_picker.dart';
import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/controller/auth_controller.dart';
import 'package:ebayan/data/model/barangay_model.dart';
import 'package:ebayan/data/model/municipality_model.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:ebayan/widgets/components/progress_indicator.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/widgets/shared/appbar_back.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class RegisterOfficialScreen extends StatefulWidget {
  const RegisterOfficialScreen({super.key});

  @override
  State<RegisterOfficialScreen> createState() => _RegisterOfficialScreenState();
}

class _RegisterOfficialScreenState extends State<RegisterOfficialScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();

  final Logger logger = Logger();

  late TabController _tabController;
  RegisterOfficialController registerController = RegisterOfficialController();

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
  // show password
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
    _municipalityController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  void _nextTab(GlobalKey<FormState> formKey) {
    if (_tabController.index < _tabController.length - 1) {
      if (formKey.currentState?.validate() == true) {
        _tabController.animateTo(_tabController.index + 1);
      }
    }
  }

  void _prevTab() {
    _tabController.animateTo(_tabController.index - 1);
  }

  void clearFields(List<TextEditingController> controllers) {
    for (var controller in controllers) {
      controller.text = '';
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
            _buildTabBar(),
            const SizedBox(height: Spacing.lg),
            _buildHeading(),
            const SizedBox(height: Spacing.md),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  _buildPersonalInfo(),
                  _buildBarangayAssociation(),
                  _buildLoginCred(),
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

  IgnorePointer _buildTabBar() {
    return IgnorePointer(
      child: TabBar(
        controller: _tabController,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        indicator: BoxDecoration(
          color: EBColor.primary[50],
          border: Border(bottom: BorderSide(color: EBColor.primary, width: 2.0)),
        ),
        tabs: [
          Tab(
            child: Text(
              'Information',
              style: TextStyle(
                fontFamily: EBTypography.fontFamily,
                color: EBColor.primary,
              ),
            ),
          ),
          Tab(
            child: Text(
              'Barangay',
              style: TextStyle(
                fontFamily: EBTypography.fontFamily,
                color: EBColor.primary,
              ),
            ),
          ),
          Tab(
            child: Text(
              'Credentials',
              style: TextStyle(
                fontFamily: EBTypography.fontFamily,
                color: EBColor.primary,
              ),
            ),
          ),
        ],
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
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
          child: Form(
            key: _formKey1,
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
                        Flexible(
                          child: EBTextField(
                            controller: _firstNameController,
                            label: 'First Name',
                            type: TextInputType.name,
                            validator: (value) {
                              value = value?.trim();
                              if (value == null || value.isEmpty) return Validation.missingField;
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: Spacing.sm),
                        Flexible(
                          child: EBTextField(
                            controller: _lastNameController,
                            label: 'Last Name',
                            type: TextInputType.name,
                            validator: (value) {
                              value = value?.trim();
                              if (value == null || value.isEmpty) return Validation.missingField;
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.md),
                    EBTextBox(
                      icon: FeatherIcons.mail,
                      textField: EBTextField(
                        controller: _emailController,
                        label: 'Email',
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          value = value?.trim();
                          final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

                          if (value == null || value.isEmpty) {
                            return Validation.missingField;
                          } else if (!emailRegExp.hasMatch(value)) {
                            return Validation.invalidEmail;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: Spacing.md),
                    EBTextBox(
                      icon: FeatherIcons.phone,
                      textField: EBTextField(
                        controller: _contactNumberController,
                        label: 'Contact Number',
                        type: TextInputType.phone,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        maxLength: 11,
                        validator: (value) {
                          value = value?.trim();
                          final phoneRegExp = RegExp(r'^\d{11}$');
                          if (value == null || value.isEmpty) {
                            return Validation.missingField;
                          } else if (!phoneRegExp.hasMatch(value)) {
                            return Validation.invalidPhoneNumber;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: Spacing.md),
                    EBTextBox(
                      icon: FeatherIcons.mapPin,
                      textField: EBTextField(
                        controller: _addressController,
                        label: 'Address',
                        type: TextInputType.text,
                        validator: (value) {
                          value = value?.trim();
                          if (value == null || value.isEmpty) return Validation.missingField;
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: Spacing.md),
                    EBTextBox(
                      icon: FeatherIcons.calendar,
                      textField: EBTextField(
                        controller: _birthDateController,
                        readOnly: true,
                        label: 'Birth Date',
                        type: TextInputType.datetime,
                        onTap: () {
                          BottomPicker.date(
                            title: '',
                            onSubmit: (date) {
                              setState(() {
                                _birthDateController.text = DateFormat('yyyy-MM-dd').format(date);
                              });
                            },
                            maxDateTime: DateTime.now(),
                            iconColor: EBColor.light,
                            closeIconColor: EBColor.primary,
                            buttonSingleColor: EBColor.primary,
                          ).show(context);
                        },
                        validator: (value) {
                          value = value?.trim();
                          if (value == null || value.isEmpty) return Validation.missingField;
                          return null;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: Spacing.sm),
                            EBTypography.small(text: 'YYYY-MM-DD', muted: true),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => clearFields(
                            [
                              _firstNameController,
                              _lastNameController,
                              _emailController,
                              _contactNumberController,
                              _addressController,
                              _birthDateController,
                            ],
                          ),
                          child: EBTypography.text(
                            text: 'Clear Information',
                            color: EBColor.red,
                            fontWeight: EBFontWeight.bold,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: Spacing.sm),
                        EBButton(
                          text: 'Next',
                          theme: EBButtonTheme.primary,
                          onPressed: () => _nextTab(_formKey1),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBarangayAssociation() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
          child: Form(
            key: _formKey2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EBTypography.label(text: 'Barangay Association'),
                const SizedBox(height: Spacing.md),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    EBTextBox(
                      icon: FeatherIcons.map,
                      textField: EBTextField(
                        controller: _municipalityController,
                        readOnly: true,
                        label: 'Select Municipality',
                        type: TextInputType.datetime,
                        suffixIcon: Container(
                          margin: const EdgeInsets.symmetric(vertical: Spacing.md),
                          child: const FaIcon(FontAwesomeIcons.angleDown),
                        ),
                        onTap: () {
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
                        validator: (value) {
                          value = value?.trim();
                          if (value == null || value.isEmpty) return Validation.missingField;
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: Spacing.md),
                    EBTextBox(
                      icon: EBIcons.home,
                      textField: EBTextField(
                        controller: _barangayController,
                        enabled: _isBrgyFieldEnabled,
                        readOnly: true,
                        label: 'Barangay Associated',
                        type: TextInputType.datetime,
                        suffixIcon: Container(
                          margin: const EdgeInsets.symmetric(vertical: Spacing.md),
                          child: const FaIcon(FontAwesomeIcons.angleDown),
                        ),
                        onTap: () {
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
                        validator: (value) {
                          value = value?.trim();
                          if (value == null || value.isEmpty) return Validation.missingField;
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: Spacing.md),
                    EBTextBox(
                      icon: FeatherIcons.file,
                      textField: EBTextField(
                        controller: _proofDocController,
                        readOnly: true,
                        label: 'Proof of Official',
                        type: TextInputType.text,
                        validator: (value) {
                          value = value?.trim();
                          if (value == null || value.isEmpty) return Validation.missingField;
                          return null;
                        },
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                          );

                          // the user has selected a file
                          if (result != null) {
                            String fileName = result.files.first.name;

                            _proofDocController.text = fileName;
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: Spacing.sm),
                            EBTypography.small(text: 'PDF', muted: true),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.md),
                    EBTypography.text(
                      text: 'Approval may take a few days as we review your submission. We\'ll notify you once it\'s approved through your contact number.',
                      muted: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            clearFields(
                              [
                                _municipalityController,
                                _barangayController,
                                _proofDocController,
                              ],
                            );
                            setState(() => _isBrgyFieldEnabled = false);
                          },
                          child: EBTypography.text(
                            text: 'Clear Information',
                            color: EBColor.red,
                            fontWeight: EBFontWeight.bold,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        EBButton(
                          text: 'Previous',
                          theme: EBButtonTheme.primaryOutlined,
                          onPressed: () => _prevTab(),
                        ),
                        const SizedBox(width: Spacing.sm),
                        EBButton(
                          text: 'Next',
                          theme: EBButtonTheme.primary,
                          onPressed: () => _nextTab(_formKey2),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
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
          child: Form(
            key: _formKey3,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const EBTextBox(
                      icon: FeatherIcons.user,
                      textField: EBTextField(
                        enabled: false,
                        label: 'Username',
                        type: TextInputType.text,
                      ),
                    ),
                    const SizedBox(height: Spacing.md),
                    EBTextBox(
                      icon: FeatherIcons.lock,
                      textField: EBTextField(
                        controller: _passwordController,
                        label: 'Password',
                        type: TextInputType.text,
                        obscureText: _showPassword ? false : true,
                        suffixIconButton: IconButton(
                          icon: _showPassword ? const Icon(FeatherIcons.eye) : const Icon(FeatherIcons.eyeOff),
                          onPressed: () {
                            setState(() => _showPassword = !_showPassword);
                          },
                        ),
                        validator: (value) {
                          value = value?.trim();
                          if (value == null || value.isEmpty) return Validation.missingField;
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: Spacing.md),
                    EBTextBox(
                      icon: FeatherIcons.lock,
                      textField: EBTextField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        type: TextInputType.text,
                        obscureText: _showPassword ? false : true,
                        suffixIconButton: IconButton(
                          icon: _showPassword ? const Icon(FeatherIcons.eye) : const Icon(FeatherIcons.eyeOff),
                          onPressed: () {
                            setState(() => _showPassword = !_showPassword);
                          },
                        ),
                        validator: (value) {
                          value = value?.trim();
                          if (value == null || value.isEmpty) return Validation.missingField;
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => clearFields(
                        [
                          _passwordController,
                          _confirmPasswordController,
                        ],
                      ),
                      child: EBTypography.text(
                        text: 'Clear Information',
                        color: EBColor.red,
                        fontWeight: EBFontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    EBButton(
                      text: 'Previous',
                      theme: EBButtonTheme.primaryOutlined,
                      onPressed: () => _prevTab(),
                    ),
                    const SizedBox(width: Spacing.sm),
                    EBButton(
                      text: 'Register',
                      icon: const Icon(
                        FeatherIcons.arrowRight,
                        size: EBFontSize.normal,
                      ),
                      theme: EBButtonTheme.primary,
                      onPressed: () {
                        // validate fields
                        // if (_formKey3.currentState?.validate() == true) {
                        //   _register();
                        // Navigator.of(context).push(createRoute('/dashboard'));
                        // }
                        logger.w('${_formKey1.currentState?.mounted} | ${_formKey2.currentState?.mounted} | ${_formKey3.currentState?.mounted}');
                      },
                    ),
                  ],
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
        ),
      ],
    );
  }
}
