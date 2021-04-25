import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/graden/graden_detail/bloc/detail_garden_cubit.dart';
import 'package:farmgate/src/screens/graden/graden_detail/bloc/detail_garden_state.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_history_action/widget/action_history_item_widget.dart';
import 'package:farmgate/src/screens/shimmer/action_simmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simplest/simplest.dart';

class ActionHistoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GardenDetailState state = context.watch<GardenDetailCubit>().state;

    return state.data.loadingHistory && state.data.shortListAction.length == 0
        ? ActionShimmer()
        : (state.data.shortListAction.length == 0
            ? Container(
                height: 400,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: <Widget>[
                        Container(
                            width: 150,
                            height: 150,
                            padding: EdgeInsets.all(40),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Colors.grey,
                                      Colors.grey.withOpacity(0.1),
                                    ])),
                            child: SvgPicture.asset(
                              'assets/images/tree.svg',
                              fit: BoxFit.cover,
                            )),
                        Positioned(
                          right: -30,
                          bottom: -50,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[300].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(150),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -20,
                          top: -50,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[300].withOpacity(0.15),
                              borderRadius: BorderRadius.circular(150),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'action_empty'.tr,
                      style: title.copyWith(color: beginGradientColor),
                    ),
                  ],
                )),
              )
            : SingleChildScrollView(
                child: Container(
                  height: 400,
                  child: ListView.separated(
                    separatorBuilder: (context, _) => SizedBox(height: 12),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: state.data.shortListAction.length,
                    itemBuilder: (context, index) => ActionHistoryItemWidget(
                        state.data.shortListAction[index]),
                  ),
                ),
              ));
  }
}
