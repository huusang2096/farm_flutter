import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/search/tag_response.dart';
import 'package:farmgate/src/screens/search/bloc/search_cubit.dart';
import 'package:farmgate/src/screens/search/widget/new_search.dart';
import 'package:farmgate/src/screens/shimmer/news_simmer.dart';
import 'package:farmgate/src/screens/shimmer/tags_simmer.dart';
import 'package:farmgate/src/widgets/CustomChipChoice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

import 'bloc/search_state.dart';

class SearchWidget extends CubitWidget<SearchCubit, SearchState> {
  TextEditingController _searchController = TextEditingController();

  static provider() {
    return BlocProvider(
        create: (context) => SearchCubit(), child: SearchWidget());
  }

  @override
  void listener(BuildContext context, SearchState state) {
//    if (_searchController.text != state.data.tagSelect.name) {
//      _searchController.text = state.data.tagSelect.name ?? "";
//      _searchController.selection = TextSelection.fromPosition(
//          TextPosition(offset: _searchController.text.length));
//    }

    super.listener(context, state);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<SearchCubit>().getListTag();
    super.afterFirstLayout(context);
  }

  @override
  Widget builder(BuildContext context, SearchState state) {
    final _debouncer = Debouncer(milliseconds: 500);
    List<Tags> tags = state.data.tags;

    buildTipSearch(String text) {
      return Container(
        height: 400,
        child: Center(
            child: Text(text, style: titleNew.copyWith(color: Colors.grey))),
      );
    }

    buildListResult() {
      switch (state.data.statusSearch) {
        case "NORMAL":
          return buildTipSearch('enter_search_keywords'.tr);
          break;
        case "OK":
          return NewSearchWidget();
          break;
        case "SEARCH":
          return NewsShimmer();
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
            child: NewSearchWidget(),
          );
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 1,
        title: Container(
          height: 46.0,
          decoration: BoxDecoration(
            color: Color(0xFFE5E5E5).withOpacity(0.6),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          padding: EdgeInsets.only(right: 1.0),
          child: Center(
            child: TextField(
              style: textInput,
              controller: _searchController,
              decoration: InputDecoration(
                  prefixIcon: Container(
                    padding: EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      'assets/images/loupe.svg',
                      color: Colors.grey,
                      width: 25,
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
                  if (query.isBlank) {
                    query = ' ';
                  }
                  Tags tag = new Tags(id: 0, name: query, slug: query);
                  _searchController
                    ..text
                    ..selection = TextSelection.collapsed(
                        offset: _searchController.text.length);
                  print('Search Text :${query}');
                  context.read<SearchCubit>().getListNewbyTag(tag);
                });
              },
              textInputAction: TextInputAction.search,
            ),
          ),
        ),
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: SingleChildScrollView(
              child: Column(
            children: [
              state.data.tags.length != 0
                  ? CustomChipsChoice<Tags>.single(
                      isWrapped: true,
                      value: null,
                      options: CustomChipsChoiceOption.listFrom<Tags, Tags>(
                          source: tags,
                          value: (i, v) => v,
                          label: (i, v) => v.name),
                      itemConfig: CustomChipsChoiceItemConfig(
                          labelStyle: textInput, selectedColor: appIconColor),
                      onChanged: (Tags value) {
                        context.read<SearchCubit>().getListNewbyTag(value);
                      },
                    )
                  : Container(padding: EdgeInsets.all(6), child: TagsShimmer()),
              Container(height: 1, color: Colors.grey[300]),
              buildListResult(),
            ],
          )),
        ),
      ),
    );
  }
}
