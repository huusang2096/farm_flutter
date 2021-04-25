import 'dart:io';

import 'package:farmgate/locator.dart';
import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/place_response.dart';
import 'package:farmgate/src/model/review/ImageSelect.dart';
import 'package:farmgate/src/model/search_place_request.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simplest/simplest.dart';
import 'package:uuid/uuid.dart';

import 'add_news_state.dart';

class AddNewsCubit extends BaseCubit<AddNewsState> {
  final locatorLocationService = locator<LocationService>();

  AddNewsCubit()
      : super(Initial(Data(imageSelects: [], myPlace: null, isLoading: false)));

  addImage(File file) async {
    List<ImageSelect> changeImageSelects = [...state.data.imageSelects];
    File compressedFile = file;
    if (file != null) {
      compressedFile =
          await FlutterNativeImage.compressImage(file.path, quality: 50);
    }
    ImageSelect imageSelect = new ImageSelect();
    imageSelect.url = compressedFile;
    imageSelect.id = Uuid().v4();
    changeImageSelects.insert(0, imageSelect);
    emit(ImageChange(state.data.copyWith(imageSelects: changeImageSelects)));
  }

  postData(String name, String description, String content) async {
    if (name.isNullOrBlank) {
      snackbarService.showSnackbar(message: 'please_add_title_post'.tr);
      return;
    }

    if (content.isNullOrBlank) {
      snackbarService.showSnackbar(message: 'please_add_description_post'.tr);
      return;
    }

    if (state.data.imageSelects.length == 1) {
      snackbarService.showSnackbar(message: 'please_add_image'.tr);
      return;
    }

    if (state.data.myPlace == null) {
      snackbarService.showSnackbar(message: 'please_add_location_post'.tr);
      return;
    }

    String descriptionText = description.substring(
        0, description.length > 100 ? 100 : description.length);
    print(descriptionText);
    try {
      emit(ImageChange(state.data.copyWith(isLoading: true)));
      final place = await dataRepository.postNews(
          name: name,
          description: descriptionText,
          content: content,
          categoryId: "33",
          language: language,
          lat: state.data.myPlace.lat.toString(),
          long: state.data.myPlace.lng.toString(),
          picture: state.data.imageSelects[0].url);
      if (place != null) {
        emit(ImageChange(state.data.copyWith(isLoading: false)));
        final dialogResponse = await dialogService.showDialog(
            title: kAppName, description: 'add_post_done'.tr);
        if (dialogResponse.confirmed) {
          navigator.pop();
          return;
        }
      }
    } catch (e) {
      emit(ImageChange(state.data.copyWith(isLoading: false)));
      handleAppError(e);
      logger.e(e);
    }
  }

  deleteImage(ImageSelect imageSelect) {
    List<ImageSelect> changeImageSelects = [...state.data.imageSelects];
    changeImageSelects.remove(imageSelect);
    emit(ImageChange(state.data.copyWith(imageSelects: changeImageSelects)));
  }

  addMultiImage(List<Asset> images) async {
    try {
      List<ImageSelect> changeImageSelects = [...state.data.imageSelects];
      await Future.forEach(images, (asset) async {
        final byteData = await asset.getThumbByteData(700, 700);
        final tempFile =
            File('${(await getTemporaryDirectory()).path}/${asset.name}');
        final file = await tempFile.writeAsBytes(
          byteData.buffer
              .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
        );
        ImageSelect imageSelect = new ImageSelect();
        imageSelect.url = file;
        imageSelect.id = Uuid().v4();
        changeImageSelects.insert(0, imageSelect);
      });
      emit(ImageChange(state.data.copyWith(imageSelects: changeImageSelects)));
    } catch (e) {
      logger.e(e);
    }
  }

  placeChange(Place myPlace) {
    emit(PlaceChange(state.data.copyWith(myPlace: myPlace)));
  }

  Future<void> setCurrentLocation() async {
    try {
      await locatorLocationService.fetchLocation(askPermission: true);
      Position position = locatorLocationService.position;
      final place = await getPlaceByLatLng(
          latitude: position.latitude, longitude: position.longitude);
      emit(PlaceChange(state.data.copyWith(myPlace: place)));
    } catch (e) {
      handleAppError(e);
      //logger.e(e);
    }
  }

  Future<Place> getPlaceByLatLng({double latitude, double longitude}) async {
    try {
      String latLng = latitude.toString() + "," + longitude.toString();
      Place place = new Place();
      final searchPlaceRequest = new SearchPlaceRequest(
        key: apiKey,
        language: language,
        region: region,
        latLng: latLng,
      );
      final response =
          await dataRepository.searchPlaceByLatLng(searchPlaceRequest);

      final listResults = response.results ?? [];
      if (response.results.length > 0) {
        place.formattedAddress = listResults.first.formattedAddress ?? "";
        place.lat = latitude;
        place.lng = longitude;
        place.name = listResults.first.formattedAddress ?? "";
      } else {
        place.formattedAddress = "TP Hồ Chí Minh";
        place.lat = latitude;
        place.lng = longitude;
        place.name = "";
      }
      return place;
    } catch (e) {
      handleAppError(e);
      return Place();
    }
  }
}
