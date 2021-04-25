import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

/// Text style farmapp
Color splashColor = Colors.grey.withOpacity(0.1);
Color lineGrey = Colors.grey[200];
// App Colors
const Color appBarColor = Color(0xff89274E);
const Color appIconColor = Color(0xff89274E);
const Color beginGradientColor = Color(0xff89274E);
Color backgroundColor = Colors.grey[100];
const Color endGradientColor = Color(0xFF2B4777);
const Color activeGreen = Color(0xff87d65a);
const Color greyColor300 = Color(0xffeeeeee);
Color greyColor100 = Colors.grey[100];
const Color colorTitle = Color(0xff89274E);
const Color whiteColor = const Color(0XFFFFFFFF);
const Color blackColor = const Color(0XFF242A37);
const Color disabledColor = const Color(0XFFF7F8F9);
const Color greyColor = Colors.grey;
Color greyColor2 = Colors.grey.withOpacity(0.3);
const Color redColor = const Color(0xff89274E);
const Color primaryColor = const Color(0xff89274E);
const Color totalPostColor = const Color(0xff89274E);
const Color totalPostTextColor = Colors.white;
const Color latestFertilizationTextColor = const Color(0xff89274E);
const Color latestFertilizationTitleColor = const Color(0xff89274E);
const Color tabSelect = const Color(0xff89274E);

/// END
///
///
TextStyle title = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w500,
  fontSize: 18,
);

TextStyle body1 = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.normal,
  fontSize: 16,
);

TextStyle body2 = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.normal,
  fontSize: 14,
);

TextStyle caption = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.normal,
  fontSize: 14,
);

TextStyle textButton = const TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);

TextStyle textStyleActive = TextStyle(
  color: primaryColor,
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
);

TextStyle textBarTitle = TextStyle(
  color: primaryColor,
  fontSize: 24.0,
  fontWeight: FontWeight.normal,
);

TextStyle textStyle = const TextStyle(
  color: const Color(0XFF000000),
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
);

TextStyle textStyleWhite = const TextStyle(
  color: const Color(0XFFFFFFFF),
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
);

TextStyle textBoldBlack = const TextStyle(
  color: const Color(0XFF000000),
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
);

TextStyle textBoldWhite = const TextStyle(
  color: const Color(0XFFFFFFFF),
  fontSize: 10.0,
  fontWeight: FontWeight.bold,
);

TextStyle textBlackItalic = const TextStyle(
  color: const Color(0XFF000000),
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  fontStyle: FontStyle.italic,
);

TextStyle textGreyBold = const TextStyle(
  color: Colors.grey,
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
);

TextStyle textStyleBlue = const TextStyle(
  color: primaryColor,
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
);

TextStyle titleLogin = new TextStyle(
  color: colorTitle,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

TextStyle textInput = new TextStyle(
  color: Colors.black,
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
);

TextStyle titleNew = GoogleFonts.merriweather(
  textStyle: TextStyle(
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
);

TextStyle titleBar = new TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
);

TextStyle tags = new TextStyle(
  color: Colors.black,
  fontSize: 18.0,
  fontWeight: FontWeight.normal,
);

TextStyle descNew = new TextStyle(
  color: Colors.black,
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
);

TextStyle timeNews = new TextStyle(
  color: Colors.white,
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
);

TextStyle headingWhite18 = new TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  fontWeight: FontWeight.normal,
);

TextStyle headingBlack18 = new TextStyle(
  color: Colors.black,
  fontSize: 18.0,
  fontWeight: FontWeight.normal,
);

TextStyle textReport = new TextStyle(
  color: totalPostTextColor,
  fontSize: 38.0,
  fontWeight: FontWeight.bold,
);

final linearGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: <Color>[Color(0xff89274E), Color(0xff89274E)],
);

const Color transparentColor = const Color.fromRGBO(0, 0, 0, 0.2);
const Color activeButtonColor = const Color.fromRGBO(43, 194, 137, 50.0);
const Color dangerButtonColor = const Color(0XFFf53a4d);

int getColorHexFromStr(String colorStr) {
  colorStr = "FF" + colorStr;
  colorStr = colorStr.replaceAll("#", "");
  int val = 0;
  int len = colorStr.length;
  for (int i = 0; i < len; i++) {
    int hexDigit = colorStr.codeUnitAt(i);
    if (hexDigit >= 48 && hexDigit <= 57) {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
      // A..F
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
      // a..f
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      throw new FormatException("An error occurred when converting a color");
    }
  }
  return val;
}
