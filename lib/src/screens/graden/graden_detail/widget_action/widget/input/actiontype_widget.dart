import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:farmgate/src/model/graden/action_garden.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/bloc/garden_action_cubit.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/input/inputPrice/action_input_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/input/inputProduct/action_input_product_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/input/selectProduct/action_list_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/input/selectTypePrice/action_product_price_widget.dart';
import 'package:farmgate/src/screens/shimmer/action_simmer.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:farmgate/src/widgets/rouned_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ActionTypeWidget
    extends CubitWidget<GardenActionCubit, GardenActionState> {
  ActionGarden action;
  int gardenId;
  GardenActionCubit cubit;
  ActionTypeWidget(this.action, this.gardenId);

  static provider({ActionGarden action, int gardenId}) {
    return BlocProvider(
      create: (context) => GardenActionCubit(),
      child: ActionTypeWidget(action, gardenId),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<GardenActionCubit>().getListAction(gardenId, action);
    super.afterFirstLayout(context);
  }

  @override
  Widget builder(BuildContext context, GardenActionState state) {
    cubit = context.read<GardenActionCubit>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 60,
                    height: 5,
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
                      margin: EdgeInsets.only(right: 20, top: 20),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        gradient: linearGradient,
                      ),
                      child: Icon(Icons.arrow_drop_down, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(action.name.tr,
                    style: titleNew.copyWith(color: Colors.black)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 8, bottom: 16),
                child: Text(
                    'action_des'.tr.trArgs(['${action.name ?? ''}', ' ']),
                    style: titleBar.copyWith(color: Colors.black)),
              ),
              Container(height: 5, color: backgroundColor),
              Expanded(
                child: AppProgressHUB(
                  inAsyncCall: state.data.isShow,
                  child: SingleChildScrollView(
                    child: state.data.listsActionModel.length == 0
                        ? ActionShimmer()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                ListView.builder(
                                  primary: true,
                                  shrinkWrap: true,
                                  addAutomaticKeepAlives: true,
                                  physics: ClampingScrollPhysics(),
                                  padding: EdgeInsets.all(16),
                                  itemBuilder: (context, index) {
                                    ActionModel actionModel = state
                                        .data.listsActionModel
                                        .elementAt(index);
                                    if (actionModel.inputType ==
                                        "input_product") {
                                      return ActionListWidget(actionModel,
                                          index, action.type, action.image);
                                    } else if (actionModel.unitPrice ==
                                        "Công") {
                                      return ActionInputProductWidget(
                                          actionModel,
                                          index,
                                          action.type,
                                          action.image);
                                    } else if (actionModel.inputType ==
                                        "input_product_price") {
                                      return ActionProductPriceWidget(
                                          actionModel,
                                          index,
                                          action.type,
                                          action.image);
                                    } else {
                                      return ActionInputNumberWidget(
                                          actionModel, index, gardenId);
                                    }
                                  },
                                  itemCount: state.data.listsActionModel.length,
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  height: 60,
                                  child: Center(
                                    child: RounedFlatButton(
                                      onPress: () {
                                        context
                                            .read<GardenActionCubit>()
                                            .addAction();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              'done'.tr,
                                              style: textButton,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Icon(
                                              FontAwesomeIcons
                                                  .arrowAltCircleRight,
                                              color: Colors.white,
                                              size: 25.0,
                                            ),
                                          )
                                        ],
                                      ),
                                      color: Colors.white,
                                      borderRadius: 30,
                                      height: 50,
                                      width: 160,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ]),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
