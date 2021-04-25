import 'package:farmgate/src/common/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class StatusAddMember {
  static const String ADD_MEMBER = 'ADD_MEMBER';
  static const String EDIT_MEMBER = 'EDIT_MEMBER';
  static const String IS_MEMBER = 'IS_MEMBER';
  static const String ADD_PEOPLE = 'ADD_PEOPLE';
  static const String EDIT_PEOPLE = 'EDIT_PEOPLE';
  static const String IS_PEOPLE = 'IS_PEOPLE';
}

class ListGender {
  static const List<String> prefixes = ['', 'Mr', 'Ms', 'Mrs'];
}

class Suggestions {
  static const List<String> relationsShip = [
    'employees',
    'relatives',
    'friend',
    'brother',
    'sister',
    'father',
    'mother'
  ];
  static List<String> getSuggestionsRelasionShip(String query) {
    List<String> matches = [];
    matches.addAll(relationsShip);

    matches.removeWhere(
        (s) => !(s.tr.toLowerCase().contains(query.toLowerCase())));

    return matches;
  }

  static const List<String> jobs = ['pruning_watering'];
  static List<String> getSuggestionsJob(String query) {
    List<String> matches = [];
    matches.addAll(jobs);

    matches.removeWhere(
        (s) => !(s.tr.toLowerCase().contains(query.toLowerCase())));

    return matches;
  }

  static const List<String> educations = [
    'level_two',
    'level_three',
    'colleges',
    'university',
  ];
  static List<String> getSuggestionsEducations(String query) {
    List<String> matches = [];
    matches.addAll(educations);

    matches.removeWhere(
        (s) => !(s.tr.toLowerCase().contains(query.toLowerCase())));

    return matches;
  }
}

Future showDatesPicker(BuildContext context, {DateTime initialBirthDay}) {
  DateTime _pickDateTime = initialBirthDay ?? DateTime.now();
  return showModalBottomSheet(
      elevation: 10,
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      backgroundColor: Colors.white,
      builder: (BuildContext builder) {
        return StatefulBuilder(
          builder: (context, state) {
            return AnimatedPadding(
                padding: MediaQuery.of(context).viewInsets,
                duration: const Duration(milliseconds: 10),
                curve: Curves.decelerate,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 60,
                            height: 5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          Container(
                            width: 60,
                            height: 5,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                gradient: linearGradient,
                              ),
                              child: Icon(Icons.close, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text('year'.tr,
                            style: textButton.copyWith(color: appIconColor)),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height:
                            MediaQuery.of(context).copyWith().size.height * 0.3,
                        child: CupertinoDatePicker(
                          maximumDate: DateTime.now(),
                          initialDateTime: _pickDateTime,
                          onDateTimeChanged: (DateTime newDate) {
                            _pickDateTime = newDate;
                          },
                          minuteInterval: 1,
                          mode: CupertinoDatePickerMode.date,
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          navigator.pop({'date': _pickDateTime});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green, gradient: linearGradient),
                          padding: EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(),
                              Text(
                                'save_and_next'.tr,
                                style: textButton,
                              ),
                              Icon(Icons.navigate_next,
                                  color: Colors.white, size: 28)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ));
          },
        );
      });
}

UnderlineInputBorder buildCustomerUnderlineBorder({Color color}) {
  return UnderlineInputBorder(borderSide: BorderSide(color: color, width: 1.6));
}

UnderlineInputBorder outlineInputBorder(
    {Color color = Colors.redAccent, double width = 0.8}) {
  return UnderlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: width,
    ),
  );
}

InputDecoration customInputDecoration(String hintText) {
  return InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: appIconColor, width: 0.7)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: Colors.redAccent, width: 1.0)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appIconColor, width: 1.6),
    ),
    contentPadding: EdgeInsets.only(top: 15.0, bottom: 5.0, left: 10.0),
    hintText: hintText,
  );
}
