import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:farmgate/src/screens/profile/widgets/custom_default_button.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ForgotPasswordScreen
    extends CubitWidget<ForgotPasswordCubit, ForgotPasswordState> {
  final TextEditingController _textGmailController = TextEditingController();

  static provider() {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: ForgotPasswordScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {}

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
                            // context
                            //     .read<ForgotPasswordCubit>()
                            //     .resetPassword(_textGmailController.text);
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
                              Text(
                                'already_have_an_account'.tr,
                                style: body2,
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              GestureDetector(
                                onTap: () => navigator.pop(),
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

  @override
  void listener(BuildContext context, ForgotPasswordState state) {
    super.listener(context, state);
  }

  Widget _buildFormReset(BuildContext context, ForgotPasswordState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          keyboardType: TextInputType.text,
          controller: _textGmailController,
          style: textInput,
          decoration: InputDecoration(
            hintText: 'email'.tr,
            hintStyle: TextStyle(color: Color(0xFFB3B4B4), fontSize: 14),
            errorText: state.data.errorValidate == ''
                ? null
                : state.data.errorValidate,
            prefixIcon: Icon(Icons.email, color: appIconColor, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            focusedBorder: _outlineInputBorder(color: appIconColor, width: 1.6),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          ),
        ),
      ],
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
