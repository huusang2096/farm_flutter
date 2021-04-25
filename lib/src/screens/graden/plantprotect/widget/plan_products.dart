import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/style.dart';
import 'package:farmgate/src/model/graden/action_garden.dart';
import 'package:farmgate/src/model/plant_protect/plant_protection_types_response.dart';
import 'package:farmgate/src/model/plant_protect/plant_respone.dart';
import 'package:farmgate/src/screens/graden/plantprotect/blocs/protect_cubit.dart';
import 'package:farmgate/src/screens/graden/plantprotect/widget/action_protect_widget.dart';
import 'package:farmgate/src/screens/shimmer/listplant_simmer.dart';
import 'package:farmgate/src/widgets/reload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:simplest/simplest.dart';

class PlanProductWidget extends StatelessWidget {
  int gardenId;
  PlantProtectionTypes plantProtectionTypes;
  ActionGarden actionGarden;
  PlanProductWidget(
      this.plantProtectionTypes, this.gardenId, this.actionGarden);

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    List<PlantProtect> listPlantProtects = plantProtectionTypes.plantProtects;
    void _onRefresh() async {
      await Future.delayed(Duration(milliseconds: 1000));
      context.read<ProtectCubit>().getListPlantProtect(plantProtectionTypes);
      _refreshController.refreshCompleted();
    }

    int row = 2;
    if (Device.get().isTablet) {
      row = 4;
    }

    Widget _showAddProtect(
        int gardenID, PlantProtect currentPlant, BuildContext context) {
      showModalBottomSheet(
          elevation: 10,
          context: context,
          enableDrag: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext builder) {
            return StatefulBuilder(
              builder: (context, state) {
                return AnimatedPadding(
                    padding: MediaQuery.of(context).viewInsets,
                    duration: const Duration(milliseconds: 10),
                    curve: Curves.decelerate,
                    child: ActionProtectPlanWidget.provider(
                        action: actionGarden,
                        gardenId: gardenId,
                        currentPlant: currentPlant));
              },
            );
          });
    }

    return SmartRefresher(
        controller: _refreshController,
        header: ReloadWidget(),
        enablePullDown: true,
        onRefresh: _onRefresh,
        child: Container(
            padding: EdgeInsets.all(10),
            color: backgroundColor,
            child: SingleChildScrollView(
                child: listPlantProtects.length == 0
                    ? ListPlantShimmer()
                    : Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: listPlantProtects.length,
                          physics: ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: row,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4,
                                  childAspectRatio: 0.9),
                          itemBuilder: (context, index) {
                            PlantProtect currentPlant =
                                listPlantProtects.elementAt(index);
                            return Card(
                              elevation: 5.0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 4.0, right: 4.0, left: 4.0),
                                      child: Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        currentPlant
                                                                ?.linkImage ??
                                                            ""),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 16,
                                        top: 8.0,
                                        bottom: 8.0,
                                        right: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${currentPlant?.name ?? ""}",
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                              style: titleNew.copyWith(
                                                  fontSize: 14),
                                            ),
                                          ],
                                        )),
                                        Container(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              _showAddProtect(gardenId,
                                                  currentPlant, context);
                                            },
                                            child: Icon(
                                              Icons.add_circle_rounded,
                                              color: appIconColor,
                                              size: 40,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ))));
  }

  String validateUsingField(String value) {
    if (value.isEmpty) return 'using_is_required'.tr;
    return null;
  }

  String validateAmountField(String value) {
    if (value.isEmpty) return 'amount_is_required'.tr;
    return null;
  }
}
