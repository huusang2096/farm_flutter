import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/profile/profile_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:simplest/simplest.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_qr_code_state.dart';
part 'my_qr_code_cubit.freezed.dart';

class MyQrCodeCubit extends BaseCubit<MyQrCodeState> {
  MyQrCodeCubit() : super(Initial(DataQRCode()));

  @override
  void initData() {
    getProfile();
    return super.initData();
  }

  Future<void> getProfile() async {
    try {
      ProfileResponse response = await dataRepository.getProfile();
      if (response != null) {
        emit(Loaded(
            state.data.copyWith(profileResponse: response, isLoading: false)));
      }
    } catch (e) {
      emit(Loading(state.data.copyWith(isLoading: false)));
      handleAppError(e);
    }
  }

  Future<void> captureAndSharePng(GlobalKey<ScaffoldState> _scaffoldKey) async {
    try {
      if (state.data.profileResponse == null) {
        return;
      }
      RenderRepaintBoundary boundary =
          _scaffoldKey.currentContext.findRenderObject();
      final image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/qrcode.png').create();
      await file.writeAsBytes(pngBytes);
      await Share.shareFiles(['${tempDir.path}/qrcode.png'],
          text: 'qr_code'.tr);
    } catch (e) {
      snackbarService.showSnackbar(message: 'server_error'.tr);
    }
  }
}
