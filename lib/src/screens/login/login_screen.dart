import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/validations.dart';
import 'package:farmgate/src/screens/login/cubit/login_cubit.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:farmgate/src/widgets/rouned_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

import 'widget/relogin_widget.dart';

class LoginScreen extends CubitWidget<LoginCubit, LoginState> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passEmailController = TextEditingController();

  final Validations _validations = Validations();

  static BlocProvider<LoginCubit> provider() {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: LoginScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // context.read<LoginCubit>().loadData();
  }

  @override
  void listener(BuildContext context, LoginState state) {
    super.listener(context, state);
    state.when(
        init: null,
        loaded: null,
        loading: null,
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
    // if (state.data.existLoginRequest != null) {
    //   return ReloginWidget();
    // }
    return SafeArea(
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

  Widget _buildFormLogin(BuildContext context, LoginState state) {
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
          style: textInput,
          keyboardType: TextInputType.emailAddress,
          validator: _validations.validateEmail,
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'email'.tr,
            hintStyle: TextStyle(color: Colors.grey[400]),
            contentPadding: EdgeInsets.all(12.0),
            prefixIcon: Icon(Icons.email, color: beginGradientColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            // focusedErrorBorder:
            //     _outlineInputBorder(color: Colors.redAccent),
            errorBorder: _outlineInputBorder(color: Colors.red),
            focusedBorder:
                _outlineInputBorder(color: beginGradientColor, width: 1.6),
            // enabledBorder: _outlineInputBorder(color: Colors.redAccent),
          ),
        ),
        SizedBox(height: 18.0),
        TextFormField(
          keyboardType: TextInputType.text,
          validator: _validations.validatePassword,
          obscureText: state.data.isPasswordObscure,
          style: textInput,
          controller: _passEmailController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12.0),
            hintText: 'password'.tr,
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(
              Icons.lock_rounded,
              color: beginGradientColor,
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
            // focusedErrorBorder: _outlineInputBorder(color: Colors.redAccent),
            errorBorder: _outlineInputBorder(color: Colors.red),
            focusedBorder:
                _outlineInputBorder(color: beginGradientColor, width: 1.6),
            // enabledBorder: _outlineInputBorder(color: greyColor),
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
              // context.read<LoginCubit>().submitLogin(
              //     email: _emailController.text,
              //     password: _passEmailController.text);
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
          onTap: () => navigator.pushNamed(AppRoute.forgotPasswordScreen),
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
