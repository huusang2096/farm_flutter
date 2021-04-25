import 'package:farmgate/locator.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/storage/app_prefs.dart';
import 'package:farmgate/src/common/validations.dart';
import 'package:farmgate/src/screens/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ReloginWidget extends StatefulWidget {
  @override
  _ReloginWidgetState createState() => _ReloginWidgetState();
}

class _ReloginWidgetState extends State<ReloginWidget> {
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LoginCubit>();
    final state = bloc.state;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'hello'.tr,
              style: titleLogin,
            ),
            SizedBox(
              height: 6,
            ),
            Text((locator<AppPref>().getUser()?.data?.firstName ?? '') +
                ' ' +
                (locator<AppPref>().getUser()?.data?.lastName ?? '')),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              validator: Validations().validatePassword,
              obscureText: state.data.isPasswordObscure,
              controller: _passwordController,
              style: textInput,
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
                    bloc.toggleShowPassword();
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
              height: 16,
            ),
            // !isEnabledBioLogin
            //     ? SizedBox.shrink()
            //     : InkWell(
            //         onTap: () {
            //           //context.read<LoginCubit>().onSelectBioLogin()
            //         },
            //         child: Images.helpIcon.loadImage(size: 40)),
            SizedBox(
              height: 8,
            ),
            _buildButtonLogin(context, state),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              onPressed: () {
                bloc.logInWithAnOtherAccount();
              },
              child: Text('login_with_other_account'.tr),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtonLogin(BuildContext context, LoginState state) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(44)),
          gradient: linearGradient),
      child: FlatButton(
        onPressed: () => _validateAndSubmit(state),
        child: Text('login'.tr, style: textButton),
      ),
    );
  }

  void _validateAndSubmit(LoginState state) {
    context.read<LoginCubit>().submitLogin(
        phone: locator<AppPref>().loginRequest.phone,
        password: _passwordController.text);
  }

  OutlineInputBorder _outlineInputBorder({Color color, double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
