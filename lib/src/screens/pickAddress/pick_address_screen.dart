import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/profile/profile_response.dart';
import 'package:farmgate/src/screens/pickAddress/cubit/pick_address_cubit.dart';
import 'package:farmgate/src/screens/pickAddress/widgets/pick_address_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class PickAddressScreen
    extends CubitWidget<PickAddressCubit, PickAddressState> {
  static BlocProvider<PickAddressCubit> provider(
      ProfileResponse profileResponse) {
    return BlocProvider(
        create: (context) => PickAddressCubit(profileResponse),
        child: PickAddressScreen());
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    await context.read<PickAddressCubit>().handleInitialData();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget builder(BuildContext context, PickAddressState state) {
    print('rebuild');
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PickAddressWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      actions: [
        IconButton(
          icon: Icon(Icons.check, color: appIconColor),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              context.read<PickAddressCubit>().handleConfirmAddress();
            }
          },
        )
      ],
      iconTheme: IconThemeData(color: greyColor),
      title: Text(
        'my_address'.tr,
        style: headingBlack18,
      ),
      centerTitle: true,
    );
  }
}
