import 'package:farmgate/src/common/style.dart';
import 'package:farmgate/src/model/information/information.dart';
import 'package:farmgate/src/screens/infomation_app/cubit/information_cubit.dart';
import 'package:farmgate/src/screens/infomation_app/widget/item_rule_widget.dart';
import 'package:farmgate/src/screens/shimmer/rule_simmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:simplest/simplest.dart';

class InformationAppScreen
    extends CubitWidget<InformationCubit, InformationState> {
  static provider() {
    return BlocProvider(
      create: (context) => InformationCubit(),
      child: InformationAppScreen(),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: greyColor),
      title: Text(
        'info_app'.tr,
        style: headingBlack18,
      ),
      elevation: 1.0,
      centerTitle: true,
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<InformationCubit>().getInformation();
    super.afterFirstLayout(context);
  }

  @override
  void listener(BuildContext context, InformationState state) {
    super.listener(context, state);
  }

  @override
  Widget builder(BuildContext context, InformationState state) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: state.data.rules.length == 0
                ? RuleShimmer()
                : Column(
                    children: [
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.data.rules.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 4);
                        },
                        itemBuilder: (context, index) {
                          Rule rule = state.data.rules[index];
                          return ItemRuleWidget(rule: rule);
                        },
                      ),
                    ],
                  )));
  }
}
