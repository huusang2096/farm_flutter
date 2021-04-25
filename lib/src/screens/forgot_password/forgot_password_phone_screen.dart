import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:farmgate/src/screens/profile/widgets/custom_default_button.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ForgotPasswordPhoneScreen
    extends CubitWidget<ForgotPasswordCubit, ForgotPasswordState> {
  final TextEditingController _textPhoneController = TextEditingController();
  final TextEditingController _textPasswordController = TextEditingController();
  final TextEditingController _textConfirmPasswordController =
      TextEditingController();
  final PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'VN', dialCode: '+84');
  final _formKey = GlobalKey<FormState>();
  static provider() {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: ForgotPasswordPhoneScreen(),
    );
  }

  @override
  Widget builder(BuildContext context, ForgotPasswordState state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: state.data.isLoading ? false : true,
        actionsIconTheme: IconThemeData(color: Color(0xFFBDBDBD)),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: SingleChildScrollView(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                  child: Theme(
                    data: Theme.of(context).copyWith(primaryColor: Colors.grey),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildHeaderReset(),
                        _buildFormReset(context, state),
                        SizedBox(
                          height: 20,
                        ),
                        CustomDefaultButton(
                          text: 'reset_password'.tr,
                          isLoading: state.data.isLoading,
                          press: () {
                            if (_formKey.currentState.validate()) {
                              FocusScope.of(context).unfocus();
                              context.read<ForgotPasswordCubit>().resetPassword(
                                  phone: _textPhoneController.text,
                                  password: _textPasswordController.text,
                                  confirmPassword:
                                      _textConfirmPasswordController.text);
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => navigator.pushReplacementNamed(
                                    AppRoute.loginWithPhoneScreen),
                                child: Text(
                                  'already_have_an_account'.tr,
                                  style: body2,
                                ),
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              GestureDetector(
                                onTap: () => navigator.pushReplacementNamed(
                                    AppRoute.loginWithPhoneScreen),
                                child: Text(
                                  'login_here'.tr,
                                  style: textStyleActive,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInternationalPhoneNumber(
      {String hintText, Function(PhoneNumber) onChange, bool inEnabled}) {
    return InternationalPhoneNumberInput(
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      onInputChanged: (PhoneNumber value) {
        print('value:' + value.phoneNumber);
        onChange(value);
      },
      isEnabled: inEnabled,
      initialValue: _phoneNumber,
      formatInput: true,
      validator: (value) {
        if (value.isBlank) {
          return 'phone_number_is_required'.tr;
        }
        if (!value.isPhoneNumber) {
          return 'not_a_valid_phone_number'.tr;
        }
        return null;
      },
      errorMessage: 'invalid_phone_number'.tr,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      inputDecoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        hintText: hintText.tr,
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: _outlineInputBorder(color: greyColor, width: 0.7),
        errorBorder: _outlineInputBorder(color: Colors.red),
        focusedBorder: _outlineInputBorder(color: appIconColor, width: 1.6),
      ),
    );
  }

  Widget _buildFormReset(BuildContext context, ForgotPasswordState state) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildInternationalPhoneNumber(
            hintText: 'phone',
            inEnabled: !state.data.isLoading,
            onChange: (value) {
              _textPhoneController.text = value.phoneNumber;
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: _textPasswordController,
            style: textInput,
            enabled: !state.data.isLoading,
            textInputAction: TextInputAction.next,
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'password_or_confirm_password_cannot_empty'.tr;
              }
              if (value.length < 6) {
                return 'password_or_confirm_password_cannot_less_than_6'.tr;
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'password'.tr,
              hintStyle: TextStyle(color: Color(0xFFB3B4B4), fontSize: 14),
              errorText: state.data.errorValidate == ''
                  ? null
                  : state.data.errorValidate,
              prefixIcon: Icon(
                Icons.lock_rounded,
                color: appIconColor,
              ),
              border: _outlineInputBorder(color: appIconColor, width: 0.7),
              focusedBorder:
                  _outlineInputBorder(color: appIconColor, width: 1.6),
              errorBorder: _outlineInputBorder(color: Colors.red),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            enabled: !state.data.isLoading,
            controller: _textConfirmPasswordController,
            style: textInput,
            obscureText: true,
            validator: (value) {
              if (value != _textPasswordController.text) {
                return 'password_and_confirm_password_mismatched'.tr;
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'confirm_password'.tr,
              hintStyle: TextStyle(color: Color(0xFFB3B4B4), fontSize: 14),
              errorText: state.data.errorValidate == ''
                  ? null
                  : state.data.errorValidate,
              prefixIcon: Icon(
                Icons.lock_rounded,
                color: appIconColor,
              ),
              border: _outlineInputBorder(color: appIconColor, width: 1.6),
              errorBorder: _outlineInputBorder(color: Colors.red),
              focusedBorder:
                  _outlineInputBorder(color: appIconColor, width: 1.6),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderReset() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 10,
        ),
        Images.forgotPass.loadImage(height: 70),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
          ),
        ),
        Text(
          'reset_password'.tr,
          style: titleLogin,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _outlineInputBorder({Color color, double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
