part of 'profile_cubit.dart';

class ProfileState {
  ProfileResponse profileResponse;
  ProfileRequest profileRequestt;
  ProfileRequestImg profileRequestImg;
  bool isLoading;
  bool isUploadImage;
  String userType;

  ProfileState(
      {this.profileResponse,
      this.profileRequestt,
      this.profileRequestImg,
      this.isLoading,
      this.isUploadImage,
      this.userType});

  ProfileState.from({ProfileState state}) {
    profileResponse = state.profileResponse;
    profileRequestt = state.profileRequestt;
    profileRequestImg = state.profileRequestImg;
    isLoading = state.isLoading;
    isUploadImage = state.isUploadImage;
    userType = state.userType;
  }

  ProfileState copyWith(
      {ProfileResponse profileResponse,
      ProfileRequest profileRequest,
      ProfileRequestImg profileRequestImg,
      bool isLoading,
      bool isUploadImage,
      String userType}) {
    return ProfileState(
        profileResponse: profileResponse ?? this.profileResponse,
        profileRequestt: profileRequest ?? this.profileRequestt,
        profileRequestImg: profileRequestImg ?? this.profileRequestImg,
        isLoading: isLoading ?? this.isLoading,
        isUploadImage: isUploadImage ?? this.isUploadImage,
        userType: userType ?? this.userType);
  }
}

class ProfileInitial extends ProfileState {
  ProfileInitial()
      : super(
            profileResponse: null,
            profileRequestt: null,
            profileRequestImg: null,
            isLoading: false,
            isUploadImage: false,
            userType: 'user_normal');
}

class GetProfileSuccessState extends ProfileState {
  GetProfileSuccessState(
      {ProfileResponse profileResponse, ProfileState state, String userType})
      : super(
            profileResponse: profileResponse,
            profileRequestt: state.profileRequestt,
            profileRequestImg: state.profileRequestImg,
            isLoading: state.isLoading,
            isUploadImage: state.isUploadImage,
            userType: userType);
}

class UploadImageState extends ProfileState {
  UploadImageState({
    bool isUpload,
    bool isLoading,
    ProfileState state,
  }) : super(
            isUploadImage: isUpload,
            profileResponse: state.profileResponse,
            profileRequestt: state.profileRequestt,
            profileRequestImg: state.profileRequestImg,
            isLoading: isLoading,
            userType: state.userType);
}

class UpdateProfileSuccessState extends ProfileState {
  UpdateProfileSuccessState(
      {ProfileResponse profileResponse, ProfileState state})
      : super(
            profileResponse: profileResponse,
            profileRequestt: state.profileRequestt,
            profileRequestImg: state.profileRequestImg,
            isLoading: state.isLoading,
            isUploadImage: state.isUploadImage,
            userType: state.userType);
}

class LogoutSuccessState extends ProfileState {
  LogoutSuccessState({ProfileState state})
      : super(
            profileRequestt: state.profileRequestt,
            profileResponse: state.profileResponse,
            profileRequestImg: state.profileRequestImg,
            isLoading: state.isLoading,
            isUploadImage: state.isUploadImage,
            userType: state.userType);
}

class ProfileChangeAddressState extends ProfileState {
  ProfileChangeAddressState(ProfileRequest profileRequest, ProfileState state)
      : super(
            profileRequestt: profileRequest,
            profileResponse: state.profileResponse,
            profileRequestImg: state.profileRequestImg,
            isLoading: state.isLoading,
            isUploadImage: state.isUploadImage,
            userType: state.userType);
}
