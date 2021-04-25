import 'dart:developer';
import 'dart:io';
import 'package:farmgate/src/network/http_overides.dart';
import 'package:farmgate/src/network/rest_client.dart';
import 'package:simplest/simplest.dart' hide test;
import 'package:test/test.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();

  test('Test graph authorize device', () async {
    final token =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzRiOWRjODY5MmYyY2JiYzQ2YTFiYjE3YWM4MDkzNGU0YmFmOGZjYWZiMzFjNmNkZTA1NTZjY2VkZGNkNzQ0NGM4NTRjYzM5MWQyODZmNDUiLCJpYXQiOjE2MDc1NzQ1NDQsIm5iZiI6MTYwNzU3NDU0NCwiZXhwIjoxNjM5MTEwNTQ0LCJzdWIiOiI5Iiwic2NvcGVzIjpbXX0.dnSfbn0PIKf5fOExNTBbEX5Y_iBha3NyIygtLeDf2z24qfz5WkgcCMgqBxmexbBCnxq9QHCVaSRctN-9w4tolsaRLAC9OFUo2HtZMXQSfL47lQPL98DM76L5KAiF4o5LFLcHwLlNNNK-5Xr7nAmAni_LlTSLci0zmnuy9xBan0IjLhWCmBv7pKGyoSvVjjE84c1iCXRG6keE5XKPId_ejYjO_5SlDP5tY-d8dwhVejM0wRDH98ucNZMUZEh-9gKPEWVyw1YUyACh4VqpetLEo5_UOsDEkMYAJLmzQTXZ0hU4pw3pctL62QH4FPsbEwzsfgCeo-PsV_NEhJ_6SzlcDwWQDmRE--dcg-FKcA-mjITLUrkhg9iPmQGdaMy8UGr6RSl0_HEBB0sbzjzi7W8aEsSgzsHfNzVsNzGS0OMWYc_7NWEzhH_xactsEgsGIo-KB-mm_WgGxSXux_ysGq-gTkk9qR8jMmXEx89GpVTKm7DoP7SR9qJzmBIgXar9KysdSBrXIdRYEXM3HsnbSZ7N7TPAgfPUwzHW2cvR3UcURvLM0mGfGCD7EzAI6WL3u-Dy3f9bv848YJyFxwB3t9qra5wZR8eesn71-DUizEdMJpIIHH_KfayHk8uvutBB0-yhq-dAdyKX-5UoSJUwjmD-vbqjrDU9ZHB01S2wV5b8ueA';
    final dio = Dio();
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    dio.options.headers["Authorization"] = "Bearer " + token;
    dio.options.headers["Accept"] = "application/json";
    final restClient = RestClient(dio);
    try {
      final resposne = await restClient.postNews(
          name: 'Kinh nghiệm làm vườn 4',
          description: 'Kinh nghiệm làm vườn 4 hay',
          content: 'content',
          categoryId: '33',
          language: 'vi',
          lat: '123123',
          long: '456456');
      print(resposne);
    } catch (e) {
      print(e);
    }

    expect(true, true);
  });
}
