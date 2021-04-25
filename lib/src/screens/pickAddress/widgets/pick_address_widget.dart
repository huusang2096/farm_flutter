import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/pickAddress/cubit/pick_address_cubit.dart';
import 'package:farmgate/src/screens/pickAddress/widgets/pick_address_city_widget.dart';
import 'package:farmgate/src/screens/pickAddress/widgets/pick_address_common_widget.dart';
import 'package:farmgate/src/screens/pickAddress/widgets/pick_address_district_widget.dart';
import 'package:farmgate/src/screens/pickAddress/widgets/pick_address_textfield_widget.dart';
import 'package:farmgate/src/screens/pickAddress/widgets/pick_address_ward_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';
import 'package:timelines/timelines.dart';

class PickAddressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.read<PickAddressCubit>().state;
    return Container(
      color: whiteColor,
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PickAddressTextFieldWidget(),
          Container(
            width: double.infinity,
            child: Timeline.tileBuilder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              theme: TimelineThemeData(
                nodePosition: 0,
                connectorTheme: ConnectorThemeData(
                  thickness: 3.0,
                  color: Color(0xffd3d3d3),
                ),
                indicatorTheme: IndicatorThemeData(
                  size: 32.0,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 0.0),
              builder: TimelineTileBuilder.connected(
                contentsBuilder: (_, index) {
                  switch (index) {
                    case 0:
                      return PickAddressCityWidget();
                    case 1:
                      return PickAddressDistrictWidget();
                    case 2:
                      return PickAddressWardWidget();
                    default:
                      return SizedBox.shrink();
                  }
                },
                connectorBuilder: (_, index, __) {
                  return SolidLineConnector(
                    color: Color(0xFF2B4777).withOpacity(0.6),
                  );
                },
                indicatorBuilder: (_, index) {
                  switch (index) {
                    case 0:
                      return dotIndicatorCustom(state.data.selectedCity == null
                          ? transparentColor
                          : whiteColor);
                    case 1:
                      return dotIndicatorCustom(
                          state.data.selectedDistrict == null
                              ? transparentColor
                              : whiteColor);
                    case 2:
                      return dotIndicatorCustom(
                          state.data.selectedWard == null
                              ? transparentColor
                              : whiteColor);
                    default:
                      return SizedBox.shrink();
                  }
                },
                itemExtentBuilder: (_, __) => 80.0,
                itemCount: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
