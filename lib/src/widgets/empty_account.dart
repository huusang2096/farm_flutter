import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/widgets/rouned_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class EmptyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: AlignmentDirectional.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.grey,
                          Colors.grey.withOpacity(0.1),
                        ])),
                child: Icon(
                  Icons.verified_user,
                  color: appIconColor,
                  size: 70,
                ),
              ),
              Positioned(
                right: -30,
                bottom: -50,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              Positioned(
                left: -20,
                top: -50,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[300].withOpacity(0.15),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Opacity(
            opacity: 0.4,
            child: Text(
              'signin_to_use_feature'.tr,
              textAlign: TextAlign.center,
              style: title,
            ),
          ),
          SizedBox(height: 50),
          Container(
            width: double.infinity,
            height: 60,
            child: Center(
              child: RounedFlatButton(
                onPress: () {
                  Navigator.of(context)
                      .pushNamed(AppRoute.loginWithPhoneScreen);
                },
                child: Text(
                  'sign_in'.tr,
                  style: textButton,
                ),
                color: Colors.white,
                borderRadius: 30,
                height: 50,
                width: 160,
              ),
            ),
          )
        ],
      ),
    );
  }
}
