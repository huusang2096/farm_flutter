import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/location/cubit/user_place_cubit.dart';
import 'package:farmgate/src/screens/shimmer/location_simmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplest/simplest.dart';

class SearchPlaceScreen extends StatelessWidget {
  final _debouncer = Debouncer(milliseconds: 500);

  static provider(UserPlaceCubit cubit) {
    return BlocProvider.value(
      child: SearchPlaceScreen(),
      value: cubit,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserPlaceCubit, UserPlaceState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.bloc<UserPlaceCubit>();
        return Scaffold(
          appBar: buildAppbar(context, cubit),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                buildListResult(size, state, cubit)
              ],
            ),
          ),
        );
      },
    );
  }

  buildListResult(Size size, UserPlaceState state, UserPlaceCubit cubit) {
    switch (state.statusSearch) {
      case "NORMAL":
        return buildTipSearch('enter_search_keywords'.tr);
        break;
      case "OK":
        return Expanded(
          child: buildListViewSearch(size, state, cubit),
        );
        break;
      case "SEARCH":
        return Expanded(
          child: SingleChildScrollView(child: LocationShimmer()),
        );
        break;
      case "INVALID_REQUEST":
        return buildTipSearch('no_search_results_found'.tr);
        break;
      case "ZERO_RESULTS":
        return buildTipSearch('no_search_results_found'.tr);
        break;
      case "OVER_QUERY_LIMIT":
        return buildTipSearch('server_error_please_try_again'.tr);
      case "REQUEST_DENIED":
        return buildTipSearch('an_error_occurred_while_searching'.tr);
      case "UNKNOWN_ERROR":
        return buildTipSearch('server_error_please_try_again'.tr);
      default:
        return Expanded(
          child: buildListViewSearch(size, state, cubit),
        );
        break;
    }
  }

  buildTipSearch(String text) {
    return Container(
      child: Center(child: Text(text)),
    );
  }

  buildListViewSearch(Size size, UserPlaceState state, UserPlaceCubit cubit) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            width: size.width,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ListTile(
              onTap: () {
                cubit.changeMyLocationInSearchTap(state.listPlace[index]);
                Navigator.of(context).pop();
              },
              title: Text(
                state.listPlace[index].name,
                style: titleNew,
              ),
              subtitle: Text(
                state.listPlace[index].formattedAddress,
                style: descNew,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 4.0,
          );
        },
        itemCount: state.listPlace.length);
  }

  buildAppbar(BuildContext context, UserPlaceCubit cubit) {
    return PreferredSize(
      child: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Container(
          width: double.infinity,
          height: 46,
          decoration: BoxDecoration(
            color: Color(0xFFE5E5E5).withOpacity(0.6),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            style: textInput.copyWith(color: Colors.grey),
            decoration: InputDecoration(
                prefixIcon: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                hintText: 'search'.tr,
                hintStyle: textInput.copyWith(color: Colors.grey),
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none)),
            onChanged: (query) {
              _debouncer.run(() {
                _debouncer.run(() {
                  cubit.searchPlace(query);
                });
              });
            },
            autofocus: false,
            textInputAction: TextInputAction.search,
          ),
        ),
        elevation: 1,
        actions: <Widget>[
          InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Text('close'.tr,
                        style: titleBar.copyWith(color: Colors.grey))),
              )),
        ],
      ),
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }
}
