import 'package:dotted_border/dotted_border.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/validations.dart';
import 'package:farmgate/src/screens/user_type/bloc/user_type_cubit.dart';
import 'package:farmgate/src/screens/user_type/widget/user_type_widget.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

const double _defaultPadding = 25.0;
const Color _colorRedAccent = Colors.redAccent;
const Color _colorGrey = Colors.grey;

class RequestUserTypeScreen extends CubitWidget<UserTypeCubit, UserTypeState> {
  static BlocProvider<UserTypeCubit> provider() {
    return BlocProvider(
      create: (context) => UserTypeCubit(),
      child: RequestUserTypeScreen(),
    );
  }

  final Validations _validations = Validations();
  final TextEditingController _controllerID = TextEditingController();
  final TextEditingController _controllerBusiness = TextEditingController();

  Widget _userIDWidget(BuildContext context, UserTypeCubit cubit, bool isId) {
    return cubit.state.data.userTypeModel.permistionID == 2
        ? SizedBox.shrink()
        : Container(
            color: Colors.white,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'id_cmnd'.tr,
                  style: titleNew,
                ),
                SizedBox(height: 16),
                _buildTextFieldContent(
                  hintTextKey: 'input_user_id',
                  controller: _controllerID,
                  validator: _validations.validateName,
                  inputType: TextInputType.number,
                ),
                SizedBox(height: 8),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: 'input_image_user_id_before'.tr + ": ",
                        style: body1.copyWith(color: _colorGrey)),
                    TextSpan(
                        text: '*',
                        style: body1.copyWith(color: _colorRedAccent))
                  ]),
                ),
                SizedBox(height: 8),
                cubit.state.data.imgIDBefore == null
                    ? GestureDetector(
                        onTap: () {
                          onSelectImageFromDevice(context, cubit, isId, true);
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(12),
                          color: Colors.grey,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: 200,
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: appIconColor,
                                  size: 70,
                                ),
                              ),
                            ),
                          ),
                        ))
                    : GestureDetector(
                        onTap: () {
                          onSelectImageFromDevice(context, cubit, isId, true);
                        },
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(cubit.state.data.imgIDBefore),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                new BorderRadius.all(Radius.circular(12)),
                          ),
                        )),
                SizedBox(height: 8),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: 'input_image_user_id_after'.tr + ": ",
                        style: body1.copyWith(color: _colorGrey)),
                    TextSpan(
                        text: '*',
                        style: body1.copyWith(color: _colorRedAccent))
                  ]),
                ),
                SizedBox(height: 8),
                cubit.state.data.imgIDAfter == null
                    ? GestureDetector(
                        onTap: () {
                          onSelectImageFromDevice(context, cubit, isId, false);
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(12),
                          color: Colors.grey,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: 200,
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: appIconColor,
                                  size: 70,
                                ),
                              ),
                            ),
                          ),
                        ))
                    : GestureDetector(
                        onTap: () {
                          onSelectImageFromDevice(context, cubit, isId, false);
                        },
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(cubit.state.data.imgIDAfter),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                new BorderRadius.all(Radius.circular(12)),
                          ),
                        )),
              ],
            ),
          );
  }

  Widget _userBusinessLicenseWidget(
      BuildContext context, UserTypeCubit cubit, bool isId) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'business'.tr,
            style: titleNew,
          ),
          SizedBox(height: 16),
          _buildTextFieldContent(
            hintTextKey: 'input_user_business',
            controller: _controllerBusiness,
            validator: _validations.validateName,
          ),
          SizedBox(height: 8),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: 'input_image_user_id_business'.tr + ": ",
                  style: body1.copyWith(color: _colorGrey)),
              TextSpan(text: '*', style: body1.copyWith(color: _colorRedAccent))
            ]),
          ),
          SizedBox(height: 8),
          cubit.state.data.imgBusiness == null
              ? GestureDetector(
                  onTap: () {
                    onSelectImageFromDevice(context, cubit, isId, false);
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12),
                    color: Colors.grey,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        height: 200,
                        child: Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: appIconColor,
                            size: 70,
                          ),
                        ),
                      ),
                    ),
                  ))
              : GestureDetector(
                  onTap: () {
                    onSelectImageFromDevice(context, cubit, isId, false);
                  },
                  child: Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Image.file(
                          cubit.state.data.imgBusiness,
                          fit: BoxFit.cover,
                        )),
                  ))
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: Colors.grey),
      title: Text(
        'change_user_type'.tr,
        style: headingBlack18,
      ),
      elevation: 1,
      actions: [
        IconButton(
          icon: Icon(Icons.check, color: beginGradientColor),
          onPressed: () {
            context.read<UserTypeCubit>().updateUserType(
                _controllerID.text.toString(),
                _controllerBusiness.text.toString());
          },
        )
      ],
      centerTitle: true,
    );
  }

  Future<ImageSource> showSelectImageSource(BuildContext context) async {
    FocusScope.of(context).unfocus();
    return showCupertinoModalPopup<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text('camera'.tr),
              onPressed: () {
                Navigator.pop(context, ImageSource.camera);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('gallery'.tr),
              onPressed: () {
                Navigator.pop(context, ImageSource.gallery);
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('cancel'.tr),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  void onSelectImageFromDevice(BuildContext context, UserTypeCubit cubit,
      bool isID, bool isBefore) async {
    final picker = ImagePicker();
    ImageSource source = await showSelectImageSource(context);

    if (source != null && source == ImageSource.camera) {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      if (pickedFile != null) {
        cubit.submitUpdateImg(pickedFile.path, isID, isBefore);
      }
    } else if (source != null && source == ImageSource.gallery) {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        cubit.submitUpdateImg(pickedFile.path, isID, isBefore);
      }
    }
  }

  Widget _buildTextFieldContent({
    @required String hintTextKey,
    @required TextEditingController controller,
    int minLine = 1,
    int maxLine = 1,
    @required Function validator,
    TextInputType inputType,
    bool obscureText = false,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 0.0, bottom: _defaultPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: hintTextKey.tr + ": ",
                  style: body1.copyWith(color: _colorGrey)),
              TextSpan(
                  text: '*',
                  style: body1.copyWith(
                      color: hintTextKey == 'email'
                          ? Colors.transparent
                          : _colorRedAccent))
            ]),
          ),
          SizedBox(height: 4),
          TextFormField(
            obscureText: obscureText,
            textInputAction: TextInputAction.done,
            controller: controller,
            validator: validator,
            minLines: minLine,
            maxLines: maxLine,
            style: textInput,
            keyboardType: inputType ?? TextInputType.text,
            autocorrect: false,
            onChanged: (value) {
              //formKey.currentState.validate();
            },
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _colorRedAccent, width: 1.0),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: beginGradientColor, width: 1.6),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: beginGradientColor, width: 0.7),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void listener(BuildContext context, UserTypeState state) {
    super.listener(context, state);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    super.afterFirstLayout(context);
  }

  @override
  Widget builder(BuildContext context, UserTypeState state) {
    UserTypeCubit userTypeCubit = context.read<UserTypeCubit>();
    return AppProgressHUB(
      inAsyncCall: state.data.isLoading,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'change_user_type_more'.tr,
                          style: textInput.copyWith(color: appIconColor),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'select_user_type'.tr,
                          style: titleNew,
                        ),
                        SizedBox(height: 16),
                        UserTypeWidget(
                          onSelectAction: (userTypeModel) {
                            userTypeCubit.changeUserType(userTypeModel);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  userTypeCubit.isShowID()
                      ? _userIDWidget(context, userTypeCubit, true)
                      : SizedBox.shrink(),
                  SizedBox(height: 4),
                  userTypeCubit.isShowBusinessLicense()
                      ? _userBusinessLicenseWidget(
                          context, userTypeCubit, false)
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
