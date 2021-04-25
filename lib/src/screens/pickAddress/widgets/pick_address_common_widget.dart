import 'package:farmgate/src/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simplest/simplest.dart';

Widget dropdownButtonLoading() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: greyColor,
        ),
        hint: Container(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 55.0,
            child: SpinKitThreeBounce(
              size: 25,
              color: Color(0xFF2B4777),
            ),
          ),
        ),
        onChanged: (value) {},
        items: [],
      ),
    ),
  );
}

Widget dropdownButtonInitial(String hint) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: greyColor,
        ),
        hint: Text(hint),
        onChanged: (value) {},
        items: [],
      ),
    ),
  );
}

class FormatAddress extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else {
      final validCharacters = RegExp(
          r'^[a-zA-Z0-9a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂẾưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\-,/\.]+$');
      if (!validCharacters.hasMatch(newValue.text)) {
        return oldValue;
      }
      return newValue;
    }
  }
}

Widget dotIndicatorCustom(Color color) {
  final Widget child = Icon(
    Icons.check,
    color: color,
    size: 24.0,
  );

  return Center(
    child: Container(
      padding: EdgeInsets.all(5.0),
      child: child,
      decoration:
          BoxDecoration(shape: BoxShape.circle, gradient: linearGradient),
    ),
  );
}
