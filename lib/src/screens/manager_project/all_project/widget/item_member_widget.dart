import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/manager_project/mem_partner_project_response.dart';
import 'package:farmgate/src/model/manager_project/my_project_response.dart';
import 'package:farmgate/src/screens/manager_project/all_project/cubit/all_project_cubit.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:farmgate/src/widgets/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

// ignore: must_be_immutable
class ItemMemberWidget extends CubitWidget<AllProjectCubit, AllProjectState> {
  Project item;

  ItemMemberWidget(this.item);

  static provider(Project item) {
    return BlocProvider(
      create: (context) => AllProjectCubit(),
      child: ItemMemberWidget(item),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<AllProjectCubit>().getMemberPartnerProject(item.id);
    super.afterFirstLayout(context);
  }

  @override
  void listener(BuildContext context, AllProjectState state) {
    // TODO: implement listener
    super.listener(context, state);
  }

  @override
  Widget builder(BuildContext context, AllProjectState state) {
    String userTypeText = 'farm'.tr;

    List<MemberPartner> listMemberPartner = state.data?.members;

    String _typeOfUser(int userType) {
      switch (userType) {
        case 2:
          return userTypeText = 'farm'.tr;
        case 3:
          return userTypeText = 'farmer_4c'.tr;
        case 3:
          return userTypeText = 'host'.tr;
        case 4:
          return userTypeText = 'manager'.tr;
        default:
          return userTypeText = 'none'.tr;
      }
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        color: whiteColor,
      ),
      child: AppProgressHUB(
        inAsyncCall: state.data.isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      borderRadius: BorderRadius.circular(50),
                    )),
                InkWell(
                  onTap: () {
                    context.read<AllProjectCubit>().joinProject(item.id);
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
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    '${'project'.tr} ${item.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: titleNew.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 5),
                  Text(
                    item.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: descNew.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        'project_address'.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: descNew.copyWith(color: beginGradientColor),
                      ),
                      Flexible(
                        flex: 1,
                        child: AutoSizeText(
                          item.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          style: descNew,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        'project_start_at'.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: descNew.copyWith(color: beginGradientColor),
                      ),
                      Flexible(
                        flex: 1,
                        child: AutoSizeText(
                          fullDateFormatter
                              .format(DateTime.parse(item.createdAt)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          style: descNew,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                ],
              ),
            ),
            Container(height: 2, color: backgroundColor),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Chọn đại lý và quản lý để giao dich : ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: textInput,
              ),
            ),
            Expanded(
              child: listMemberPartner == null
                  ? Center(child: Text('empty_member'.tr))
                  : ListView.separated(
                      primary: true,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = listMemberPartner.elementAt(index);
                        final fullName =
                            '${item?.lastName ?? ''} ${item?.firstName ?? ''}';
                        _typeOfUser(item?.permission ?? 1);
                        return InkWell(
                          onTap: () {
                            context.read<AllProjectCubit>().onSelectItem(item);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(2),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: item.avatarUrl.isNotEmpty
                                                  ? CachedNetworkImageProvider(
                                                      item.avatarUrl ?? '')
                                                  : new AssetImage(
                                                      Images.defaultAvatar),
                                              fit: BoxFit.cover,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        item.isSelect
                                            ? Container(
                                                height: 60,
                                                width: 60,
                                                padding: EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: SvgPicture.asset(
                                                  'assets/images/check_icon.svg',
                                                  color: Colors.white,
                                                ))
                                            : SizedBox.shrink()
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        fullName,
                                        style: titleNew,
                                      ),
                                      SizedBox(height: 10),
                                      Text('${'members'.tr} $userTypeText',
                                          style: descNew),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: DottedLine(color: Colors.grey, height: 1),
                        ),
                      ),
                      itemCount: listMemberPartner.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
