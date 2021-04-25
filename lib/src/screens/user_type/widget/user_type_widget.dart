import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/user_type/user_type_model.dart';
import 'package:farmgate/src/screens/user_type/bloc/user_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:simplest/simplest.dart';

class UserTypeWidget extends StatelessWidget {
  final Function(UserTypeModel) onSelectAction;

  const UserTypeWidget({
    Key key,
    @required this.onSelectAction,
  }) : super(key: key);

  Widget _buildTile(BuildContext context, UserTypeModel userTypeModel,
      {Function() onTap}) {
    UserTypeModel userTypeModelSelect =
        context.watch<UserTypeCubit>().state.data.userTypeModel;
    bool isSelect = userTypeModelSelect != null &&
        userTypeModelSelect.userType == userTypeModel.userType;
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(6.0),
        shadowColor: appIconColor,
        child: InkWell(
            onTap: onTap != null ? () => onTap() : () {},
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        image: DecorationImage(
                          image: AssetImage(userTypeModel?.image ?? ""),
                          fit: BoxFit.cover,
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
                          userTypeModel.userType.tr,
                          style: caption.copyWith(color: Colors.white),
                        ),
                      ),
                    )),
                isSelect
                    ? Positioned(
                        top: 5,
                        left: 5,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.4)),
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    UserTypeModel userType = new UserTypeModel();
    List<UserTypeModel> userTypes = userType.getListUserType();
    int row = 2;
    if (Device.get().isTablet) {
      row = 4;
    }

    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: userTypes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: row,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.3),
      itemBuilder: (context, index) {
        UserTypeModel userTypeModel = userTypes.elementAt(index);
        return _buildTile(context, userTypeModel, onTap: () {
          onSelectAction(userTypeModel);
        });
      },
    );
  }
}
