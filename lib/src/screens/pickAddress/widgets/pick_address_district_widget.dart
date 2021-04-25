import 'package:farmgate/src/model/pick_address/district_response.dart';
import 'package:farmgate/src/screens/pickAddress/cubit/pick_address_cubit.dart';
import 'package:farmgate/src/screens/pickAddress/widgets/pick_address_common_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class PickAddressDistrictWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.read<PickAddressCubit>().state;
    return state.data.districtResponse != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<District>(
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF2B4777),
                ),
                value: state.data?.selectedDistrict,
                hint: Text('choose_your_district'.tr),
                onChanged: (District newValue) => context
                    .read<PickAddressCubit>()
                    .changeSelectedDistrict(newValue),
                items: state.data.districtResponse.data.map((District value) {
                  return DropdownMenuItem<District>(
                    value: value,
                    child: Text(
                      value.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        : state.data.isLoadingDistrict
            ? dropdownButtonLoading()
            : dropdownButtonInitial('choose_your_district'.tr);
  }
}
