import 'package:farmgate/src/model/pick_address/city_response.dart';
import 'package:farmgate/src/screens/pickAddress/cubit/pick_address_cubit.dart';
import 'package:farmgate/src/screens/pickAddress/widgets/pick_address_common_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class PickAddressCityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.read<PickAddressCubit>().state;
    return state.data.cityResponse != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<City>(
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF2B4777),
                ),
                value: state.data?.selectedCity,
                hint: Text('choose_the_city'.tr),
                onChanged: (City newValue) => context
                    .read<PickAddressCubit>()
                    .changeSelectedCity(newValue),
                items: state.data.cityResponse.data.map((City value) {
                  return DropdownMenuItem<City>(
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
        : state.data.isLoadingCity
            ? dropdownButtonLoading()
            : dropdownButtonInitial('choose_the_city'.tr);
  }
}
