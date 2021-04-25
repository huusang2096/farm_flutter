import 'package:dotted_border/dotted_border.dart';
import 'package:farmgate/src/common/style.dart';
import 'package:farmgate/src/model/add_members/add_member_response.dart';
import 'package:farmgate/src/model/graden/graden_detail_response.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/custom_network_image.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/member_farming_shimmer_widget.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/status_common.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_pepole_farming/bloc/people_cubit.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class PepoleFarmingWidget extends StatelessWidget {
  final double width = 80.0;
  final double height = 80.0;
  final String status;
  final bool isDelete;
  final GardenDetail gradenID;

  const PepoleFarmingWidget(
      {Key key, this.status, this.isDelete, this.gradenID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PeopleCubit>().state;

    return AppProgressHUB(
      inAsyncCall: state.data.isLoading,
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.all(8),
        width: double.infinity,
        child: state.data.listMember == null
            ? MemberFarmingShimmer(height: height, width: width)
            : _buildListView(state),
      ),
    );
  }

  GridView _buildListView(PeopleState state) {
    final itemCount =
        (state.data.listMember == null || state.data.listMember.isEmpty)
            ? 1
            : (state.data.listMember.length + 1);
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: itemCount,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 4,
          childAspectRatio: 0.8),
      itemBuilder: (context, index) {
        if (index == 0) {
          return _itemListDottedBorder(context);
        } else {
          final data = state.data.listMember[index - 1];
          return _itemListNotDottedBorder(data, context, isDelete);
        }
      },
    );
  }

  //edit member or people
  Widget _itemListNotDottedBorder(
      Member data, BuildContext context, bool isDelete) {
    final statusCheck = StatusAddMember.EDIT_PEOPLE;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context
                    .read<PeopleCubit>()
                    .handlePeople(status: statusCheck, data: data),
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
            onTap: () {
              if (isDelete) {
                context
                    .read<PeopleCubit>()
                    .deletePeople(status: status, data: data);
              } else {
                context.read<PeopleCubit>().addGraden(data.id, gradenID);
              }
            },
            child: Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: greyColor300,
              ),
              child: Icon(
                isDelete ? Icons.close : Icons.check,
                color: blackColor,
                size: 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemListDottedBorder(BuildContext context) {
    final statusCheck = StatusAddMember.ADD_PEOPLE;
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
              onTap: () =>
                  context.read<PeopleCubit>().handlePeople(status: statusCheck),
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
