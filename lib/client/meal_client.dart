import 'dart:async';

import 'package:dio/dio.dart';

import 'dio_client.dart';

class MealAPiClient {
  static Future<Map<String, dynamic>> getMealCategories() {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    Future<Response> resp = DioClient.getClient().get('list.php?c=list');
    resp.then((resp) {
      if (resp.statusCode == 200) {
        dynamic data = resp.data;
        if (data != null) {
          completer.complete(resp.data);
        } else {
          completer.completeError(resp);
        }
      } else {
        completer.completeError(resp);
      }
    }).catchError((error) {
      completer.completeError(error);
    });
    return completer.future;
  }

  static Future<Map<String, dynamic>> getMealsForParticularCategory(String? strCategory) {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    Future<Response> resp = DioClient.getClient().get('filter.php?c=$strCategory');
    resp.then((resp) {
      if (resp.statusCode == 200) {
        dynamic data = resp.data;
        if (data != null) {
          completer.complete(resp.data);
        } else {
          completer.completeError(resp);
        }
      } else {
        completer.completeError(resp);
      }
    }).catchError((error) {
      completer.completeError(error);
    });
    return completer.future;
  }
}
