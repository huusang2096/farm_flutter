import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/graden/action_garden.dart';
import 'package:farmgate/src/screens/graden/graden_detail/bloc/detail_garden_cubit.dart';
import 'package:farmgate/src/screens/graden/graden_detail/bloc/detail_garden_state.dart';
import 'package:farmgate/src/screens/shimmer/list_action_garden_simmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:simplest/simplest.dart';

class ActionWidget extends StatelessWidget {
  final Function(ActionGarden) onSelectAction;

  const ActionWidget({
    Key key,
    @required this.onSelectAction,
  }) : super(key: key);

  Widget _buildTile(BuildContext context, ActionGarden actionGarden,
      {Function() onTap}) {
    return InkWell(
        onTap: onTap != null ? () => onTap() : () {},
        child: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    image: DecorationImage(
                      image:
                          CachedNetworkImageProvider(actionGarden?.image ?? ""),
                      fit: BoxFit.fill,
                    ))),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6.0),
                          bottomRight: Radius.circular(6.0))),
                  child: Center(
                    child: Text(
                      actionGarden.name.tr,
                      style: caption.copyWith(color: Colors.white),
                    ),
                  ),
                ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    GardenDetailState state = context.watch<GardenDetailCubit>().state;
    int row = 2;
    if (Device.get().isTablet) {
      row = 4;
    }

    return state.data.listActionGarden.length != 0
        ? GridView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: state.data.listActionGarden.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: row,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.3),
            itemBuilder: (context, index) {
              ActionGarden actionGarden =
                  state.data.listActionGarden.elementAt(index);
              return _buildTile(context, actionGarden, onTap: () {
                onSelectAction(actionGarden);
              });
            },
          )
        : ListGardenShimmer();
  }
}
