import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/style.dart';
import 'package:farmgate/src/common/validations.dart';
import 'package:farmgate/src/screens/change_password/cubit/change_password_cubit.dart';
import 'package:farmgate/src/screens/profile/widgets/custom_default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simplest/simplest.dart';

class ChangePasswordScreen
    extends CubitWidget<ChangePasswordCubit, ChangePasswordState> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _passConfirmController = TextEditingController();

  final Validations _validations = Validations();

  static BlocProvider<ChangePasswordCubit> provider() {
    return BlocProvider<ChangePasswordCubit>(
      create: (context) => ChangePasswordCubit(),
      child: ChangePasswordScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    super.afterFirstLayout(context);
  }

  @override
  void listener(BuildContext context, ChangePasswordState state) {
    if (state is ChangePasswordSuccess) {
      _passController.clear();
      _passConfirmController.clear();
    }
  }

  @override
  Widget builder(BuildContext context, ChangePasswordState state) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(context),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: _validations.validatePassword,
                    controller: _passController,
                    obscureText: state.data.isPasswordObscure,
                    textInputAction: TextInputAction.next,
                    style: textInput,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12.0),
                      errorText: state.data.validateError == ''
                          ? null
                          : state.data.validateError,
                      hintText: 'password'.tr,
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: appIconColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          context
                              .read<ChangePasswordCubit>()
                              .toggleShowPassword();
                        },
                        color: Colors.grey,
                        icon: Icon(state.data.isPasswordObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      errorBorder: _outlineInputBorder(color: Colors.red),
                      focusedBorder:
                          _outlineInputBorder(color: appIconColor, width: 1.6),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: _validations.validatePassword,
                    controller: _passConfirmController,
                    obscureText: state.data.isConfirmPasswordObscure,
                    style: textInput,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12.0),
                      errorText: state.data.validateError == ''
                          ? null
                          : state.data.validateError,
                      hintText: 'password_confirm'.tr,
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: appIconColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          context
                              .read<ChangePasswordCubit>()
                              .toggleShowConfirmPassword();
                        },
                        color: Colors.grey,
                        icon: Icon(state.data.isConfirmPasswordObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      errorBorder: _outlineInputBorder(color: Colors.red),
                      focusedBorder:
                          _outlineInputBorder(color: appIconColor, width: 1.6),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomDefaultButton(
                    text: 'submit'.tr,
                    isLoading: state.data.isLoading,
                    press: () {
                      if (!state.data.isLoading) {
                        context.read<ChangePasswordCubit>().changePassword(
                            _passController.text, _passConfirmController.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: greyColor),
      title: Text('change_password'.tr, style: headingBlack18),
      elevation: 1.0,
      centerTitle: true,
    );
  }

  OutlineInputBorder _outlineInputBorder({Color color, double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
