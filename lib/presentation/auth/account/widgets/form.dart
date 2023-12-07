import 'package:bottom_picker/bottom_picker.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/model/user_model.dart';
import 'package:ebayan/data/viewmodel/user_view_model.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/widgets/utils/fade_in.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../info.dart';
import 'change_password_modal.dart';
import 'confirm_logout_modal.dart';
import 'large_button.dart';

class AccountInfoForm extends StatefulWidget {
  final AccountScreenState parent;
  final UserViewModel userData;

  const AccountInfoForm({
    super.key,
    required this.userData,
    required this.parent,
  });

  @override
  State<AccountInfoForm> createState() => _AccountInfoFormState();
}

class _AccountInfoFormState extends State<AccountInfoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final EBLoadingScreen _loadingScreen = const EBLoadingScreen();
  final UserController _userController = UserController();

  // controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // variables
  bool _isEditing = false;
  final _inputDecoration = InputDecoration(
    contentPadding: EdgeInsets.zero,
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: EBColor.dark[50]!)),
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: EBColor.primary)),
    errorStyle: const TextStyle(height: 0),
    counterText: '',
    isDense: true,
  );

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.userData.firstName;
    _lastNameController.text = widget.userData.lastName;
    _contactNumberController.text = widget.userData.contactNumber;
    _birthDateController.text = widget.userData.birthDate;
    _addressController.text = widget.userData.address;
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _contactNumberController.dispose();
    _addressController.dispose();
    _birthDateController.dispose();
  }

  Future<void> _saveInfo() async {
    _loadingScreen.show(context);
    bool isFormValid = _formKey.currentState?.validate() == true;

    if (isFormValid) {
      // map to the [UserModel]
      UserUpdateModel data = UserUpdateModel(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        birthDate: _birthDateController.text,
        contactNumber: _contactNumberController.text,
        address: _addressController.text,
      );

      // call the usercontroller's updateInfo
      await _userController.updateInfo(data).then(
        (value) {
          // return to this page and prompt a successful snackbar message
          setState(() => _isEditing = false);

          widget.parent.refresh();

          _loadingScreen.hide(context);
          ScaffoldMessenger.of(context).showSnackBar(
            EBSnackBar.info(text: 'Successfully updated user.'),
          );
        },
      ).catchError(
        (err) {
          _loadingScreen.hide(context);
          ScaffoldMessenger.of(context).showSnackBar(
            EBSnackBar.info(text: Validation.requiresRecentLogin),
          );
        },
      );
    } else {
      _loadingScreen.hide(context);
      ScaffoldMessenger.of(context).showSnackBar(
        EBSnackBar.info(text: 'Invalid form! Please make sure to fill in the required fields.'),
      );
    }
  }

  void _toggleEditing() {
    return setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Padding(
        padding: const EdgeInsets.all(Global.paddingBody),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: EBColor.light,
                  borderRadius: BorderRadius.circular(EBBorderRadius.lg),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 30,
                      color: EBColor.primary.withOpacity(0.25),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Spacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: EBBorderRadius.md, vertical: EBBorderRadius.sm),
                            decoration: BoxDecoration(
                              color: EBColor.green,
                              borderRadius: const BorderRadius.all(Radius.circular(EBBorderRadius.lg)),
                            ),
                            child: EBTypography.label(text: widget.userData.userType, color: EBColor.light),
                          ),
                          TextButton(
                            onPressed: () => _toggleEditing(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                EBTypography.label(
                                  text: (_isEditing) ? 'Discard' : 'Edit',
                                  color: (_isEditing) ? EBColor.red : EBColor.green,
                                ),
                                const SizedBox(width: Spacing.sm),
                                Icon(
                                  FeatherIcons.edit,
                                  color: (_isEditing) ? EBColor.red : EBColor.green,
                                  size: EBFontSize.h4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Spacing.sm),
                      _buildHeading(icon: FeatherIcons.user, heading: 'Personal Information'),
                      const SizedBox(height: Spacing.md),
                      Row(
                        children: [
                          EBTypography.text(text: 'First Name:', muted: true),
                          const SizedBox(width: Spacing.sm),
                          (_isEditing)
                              ? Expanded(
                                  child: TextFormField(
                                    controller: _firstNameController,
                                    keyboardType: TextInputType.name,
                                    style: const TextStyle(fontSize: EBFontSize.normal),
                                    decoration: _inputDecoration,
                                    validator: (value) {
                                      value = value?.trim();
                                      if (value == null || value.isEmpty) return '';
                                      return null;
                                    },
                                  ),
                                )
                              : EBTypography.text(text: widget.userData.firstName, muted: true),
                        ],
                      ),
                      const SizedBox(height: Spacing.sm),
                      Row(
                        children: [
                          EBTypography.text(text: 'Last Name:', muted: true),
                          const SizedBox(width: Spacing.sm),
                          (_isEditing)
                              ? Expanded(
                                  child: TextFormField(
                                    controller: _lastNameController,
                                    keyboardType: TextInputType.name,
                                    style: const TextStyle(fontSize: EBFontSize.normal),
                                    decoration: _inputDecoration,
                                    validator: (value) {
                                      value = value?.trim();
                                      if (value == null || value.isEmpty) return '';
                                      return null;
                                    },
                                  ),
                                )
                              : EBTypography.text(text: widget.userData.lastName, muted: true),
                        ],
                      ),
                      const SizedBox(height: Spacing.sm),
                      Row(
                        children: [
                          EBTypography.text(text: 'Birth Date:', muted: true),
                          const SizedBox(width: Spacing.sm),
                          (_isEditing)
                              ? Expanded(
                                  child: TextFormField(
                                    controller: _birthDateController,
                                    style: const TextStyle(fontSize: EBFontSize.normal),
                                    decoration: _inputDecoration,
                                    readOnly: true,
                                    onTap: () => _showDatePicker().show(context),
                                  ),
                                )
                              : EBTypography.text(text: DateFormat('MMM dd, yyyy').format(DateTime.parse(widget.userData.birthDate)), muted: true),
                        ],
                      ),
                      const SizedBox(height: Spacing.lg),
                      _buildHeading(icon: FeatherIcons.phone, heading: 'Contact Information'),
                      const SizedBox(height: Spacing.md),
                      Row(
                        children: [
                          EBTypography.text(text: 'Phone No.:', muted: true),
                          const SizedBox(width: Spacing.sm),
                          (_isEditing)
                              ? Expanded(
                                  child: TextFormField(
                                    controller: _contactNumberController,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    maxLength: 11,
                                    style: const TextStyle(fontSize: EBFontSize.normal),
                                    decoration: _inputDecoration,
                                    validator: (value) {
                                      value = value?.trim();
                                      final phoneRegExp = RegExp(r'^\d{11}$');
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      } else if (!phoneRegExp.hasMatch(value)) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                              : EBTypography.text(text: widget.userData.contactNumber, muted: true),
                        ],
                      ),
                      const SizedBox(height: Spacing.sm),
                      Row(
                        children: [
                          EBTypography.text(text: 'Email Address:', muted: true),
                          const SizedBox(width: Spacing.sm),
                          EBTypography.text(text: widget.userData.email, muted: true),
                        ],
                      ),
                      const SizedBox(height: Spacing.lg),
                      _buildHeading(icon: FeatherIcons.mapPin, heading: 'Address'),
                      const SizedBox(height: Spacing.md),
                      (_isEditing)
                          ? TextFormField(
                              controller: _addressController,
                              style: const TextStyle(fontSize: EBFontSize.normal),
                              decoration: _inputDecoration,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              validator: (value) {
                                value = value?.trim();
                                if (value == null || value.isEmpty) return '';
                                return null;
                              },
                            )
                          : EBTypography.text(
                              text: widget.userData.address,
                              muted: true,
                              textAlign: TextAlign.start,
                            ),
                      const SizedBox(height: Spacing.md),
                      (_isEditing)
                          ? FadeIn(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  EBButton(
                                    onPressed: () => _saveInfo(),
                                    text: 'Save',
                                    theme: EBButtonTheme.successOutlined,
                                    icon: const Icon(FeatherIcons.arrowRight, size: EBFontSize.normal),
                                    size: EBButtonSize.sm,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Spacing.lg),
              LargeCustomButton(
                heading: 'Change Password',
                lead: 'Manage your login credentials',
                icon: Icon(FeatherIcons.lock, color: EBColor.light),
                onTap: () => showModalBottomSheet<void>(
                  isScrollControlled: true,
                  isDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return const ChangePasswordModalForm();
                  },
                ),
              ),
              const SizedBox(height: Spacing.sm),
              LargeCustomButton(
                heading: 'Logout',
                lead: 'Sign-out and come back for news later!',
                icon: Icon(FeatherIcons.logOut, color: EBColor.light),
                onTap: () => showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return LogoutModal();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildHeading({required String heading, required IconData icon}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: EBFontSize.h2),
        const SizedBox(width: Spacing.sm),
        EBTypography.h4(text: heading),
      ],
    );
  }

  BottomPicker _showDatePicker() {
    return BottomPicker.date(
      onSubmit: (date) => setState(() {
        _birthDateController.text = DateFormat('yyyy-MM-dd').format(date);
      }),
      title: '',
      maxDateTime: DateTime.now(),
      iconColor: EBColor.light,
      closeIconColor: EBColor.primary,
      buttonSingleColor: EBColor.primary,
    );
  }
}
