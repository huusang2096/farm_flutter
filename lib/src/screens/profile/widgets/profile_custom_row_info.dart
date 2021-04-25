import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class CustomRowInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileState state = context.watch<ProfileCubit>().state;
    String _avatar = state.profileResponse.data?.avatarUrl ?? '';
    final _size72 = 100.0;
    return GestureDetector(
      onTap: () async {
        navigator
            .pushNamed(AppRoute.editProfileScreen)
            .then((value) => {context.read<ProfileCubit>().getProfile()});
      },
      child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _avatar.isNotEmpty
                        ? CachedNetworkImageProvider(_avatar)
                        : new AssetImage(Images.defaultAvatar),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                              state.profileResponse.data.firstName +
                                  ' ' +
                                  state.profileResponse.data.lastName,
                              style: textBoldWhite.copyWith(
                                  color: Colors.black, fontSize: 26)),
                        ),
                        Icon(
                          Icons.edit,
                          color: appIconColor,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.phone_in_talk_outlined,
                          color: appIconColor,
                          size: 20,
                        ),
                        SizedBox(width: 2),
                        Text(
                          state.profileResponse.data?.phone ?? '',
                          style: timeNews.copyWith(color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: appIconColor,
                          size: 20,
                        ),
                        SizedBox(width: 2),
                        Flexible(
                          flex: 1,
                          child: Text(
                            state.profileResponse.data.addressFormat +
                                ", " +
                                state.profileResponse.data.address,
                            style: timeNews.copyWith(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
