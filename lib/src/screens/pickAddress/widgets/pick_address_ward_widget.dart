import 'package:farmgate/src/model/pick_address/ward_response.dart';
import 'package:farmgate/src/screens/pickAddress/cubit/pick_address_cubit.dart';
import 'package:farmgate/src/screens/pickAddress/widgets/pick_address_common_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class PickAddressWardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.read<PickAddressCubit>().state;
    return state.data.wardResponse != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Ward>(
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF2B4777),
                ),
                value: state.data?.selectedWard,
                hint: Text('choose_your_ward'.tr),
                onChanged: (Ward newValue) => context
                    .read<PickAddressCubit>()
                    .changeSelectedWard(newValue),
                items: state.data.wardResponse.data.map((Ward value) {
                  return DropdownMenuItem<Ward>(
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
            : dropdownButtonInitial('choose_your_ward'.tr);
  }
}
