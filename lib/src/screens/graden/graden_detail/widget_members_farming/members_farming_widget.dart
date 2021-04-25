import 'package:dotted_border/dotted_border.dart';
import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/style.dart';
import 'package:farmgate/src/model/add_members/add_member_response.dart';
import 'package:farmgate/src/model/graden/graden_detail_response.dart';
import 'package:farmgate/src/screens/graden/graden_detail/bloc/detail_garden_cubit.dart';
import 'package:farmgate/src/screens/graden/graden_detail/bloc/detail_garden_state.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/custom_network_image.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/member_farming_shimmer_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/status_common.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class MembersFarmingWidget extends StatelessWidget {
  final double width = 80.0;
  final double height = 80.0;
  final String status;

  const MembersFarmingWidget({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GardenDetailCubit>().state;

    return Container(
      margin: EdgeInsets.only(top: 10.0),
      height: 120.0,
      width: double.infinity,
      child: state.data.detail == null
          ? MemberFarmingShimmer(height: height, width: width)
          : _buildListView(state),
    );
  }

  ListView _buildListView(GardenDetailState state) {
    final itemCount = (state.data.detail.gardenDetail.memberGarden == null ||
            state.data.detail.gardenDetail.memberGarden.isEmpty)
        ? 1
        : (state.data.detail.gardenDetail.memberGarden.length + 1);
    return ListView.separated(
      itemCount: itemCount,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) {
        return SizedBox(width: 20.0);
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          return _itemListDottedBorder(context, state.data.detail.gardenDetail);
        } else {
          final data = state.data.detail.gardenDetail.memberGarden[index - 1];
          return _itemListNotDottedBorder(data, context);
        }
      },
    );
  }

  Widget _showSelectPeople(BuildContext context, GardenDetailCubit cubit,
      GardenDetail gradenDetail) {
    final statusCheck = StatusAddMember.ADD_MEMBER;
    showModalBottomSheet(
        elevation: 10,
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        backgroundColor: Colors.white,
        builder: (BuildContext builder) {
          return StatefulBuilder(
            builder: (context, state) {
              return AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.decelerate,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DottedBorder(
                                    borderType: BorderType.Circle,
                                    //radius: Radius.circular(12),
                                    dashPattern: [4, 4],
                                    color: appIconColor,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () async {
                                          await cubit.handleAddMember(
                                              status: statusCheck);
                                          navigator.pop();
                                        },
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(width / 2)),
                                        child: Container(
                                          width: width,
                                          height: height,
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: appIconColor,
                                              size: 50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'add_new'.tr,
                                    textAlign: TextAlign.center,
                                    style:
                                        titleBar.copyWith(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 30),
                            Flexible(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DottedBorder(
                                    borderType: BorderType.Circle,
                                    //radius: Radius.circular(12),
                                    dashPattern: [4, 4],
                                    color: appIconColor,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () async {
                                          await navigator.pushNamed(
                                              AppRoute.allPeople,
                                              arguments: {
                                                'isDelete': false,
                                                'garden': gradenDetail,
                                              }).then((value) => {
                                                cubit.getGardenDetail(
                                                    gradenDetail.id)
                                              });
                                          navigator.pop();
                                        },
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(width / 2)),
                                        child: Container(
                                          width: width,
                                          height: height,
                                          padding: EdgeInsets.all(10),
                                          child: SvgPicture.asset(
                                            'assets/images/group.svg',
                                            color: appIconColor,
                                            height: 30,
                                            width: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'select_member'.tr,
                                    textAlign: TextAlign.center,
                                    style:
                                        titleBar.copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ));
            },
          );
        });
  }

  //edit member or people
  Widget _itemListNotDottedBorder(Member data, BuildContext context) {
    final statusCheck = StatusAddMember.EDIT_MEMBER;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context
                    .read<GardenDetailCubit>()
                    .handleAddMember(status: statusCheck, data: data),
                borderRadius: BorderRadius.all(Radius.circular(width / 2)),
                child: Container(
                  width: width + 4,
                  height: height + 4,
                  decoration: BoxDecoration(
                      //shape: BoxShape.circle,
                      borderRadius:
                          BorderRadius.all(Radius.circular(width / 2)),
                      border: Border.all(color: greyColor, width: 1)),
                  child: CustomNetworkImageOrFileWidget(
                      height: height,
                      width: width,
                      url: data?.image ??
                          'https://ict-imgs.vgcloud.vn/2020/09/01/19/huong-dan-tao-facebook-avatar.jpg'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: width + 4,
                child: Center(
                  child: Text(
                    '${data?.name ?? ' '}',
                    style: textBoldBlack,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            )
          ],
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => context
                .read<GardenDetailCubit>()
                .deleteMember(status: status, data: data),
            child: Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: greyColor300,
              ),
              child: Icon(
                Icons.close,
                color: blackColor,
                size: 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemListDottedBorder(
      BuildContext context, GardenDetail gradenDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DottedBorder(
          borderType: BorderType.Circle,
          //radius: Radius.circular(12),
          dashPattern: [4, 4],
          color: greyColor,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _showSelectPeople(
                    context, context.read<GardenDetailCubit>(), gradenDetail);
              },
              borderRadius: BorderRadius.all(Radius.circular(width / 2)),
              child: Container(
                width: width,
                height: height,
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: greyColor,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: width + 5,
            child: Center(
              child: Text(
                'add'.tr,
              ),
            ),
          ),
        )
      ],
    );
  }
}
