import 'package:farmgate/src/screens/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:simplest/simplest.dart';

class ProfileGenderWidget extends StatefulWidget {
  final Function(String) pressSelect;

  ProfileGenderWidget({Key key, this.pressSelect}) : super(key: key);

  @override
  _ProfileGenderWidgetState createState() => _ProfileGenderWidgetState();
}

class _ProfileGenderWidgetState extends State<ProfileGenderWidget> {
  String genderCurrent;
  String genderChange;
  final List<String> prefixes = ['Mr', 'Ms', 'Mrs'];
  @override
  Widget build(BuildContext context) {
    genderCurrent =
        context.watch<ProfileCubit>().state.profileResponse?.data?.gender ??
            null;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.7, color: Colors.grey[700]),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text(
              'gender'.tr,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: genderChange ?? genderCurrent,
                isExpanded: true,
                hint: Text('select_gender'.tr),
                items: prefixes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            value.tr,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    genderChange = newValue;
                    //genderCurrent = newValue;
                    widget.pressSelect(newValue);
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
