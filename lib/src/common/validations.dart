import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:simplest/simplest.dart';

class Validations {
  String validateName(String value) {
    if (value.isEmpty) return 'name_is_required'.tr;
    final nameExp = RegExp(r'^[A-za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'please_enter_only_alphabetical_characters'.tr;
    }

    return null;
  }

  String validateData(String value) {
    if (value.isEmpty) return 'name_is_required'.tr;
    return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'enter_valid_email'.tr;
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) return 'please_choose_a_password'.tr;
    if (value.length < 6) return 'password_over_6_characters'.tr;
    return null;
  }

  String validateMobile(String value) {
    value = value.replaceAll(' ', '');
    if (value.length != 10 && value.length != 9) {
      return 'mobile_number_must_be_of_9_or_10_digit'.tr;
    } else {
      return null;
    }
  }

  String validateAddress(String value) {
    if (value.isEmpty) return 'please_enter_your_address'.tr;
    if (value.length < 6) return 'address_over_6_characters'.tr;
    return null;
  }
}
