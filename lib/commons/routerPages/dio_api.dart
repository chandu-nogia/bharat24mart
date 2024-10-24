import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:project/all_imports.dart';

import '../widgetsPages/flutter_secure_token.dart';
import 'navigator_scr.dart';

Map<String, dynamic> header = {
  'Content-Type': 'application/json; charset=utf-8',
  // 'connectTimeout': const Duration(seconds: 5),
  // 'receiveTimeout': const Duration(seconds: 5),
  // 'responseType': ResponseType.json,
};

BaseOptions dioOptions = BaseOptions(
  // baseUrl: AppConstants.SERVER_API_URL,
  // headers: {},
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
  contentType: 'application/json; charset=utf-8',
  responseType: ResponseType.json,
);

class ApiMethod extends GetConnect {
  // Ref? ref;
  ApiMethod();
  // Dio dio = Dio(dioOptions)..interceptors.add(Logging());
  final tokenCtr = Get.put(MyStorage());
  Future<Map> getDioRequest(String url) async {
    try {
      final token1 = await tokenCtr.readData('token');
      var token = {'Authorization': 'Bearer $token1'};

      // response = await dio.get(url, options: Options(headers: token));
      final response = await get(url, headers: token);
      // dio.interceptors.add(Logging());
      log("response get success ${response.statusCode}");
      log("response get success ${response.body}");

      bool statusCode = DioHandling().dioStatus(response.statusCode ?? 0);
      log("success get Handling $statusCode ");
      if (statusCode == true) {
        return response.body;
      } else {
        return {"success": false};
      }
    } on DioException catch (err) {
      log(err.response?.data);
      // dio.interceptors.add(Logging());
      DioHandling().dioError(err);
      return {"success": false};
    }
  }

  Future<Map> postDioRequest(String url, {data}) async {
    try {
      final token1 = await tokenCtr.readData('token');
      var token = {'Authorization': 'Bearer $token1'};
      // token.isNotEmpty ? header['Authorization'] = "Bearer $token" : null;

      log("request data  $data");
      final response = await post(url, data, headers: token);
      // final response =
      //     await dio.post(url, data: data, options: Options(headers: token));

      log("response success ${response.statusCode}");
      log("response success ${response.body}");

      bool statusCode = DioHandling().dioStatus(response.statusCode ?? 0);
      log("success Handling $statusCode ");
      if (statusCode == true) {
        return response.body;
      } else {
        return {"success": false};
      }
    } on DioException catch (err) {
      log(err.response?.data);
      DioHandling().dioError(err);
      return {"success": false};
    }
  }

  Future<Map> putDioRequest(String url, {data}) async {
    // String token = await ref!.watch(storageProvider).readData('token');
    final token1 = await MyStorage()
        // ref!.watch(storageProvider)
        .readData('token');
    var token = {'Authorization': 'Bearer $token1'};
    try {
      // token.isNotEmpty ? header['Authorization'] = "Bearer $token" : null;
      // Response response =
      //     await dio.post(url, data: data, options: Options(headers: token));
      final response = await post(url, data, headers: token);

      bool statusCode = DioHandling().dioStatus(response.statusCode!);
      if (statusCode == true) {
        return response.body;
      } else {
        return {"success": false};
      }
    } on DioException catch (err) {
      log(err.response?.data);
      DioHandling().dioError(err);
      return {"success": false};
    }
  }

// // Delete Request
  // Future<Map> delDioRequest(String url,
  //     {dynamic data, String token = ''}) async {
  //   try {
  //     token.isNotEmpty ? header['Authorization'] = "Bearer $token" : null;
  //     Response response =
  //         await dio.delete(url, data: data, options: Options(headers: header));

  //     bool statusCode = DioHandling().dioStatus(response.statusCode!);
  //     if (statusCode == true) {
  //       return {"success": true, "data": response.data};
  //     } else {
  //       return {"success": false};
  //     }
  //   } on DioException catch (err) {
  //     log(err.response?.data);
  //     DioHandling().dioError(err);
  //     return {"success": false};
  //   }
  // }

  // getDioHeaderRequest(String url) async {
  //   try {
  //     header['Authorization'] = "Bearer $tokn";
  //     Response response =
  //         await Dio().get(url, options: Options(headers: header));

  //     return response.data;
  //   } on DioException catch (e) {
  //     log(e.response?.statusCode);
  //     log(e.response?.data);
  //     return e;
  //   }
  // }

  // // Post Reauest

  // postDioHeaderRequest(String url, {dynamic data}) async {
  //   dynamic tokn = await Tokens.getCurrentUser();
  //   header['Authorization'] = "Bearer $tokn";
  //   Response response;

  //   try {
  //     response =
  //         await Dio().post(url, data: data, options: Options(headers: header));

  //     return response.data;
  //   } on DioException catch (e) {
  //     log(e);
  //     return e.response?.data;
  //   }
  // }

// // PUT request
}

// Logging in Dio
// class Logging extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     log('REQUEST[${options.method}] => PATH: ${options.path}');
//     return super.onRequest(options, handler);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     log(
//       'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
//     );
//     return super.onResponse(response, handler);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     log(
//       'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
//     );
//     return super.onError(err, handler);
//   }
// }

class DioHandling {
  bool dioStatus(int statusCode, {String? msg}) {
    // final context = navigatorKey.currentContext;
    if (statusCode == 200 ||
        statusCode == 201 ||
        statusCode == 202 ||
        statusCode == 204) {
      // msg!.isNotEmpty ? snackBar(context!, msg) : null;
      return true;
    } else if (statusCode == 401) {
      // // Token Expired or Not Valid
      // msg!.isNotEmpty ? snackBar(context!, 'Token Expired') : null;
      navigationRemoveUntil(LoginPage());

      return false;
    } else if (statusCode == 404) {
      // //Id Not Found
      // msg!.isNotEmpty ? snackBar(context!, 'Id Not Exists') : null;
      return false;
    } else if (statusCode == 403) {
      // //Already Exists
      // msg!.isNotEmpty ? snackBar(context!, 'Already Exists') : null;
      return false;
    }
    return false;
  }

  dioError(DioException err) {
    // final context = navigatorKey.currentContext;
    if (err.type == DioExceptionType.badResponse) {
      if (err.response != null) {
        // snackBar(context!, 'Error Bad Response');
        messageField(msg: 'Error Bad Response');
        log('Error ${err.response!.statusCode}: ${err.response!.statusMessage}');
      } else {
        log('Error: ${err.message}');
      }
    } else if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      // snackBar(context!, 'Error  Timeout');
      messageField(msg: 'Error  Timeout');

      log('Connection timeout error: ${err.message}');
    } else if (err.type == DioExceptionType.connectionError) {
      // snackBar(context!, 'Error Connection');
      messageField(msg: 'Error Connection');
      log('Connection  error: ${err.message}');
    } else if (err.type == DioExceptionType.cancel) {
      messageField(msg: 'Error Cancel Request');
      log('Connection Cancel error: ${err.message}');
    } else {
      log('Error: ${err.message}');
    }

    messageField(msg: 'Something Went Wrong!');
  }
}
