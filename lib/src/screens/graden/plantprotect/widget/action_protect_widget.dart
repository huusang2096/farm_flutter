import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:farmgate/src/model/graden/action_garden.dart';
import 'package:farmgate/src/model/plant_protect/plant_respone.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/input/inputPrice/action_input_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/input/inputProduct/action_input_product_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/input/selectProduct/action_list_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/input/selectTypePrice/action_product_price_widget.dart';
import 'package:farmgate/src/screens/graden/plantprotect/blocs/protect_cubit.dart';
import 'package:farmgate/src/screens/graden/plantprotect/blocs/protect_state.dart';
import 'package:farmgate/src/screens/shimmer/action_simmer.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:farmgate/src/widgets/rouned_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ActionProtectPlanWidget extends CubitWidget<ProtectCubit, ProtectState> {
  ActionGarden action;
  int gardenId;
  ProtectCubit cubit;
  PlantProtect currentPlant;
  ActionProtectPlanWidget(this.action, this.gardenId, this.currentPlant);

  static provider(
      {ActionGarden action, int gardenId, PlantProtect currentPlant}) {
    return BlocProvider(
      create: (context) => ProtectCubit(),
      child: ActionProtectPlanWidget(action, gardenId, currentPlant),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<ProtectCubit>().getListAction(action);
    super.afterFirstLayout(context);
  }

  @override
  Widget builder(BuildContext context, ProtectState state) {
    cubit = context.read<ProtectCubit>();
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
              _buildHeaderShowModalBottomSheet(),
              SizedBox(height: 10.0),
              _buildBodyInfoShowModalBottomSheet(currentPlant),
              SizedBox(height: 10),
              Container(
                height: 4.0,
                color: backgroundColor,
              ),
              SizedBox(height: 10),
              Expanded(
                child: AppProgressHUB(
                  inAsyncCall: state.data.isSending,
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
                                            .read<ProtectCubit>()
                                            .addGardenPlantProtectionProducts(
                                                currentPlant, gardenId, action);
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

  Widget _buildHeaderShowModalBottomSheet() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20),
          width: 60,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50)),
        ),
        Container(
          width: 60,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(50)),
        ),
        InkWell(
          onTap: () {
            navigator.pop();
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
    );
  }

  Widget _buildBodyInfoShowModalBottomSheet(PlantProtect currentPlant) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      CachedNetworkImageProvider(currentPlant?.linkImage ?? ''),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    currentPlant?.name ?? '',
                    style: titleNew.copyWith(color: appIconColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    currentPlant?.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
