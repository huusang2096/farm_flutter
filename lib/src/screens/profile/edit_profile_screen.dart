import 'dart:io';

import 'package:farmgate/locator.dart';
import 'package:farmgate/src/common/resources.dart';
import 'package:farmgate/src/common/style.dart';
import 'package:farmgate/src/common/validations.dart';
import 'package:farmgate/src/model/profile/profile_request_img.dart';
import 'package:farmgate/src/screens/profile/cubit/profile_cubit.dart';
import 'package:farmgate/src/screens/profile/widgets/profile_gender.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

// ignore: must_be_immutable
class EditProfileScreen extends CubitWidget<ProfileCubit, ProfileState> {
  final _formKey = GlobalKey<FormState>();
  final Validations _validations = Validations();
  final _size72 = 100.0;
  ProfileRequestImg requestImg;

  TextEditingController _mobileController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'VN');
  DateTime timeBirthDay = DateTime.now();
  var prefixSelected = '';
  final _dateFormat = DateFormat('dd/MM/yyyy');
  final TextEditingController _textControllerBirthDay = TextEditingController();

  static BlocProvider<ProfileCubit> provider() {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(),
      child: EditProfileScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    super.afterFirstLayout(context);
    context.read<ProfileCubit>().getProfile();
  }

  @override
  void listener(BuildContext context, ProfileState state) {
    super.listener(context, state);
    if (state is GetProfileSuccessState) {
      _firstNameController = TextEditingController(
          text: state.profileResponse.data?.firstName ?? '');
      _lastNameController = TextEditingController(
          text: state.profileResponse.data?.lastName ?? '');
      _emailController =
          TextEditingController(text: state.profileResponse.data?.email ?? '');
      _mobileController =
          TextEditingController(text: state.profileResponse.data?.phone ?? '');
      _phoneNumber = PhoneNumber(
          phoneNumber: state.profileResponse.data?.phone ?? '',
          isoCode: 'VN',
          dialCode: '+84');
      _addressController.text =
          (state?.profileResponse?.data?.addressFormat ?? '') +
              ", " +
              (state?.profileResponse?.data?.address ?? '');
      prefixSelected = state.profileResponse.data?.gender ?? '';
      if (state.profileResponse != null &&
          state.profileResponse.data.dob != null) {
        _textControllerBirthDay.text = _dateFormat
            .format(state.profileResponse?.data?.dob ?? DateTime.now());
        timeBirthDay = state.profileResponse.data.dob;
      }
    }
    if (state is ProfileChangeAddressState) {
      _addressController.text = state.profileRequestt.formatAddess;
    }
    if (state is UpdateProfileSuccessState) {
      locator<SnackbarService>()
          .showSnackbar(message: 'update_profile_success'.tr);
    }
  }

  @override
  Widget builder(BuildContext context, ProfileState state) {
    return AppProgressHUB(
      inAsyncCall: state.isLoading,
      child: Scaffold(
        appBar: _buildAppBar(context, state),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: ListView(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            _buildHeaderEditProfile(context, state),
                            SizedBox(
                              height: 32,
                            ),
                            // first name
                            _buildBodyEditProfile(context, state),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderEditProfile(BuildContext context, ProfileState state) {
    File imgFile = state.profileRequestImg?.image;

    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey),
                borderRadius: BorderRadius.circular(80.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_size72),
              child: state.profileResponse == null
                  ? Image.asset(
                      Images.defaultAvatar,
                      height: _size72,
                      width: _size72,
                    )
                  : imgFile != null
                      ? Image.file(
                          imgFile,
                          height: _size72,
                          width: _size72,
                          fit: BoxFit.fill,
                        )
                      : _imgNull(context, state),
            ),
          ),
          Positioned(
            right: 0.0,
            bottom: 0.0,
            child: GestureDetector(
              onTap: () {
                if (!state.isUploadImage) {
                  onSelectImageFromDevice(context, state);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1.6,
                  ),
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(24.0),
                ),
                padding: EdgeInsets.all(6.0),
                child: Icon(
                  Icons.edit,
                  size: 12.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          state.isUploadImage
              ? Positioned(
                  right: 0.0,
                  bottom: 0.0,
                  child: SpinKitCircle(
                    color: appIconColor,
                    size: 28.0,
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildBodyEditProfile(BuildContext context, ProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(child: Text('phone'.tr)),
        InternationalPhoneNumberInput(
          onInputChanged: (value) {
            _phoneNumber = value;
          },
          countrySelectorScrollControlled: false,
          textFieldController: _mobileController,
          onInputValidated: (isValidate) {},
          initialValue: _phoneNumber,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          inputDecoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            hintText: 'phone'.tr,
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: greyColor),
            ),
          ),
          isEnabled: false,
        ),
        SizedBox(
          height: 16.0,
        ),
        Container(child: Text('email'.tr)),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          enabled: false,
          validator: _validations.validateEmail,
          onSaved: (String value) {
            _emailController.text = value;
          },
          decoration: InputDecoration(
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: greyColor),
            ),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        ProfileGenderWidget(
          pressSelect: (gender) {
            prefixSelected = gender;
          },
        ),
        SizedBox(
          height: 16.0,
        ),
        Container(child: Text('first_name'.tr)),
        TextFormField(
          keyboardType: TextInputType.name,
          controller: _firstNameController,
          validator: _validations.validateName,
          onSaved: (String value) {
            _firstNameController.text = value;
          },
        ),
        SizedBox(
          height: 16.0,
        ),
        Container(child: Text('last_name'.tr)),
        TextFormField(
          keyboardType: TextInputType.name,
          controller: _lastNameController,
          validator: _validations.validateName,
          onSaved: (String value) {
            _lastNameController.text = value;
          },
        ),
        SizedBox(
          height: 16.0,
        ),
        GestureDetector(
          onTap: () {
            _showDatePicker(context);
          },
          child: AbsorbPointer(
            child: TextFormField(
              controller: _textControllerBirthDay,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.right,
              decoration: new InputDecoration(
                prefixIcon: Center(
                  widthFactor: 1.0,
                  child: Text(
                    'date_of_birth'.tr,
                  ),
                ),
                border: _buildCustomerUnderlineBorder(color: Colors.grey),
                focusedBorder:
                    _buildCustomerUnderlineBorder(color: appIconColor),
                enabledBorder:
                    _buildCustomerUnderlineBorder(color: Colors.grey),
                errorBorder: _buildCustomerUnderlineBorder(color: Colors.grey),
                disabledBorder:
                    _buildCustomerUnderlineBorder(color: Colors.grey),
                focusedErrorBorder:
                    _buildCustomerUnderlineBorder(color: Colors.red),
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Container(child: Text('address'.tr)),
        GestureDetector(
          onTap: () => context.read<ProfileCubit>().pickAddress(),
          child: TextFormField(
            controller: _addressController,
            enabled: false,
            maxLines: null,
            decoration: InputDecoration(
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: greyColor),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        // CustomDefaultButton(
        //   text: 'update_user'.tr,
        //   press: () {
        //     _handleUpdate(context, state);
        //   },
        // ),
        // SizedBox(
        //   height: 40.0,
        // ),
      ],
    );
  }

  Widget _imgNull(BuildContext context, ProfileState state) {
    String _avatar = state.profileResponse.data?.avatarUrl ?? '';
    return _avatar != null
        ? CachedNetworkImage(
            memCacheWidth: 500,
            imageUrl: _avatar,
            errorWidget: (context, url, error) {
              return Image.asset(Images.defaultAvatar);
            },
            width: _size72,
            height: _size72,
            fit: BoxFit.fill,
          )
        : Image.asset(
            Images.defaultAvatar,
            height: _size72,
            width: _size72,
          );
  }

  void _handleUpdate(BuildContext context, ProfileState state) {
    if (_formKey.currentState.validate()) {
      context.read<ProfileCubit>().submitUpdate(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          gender: prefixSelected,
          address: _addressController.text,
          dob: timeBirthDay,
          isPickDate: _textControllerBirthDay.text.isEmpty);
    }
  }

  void onSelectImageFromDevice(BuildContext context, ProfileState state) async {
    final picker = ImagePicker();
    ImageSource source = await showSelectImageSource(context);

    if (source != null && source == ImageSource.camera) {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      if (pickedFile != null) {
        if (state.profileResponse != null) {
          context.read<ProfileCubit>().submitUpdateImg(pickedFile.path);
        }
      }
    } else if (source != null && source == ImageSource.gallery) {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (state.profileResponse != null) {
          context.read<ProfileCubit>().submitUpdateImg(pickedFile.path);
        }
      }
    }
  }

  _showDatePicker(BuildContext context) {
    DateTime timeBirthDaySelect = timeBirthDay;

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
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: 60,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            Container(
                              width: 60,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
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
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text('year'.tr,
                              style: textButton.copyWith(color: appIconColor)),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height:
                              MediaQuery.of(context).copyWith().size.height *
                                  0.3,
                          child: CupertinoDatePicker(
                            maximumDate: DateTime.now(),
                            initialDateTime: timeBirthDay,
                            onDateTimeChanged: (DateTime newDate) {
                              timeBirthDaySelect = newDate;
                            },
                            minuteInterval: 1,
                            mode: CupertinoDatePickerMode.date,
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            this._textControllerBirthDay.text =
                                _dateFormat.format(timeBirthDaySelect);
                            timeBirthDay = timeBirthDaySelect;
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green, gradient: linearGradient),
                            padding: EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(),
                                Text(
                                  'save_and_next'.tr,
                                  style: textButton,
                                ),
                                Icon(Icons.navigate_next,
                                    color: Colors.white, size: 28)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ));
            },
          );
        });
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

  Widget _buildAppBar(BuildContext context, ProfileState state) {
    return AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: greyColor),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: appIconColor),
            onPressed: () => _handleUpdate(context, state),
          )
        ],
        elevation: 1.0,
        title: Text('edit_profile'.tr, style: headingBlack18));
  }

  _buildCustomerUnderlineBorder({Color color}) {
    return UnderlineInputBorder(
        borderSide: BorderSide(color: color, width: 1.0));
  }

  @override
  void dispose(BuildContext context) {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    _textControllerBirthDay.dispose();
    super.dispose(context);
  }
}
