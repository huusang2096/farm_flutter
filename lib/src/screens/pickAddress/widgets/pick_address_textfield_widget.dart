import 'package:farmgate/src/screens/pickAddress/cubit/pick_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class PickAddressTextFieldWidget extends StatefulWidget {
  @override
  _PickAddressTextFieldWidgetState createState() =>
      _PickAddressTextFieldWidgetState();
}

class _PickAddressTextFieldWidgetState
    extends State<PickAddressTextFieldWidget> {
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    addressController.text = (context
            .read<PickAddressCubit>()
            .state
            .data
            ?.profileResponse
            ?.data
            ?.addressFormat ??
        '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: addressController,
      textAlignVertical: TextAlignVertical.bottom,
      autocorrect: false,
      autofocus: false,
      enableSuggestions: false,
      // inputFormatters: [FormatAddress()],
      decoration: InputDecoration(
        hintText: 'address'.tr,
        isDense: true,
      ),
      onSaved: (value) {
        context.read<PickAddressCubit>().saveAddress(value);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'this_field_cannot_be_null'.tr;
        }
        if (value.length > 255) {
          return 'not_larger_than_characters'.tr;
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }
}
