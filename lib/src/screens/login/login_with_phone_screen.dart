import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/validations.dart';
import 'package:farmgate/src/screens/login/cubit/login_cubit.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:farmgate/src/widgets/rouned_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

import 'widget/relogin_widget.dart';

class LoginWithPhoneScreen extends CubitWidget<LoginCubit, LoginState> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passEmailController = TextEditingController();
  final PhoneNumber phoneNumberInitial =
      PhoneNumber(dialCode: '+84', isoCode: 'VN');
  final Validations _validations = Validations();

  static BlocProvider<LoginCubit> provider() {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: LoginWithPhoneScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<LoginCubit>().checkExistLogin();
    super.afterFirstLayout(context);
  }

  @override
  void listener(BuildContext context, LoginState state) {
    super.listener(context, state);
    state.when(
        init: (data) {},
        loaded: (data) {},
        loading: (data) {},
        loginSuccess: (data) {
          navigator.pushNamedAndRemoveUntil(
              AppRoute.homeScreen, (route) => false);
        });
  }

  @override
  Widget builder(BuildContext context, LoginState state) {
    final _size = MediaQuery.of(context).size;
    return AppProgressHUB(
      inAsyncCall: state.data.isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        appBar: _buildAppBar(context),
        body: _buildBody(_size, context, state),
      ),
    );
  }

  Widget _buildBody(Size _size, BuildContext context, LoginState state) {
    if (state.data.isExistLogin) {
      return ReloginWidget();
    }
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: _size.height,
          width: _size.width,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _loginFormKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'welcome_to_vipay'.tr,
                        style: titleLogin,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildFormLogin(context, state),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildButtonLogin(context, state),
                      _buildFooterLogin(context, state),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: true,
      elevation: 0.0,
      iconTheme: IconThemeData(color: greyColor),
    );
  }

  Widget _buildInternationalPhoneNumber(
      {String hintText, Function(PhoneNumber) onChange}) {
    return InternationalPhoneNumberInput(
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      onInputChanged: (PhoneNumber value) {
        print('value:' + value.phoneNumber);
        onChange(value);
      },
      validator: (value) {
        if (value.isBlank) {
          return 'phone_number_is_required'.tr;
        }
        if (!value.isPhoneNumber) {
          return 'not_a_valid_phone_number'.tr;
        }
        return null;
      },
      formatInput: true,
      keyboardAction: TextInputAction.next,
      initialValue: phoneNumberInitial,
      errorMessage: 'invalid_phone_number'.tr,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      inputDecoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        hintText: hintText.tr,
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: _outlineInputBorder(color: appIconColor, width: 0.7),
        errorBorder: _outlineInputBorder(color: Colors.redAccent),
        focusedBorder: _outlineInputBorder(color: appIconColor, width: 1.6),
      ),
    );
  }

  Widget _buildFormLogin(BuildContext context, LoginState state) {
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        _buildInternationalPhoneNumber(
          hintText: 'phone',
          onChange: (value) {
            _phoneController.text = value.phoneNumber;
            //_phoneNumber = value;*/
          },
        ),
        SizedBox(height: 18.0),
        TextFormField(
          keyboardType: TextInputType.text,
          validator: _validations.validatePassword,
          obscureText: state.data.isPasswordObscure,
          style: textInput,
          textInputAction: TextInputAction.done,
          controller: _passEmailController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12.0),
            hintText: 'password'.tr,
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(
              Icons.lock_rounded,
              color: appIconColor,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                context.read<LoginCubit>().toggleShowPassword();
              },
              color: Colors.grey,
              icon: Icon(state.data.isPasswordObscure
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            errorBorder: _outlineInputBorder(color: Colors.redAccent),
            focusedBorder: _outlineInputBorder(color: appIconColor, width: 1.6),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonLogin(BuildContext context, LoginState state) {
    return Container(
      width: double.infinity,
      height: 60,
      child: Center(
        child: RounedFlatButton(
          onPress: () {
            if (_loginFormKey.currentState.validate()) {
              FocusScope.of(context).unfocus();
              context.read<LoginCubit>().submitLogin(
                  phone: _phoneController.text,
                  password: _passEmailController.text);
            }
          },
          child: Text(
            'login'.tr,
            style: textButton,
          ),
          color: Colors.white,
          borderRadius: 30,
          height: 50,
          width: 160,
        ),
      ),
    );
  }

  Widget _buildFooterLogin(BuildContext context, LoginState state) {
    return Column(
      children: [
        SizedBox(
          height: 30.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoute.registerScreen);
          },
          child: Text('i_do_not_have_an_account'.tr, style: descNew),
        ),
        SizedBox(
          height: 10.0,
        ),
        GestureDetector(
          onTap: () => navigator.pushNamed(AppRoute.forgotPasswordPhoneScreen),
          child: Text('forgot_password'.tr, style: descNew),
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
