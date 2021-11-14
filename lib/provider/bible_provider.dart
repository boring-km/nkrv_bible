import 'package:get/get.dart';

class BibleProvider extends GetConnect {

  void withToken(String token) {
    httpClient.addAuthenticator<Object?>((request) async {
      request.headers['x-access-token'] = token;
      return request;
    });
  }
}
