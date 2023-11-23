import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/model/user_model.dart';
import 'package:ebayan/data/viewmodel/user_view_model.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/widgets/shared/appbar_bottom.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'widgets/confirm_logout_modal.dart';
import 'widgets/form.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final UserController _userController = UserController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final EBLoadingScreen _loadingScreen = const EBLoadingScreen();

  // TextEditingController
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  // variables
  bool _isEditing = false;

  Future<UserViewModel> _fetchUserData() async {
    return await _userController.getCurrentUserInfo();
  }

  Future<void> _saveInfo() async {
    _loadingScreen.show(context);
    bool isFormValid = _formKey.currentState?.validate() == true;

    try {
      if (isFormValid) {
        // map to the [UserModel]
        UserUpdateModel data = UserUpdateModel(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          birthDate: _birthDateController.text,
          contactNumber: _contactNumberController.text,
          email: _emailController.text,
          address: _addressController.text,
        );

        // call the usercontroller's updateInfo
        await _userController.updateInfo(data);

        // return to this page and prompt a successful snackbar message
        setState(() {
          _isEditing = false;
        });

        if (context.mounted) {
          _loadingScreen.hide(context);
          ScaffoldMessenger.of(context).showSnackBar(EBSnackBar.info(text: 'Successfully updated user.'));
        }
      } else {
        throw 'Invalid form! Please make sure to fill in the required fields.';
      }
    } catch (e) {
      if (context.mounted) {
        _loadingScreen.hide(context);
        ScaffoldMessenger.of(context).showSnackBar(EBSnackBar.info(text: e.toString()));
      }
    }
  }

  Future<void> _logOut() async {
    _loadingScreen.show(context);

    await _userController.logOut();

    if (context.mounted) {
      _loadingScreen.hide(context);
      Navigator.of(context).push(createRoute(route: Routes.login));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(),
      drawer: const EBDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 0,
            child: SvgPicture.asset(
              Asset.illustAccInfoBackg,
              fit: BoxFit.fill,
            ),
          ),
          RefreshIndicator(
            color: EBColor.light,
            backgroundColor: EBColor.dullGreen,
            onRefresh: () async => setState(() {}),
            child: ListView(
              children: [
                const SizedBox(height: Spacing.md),
                EBTypography.h1(text: 'Account Information', textAlign: TextAlign.center),
                const SizedBox(height: Spacing.md),
                FutureBuilder(
                  future: _fetchUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildLoadingIndicator(context);
                    } else {
                      final UserViewModel user = snapshot.data!;

                      _firstNameController.text = user.firstName;
                      _lastNameController.text = user.lastName;
                      _birthDateController.text = user.birthDate;
                      _contactNumberController.text = user.contactNumber;
                      _emailController.text = user.email;
                      _addressController.text = user.address;

                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return buildForm(
                            context: context,
                            formKey: _formKey,
                            // variables
                            isEditing: _isEditing,
                            userData: user,
                            // controllers
                            firstNameController: _firstNameController,
                            lastNameController: _lastNameController,
                            contactNumberController: _contactNumberController,
                            emailController: _emailController,
                            addressController: _addressController,
                            birthDateController: _birthDateController,
                            birthDateOnTapHandler: (date) => setState(() {
                              _birthDateController.text = DateFormat('yyyy-MM-dd').format(date);
                            }),
                            onEditHandler: () => setState(() {
                              _isEditing = !_isEditing;
                            }),
                            onLogoutHandler: () => showConfirmLogoutModal(context: context, onProceedHandler: _logOut),
                            onSaveHandler: () => _saveInfo(),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const EBAppBarBottom(activeIndex: 4),
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Center(
        child: CircularProgressIndicator(
          color: EBColor.green,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}
