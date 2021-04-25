// To parse this JSON data, do
//
//     final videoResponse = videoResponseFromJson(jsonString);

import 'package:farmgate/src/model/news/news_model.dart';

class NewsDataResponse {
  NewsDataResponse({this.data, this.categoryID, this.nextPage});

  List<News> data;
  int categoryID;
  int nextPage;
}
