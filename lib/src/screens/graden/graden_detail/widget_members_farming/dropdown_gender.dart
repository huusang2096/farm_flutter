import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/cubit/add_members_cubit.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/status_common.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class DropdownGender extends StatelessWidget {
  String gender;
  @override
  Widget build(BuildContext context) {
    final sex = context
        .watch<AddMemberCubit>()
        .state
        .data
        ?.selectedGender
        ?.toLowerCase();
    if (sex == 'nam' || sex == 'male' || sex == 'mr') {
      gender = 'Mr';
    } else if (sex == 'nữ' || sex == 'female' || sex == 'ms') {
      gender = 'Ms';
    } else if (sex == 'khác' || sex == 'others' || sex == 'mrs') {
      gender = 'Mrs';
    }

    return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: beginGradientColor, width: 0.7)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.redAccent, width: 1.0)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: beginGradientColor, width: 1.6),
          ),
          contentPadding:
              EdgeInsets.only(top: 15.0, bottom: 5.0, left: 10.0, right: 10.0),
          hintText: 'select_gender'.tr,
        ),
        value: gender.isBlank ? ListGender.prefixes[0] : gender,
        isExpanded: true,
        validator: null,
        items: ListGender.prefixes.skip(1).map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              //  padding: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    value.tr,
                  )
                ],
              ),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          FocusScope.of(context).unfocus();
          context.read<AddMemberCubit>().selectedGender(newValue);
        });
  }
}
