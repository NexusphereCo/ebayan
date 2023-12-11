import 'package:bottom_picker/bottom_picker.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/model/user_model.dart';
import 'package:ebayan/data/viewmodel/user_view_model.dart';
import 'package:ebayan/presentation/auth/account/info.dart';
import 'package:ebayan/presentation/auth/account/widgets/change_password_modal.dart';
import 'package:ebayan/presentation/auth/account/widgets/confirm_logout_modal.dart';
import 'package:ebayan/presentation/auth/account/widgets/large_button.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/widgets/utils/fade_in.dart';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
  final GlobalKey<FormState> formKey = GlobalKey();
  final EBCustomLoadingScreen loadingScreen = const EBCustomLoadingScreen();
  final UserController userController = UserController();

  // Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Variables
  bool isEditing = false;
  final inputDecoration = InputDecoration(
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
    firstNameController.text = widget.userData.firstName;
    lastNameController.text = widget.userData.lastName;
    contactNumberController.text = widget.userData.contactNumber;
    birthDateController.text = widget.userData.birthDate;
    addressController.text = widget.userData.address;
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    contactNumberController.dispose();
    addressController.dispose();
    birthDateController.dispose();
  }

  Future<void> _saveInfo() async {
    loadingScreen.show(context);
    bool isFormValid = formKey.currentState?.validate() == true;

    if (isFormValid) {
      // Map to the [UserModel]
      UserUpdateModel data = UserUpdateModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        birthDate: birthDateController.text,
        contactNumber: contactNumberController.text,
        address: addressController.text,
      );

      // Call the usercontroller's updateInfo
      await userController.updateInfo(data).then(
        (value) {
          // Return to this page and prompt a successful snackbar message
          setState(() => isEditing = false);

          widget.parent.refresh();

          loadingScreen.hide(context);
          ScaffoldMessenger.of(context).showSnackBar(
            EBSnackBar.info(text: 'Successfully updated user.'),
          );
        },
      ).catchError(
        (err) {
          loadingScreen.hide(context);
          ScaffoldMessenger.of(context).showSnackBar(
            EBSnackBar.info(text: Validation.requiresRecentLogin),
          );
        },
      );
    } else {
      loadingScreen.hide(context);
      ScaffoldMessenger.of(context).showSnackBar(
        EBSnackBar.info(text: 'Invalid form! Please make sure to fill in the required fields.'),
      );
    }
  }

  void _toggleEditing() {
    return setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Padding(
        padding: const EdgeInsets.all(Global.paddingBody),
        child: Form(
          key: formKey,
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
                                  text: (isEditing) ? 'Discard' : 'Edit',
                                  color: (isEditing) ? EBColor.red : EBColor.green,
                                ),
                                const SizedBox(width: Spacing.sm),
                                Icon(
                                  FeatherIcons.edit,
                                  color: (isEditing) ? EBColor.red : EBColor.green,
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
                          (isEditing)
                              ? Expanded(
                                  child: TextFormField(
                                    controller: firstNameController,
                                    keyboardType: TextInputType.name,
                                    style: const TextStyle(fontSize: EBFontSize.normal),
                                    decoration: inputDecoration,
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
                          (isEditing)
                              ? Expanded(
                                  child: TextFormField(
                                    controller: lastNameController,
                                    keyboardType: TextInputType.name,
                                    style: const TextStyle(fontSize: EBFontSize.normal),
                                    decoration: inputDecoration,
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
                          (isEditing)
                              ? Expanded(
                                  child: TextFormField(
                                    controller: birthDateController,
                                    style: const TextStyle(fontSize: EBFontSize.normal),
                                    decoration: inputDecoration,
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
                          (isEditing)
                              ? Expanded(
                                  child: TextFormField(
                                    controller: contactNumberController,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    maxLength: 11,
                                    style: const TextStyle(fontSize: EBFontSize.normal),
                                    decoration: inputDecoration,
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
                      (isEditing)
                          ? TextFormField(
                              controller: addressController,
                              style: const TextStyle(fontSize: EBFontSize.normal),
                              decoration: inputDecoration,
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
                      (isEditing)
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
        birthDateController.text = DateFormat('yyyy-MM-dd').format(date);
      }),
      title: '',
      maxDateTime: DateTime.now(),
      iconColor: EBColor.light,
      closeIconColor: EBColor.primary,
      buttonSingleColor: EBColor.primary,
    );
  }
}
