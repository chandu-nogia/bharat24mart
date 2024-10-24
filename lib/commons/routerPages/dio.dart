// // import 'dart:convert';
// // ignore_for_file: prefer_const_constructors, use_build_context_synchronously

// import 'dart:developer';
// import 'package:dio/dio.dart';

// import 'package:project/all_imports.dart';
// import 'package:project/main.dart';

// import '../widgetsPages/flutter_secure_token.dart';

// // Map<String, dynamic> header = {};
// // final dioStateProvider = Provider<ApiMehtod>((ref) {
// //   return ApiMehtod(ref: ref);
// // });

// class ApiMehtod {
//   Ref? ref;
//   ApiMehtod({required this.ref});
//   Dio dio = Dio();

//   getMehtod({required String url}) async {
//     final token1 = await ref!.watch(storageProvider).readData('token');
//     var headers = {'Authorization': 'Bearer $token1'};

//     try {
//       Response response =
//           await dio.get(url, options: Options(headers: headers));
//       log("status code ${response.statusCode}");

//       if (response.statusCode == 200) {
//         return response.data;
//       } else if (response.statusCode == 401) {
//         // navigatorRemove(context: context, widget: LoginPage());
//         navigatorKey.currentState!.pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => LoginPage()),
//             (route) => false);
//         // return messageField(context, response.data['message']);
//       } else if (response.statusCode == 400) {
//         throw "Some technical issue";
//       } else if (response.statusCode == 404) {
//         throw "Some technical issue";
//       } else {
//         throw 'error';
//       }
//     } on DioException catch (err) {
//       log("post mehtod error ${err.response?.statusCode} ");
//       log("post mehtod error ${err.response?.data} ");
//       throw 'Error ${err.response?.statusCode}: ${err.response?.statusMessage}';
//     }
//   }

//   postMehtod({required String url}) async {
//     try {
//       final token1 = await ref!.watch(storageProvider).readData('token');
//       var headers = {'Authorization': 'Bearer $token1'};

//       Response response =
//           await dio.post(url, options: Options(headers: headers));

//       log("status code ${response.statusCode}");

//       if (response.statusCode == 200) {
//         print("post ## $response");
//         return response.data;
//       } else if (response.statusCode == 401) {
//         navigatorKey.currentState!.pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => LoginPage()),
//           (route) => false,
//         );

//         throw messageField(msg: response.data['message']);
//       } else if (response.statusCode == 400) {
//         return "Some technical issue";
//       } else if (response.statusCode == 404) {
//         throw "Some technical issue";
//       } else {
//         throw 'no data';
//       }
//     } on DioException catch (err) {
//       log("post mehtod error ${err.response?.statusCode} ");
//       log("post mehtod error ${err.response?.data} ");
//       throw 'Error ${err.response?.statusCode}: ${err.response?.statusMessage}';
//     }
//   }

//   putMethod({required String url, required data}) async {
//     final token1 = await ref!.watch(storageProvider).readData('token');
//     var headers = {'Authorization': 'Bearer $token1'};

//     try {
//       Response response =
//           await dio.post(url, data: data, options: Options(headers: headers));
//       log("status code ${response.statusCode}");

//       if (response.statusCode == 200) {
//         print("put method  ${response.data}");
//         return response.data;
//       } else if (response.statusCode == 401) {
//         navigatorKey.currentState!.pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => LoginPage()),
//           (route) => false,
//         );
//         // navigatorRemove(context: context, widget: LoginPage());
//         throw messageField(msg: response.data['message']);
//       } else if (response.statusCode == 400) {
//         throw "Some technical issue";
//       } else if (response.statusCode == 404) {
//         throw "Some technical issue";
//       } else {
//         throw 'Error';
//       }
//     } on DioException catch (err) {
//       log("post mehtod error ${err.response?.statusCode} ");
//       log("post mehtod error ${err.response?.data} ");
//       throw 'Error ${err.response?.statusCode}: ${err.response?.statusMessage}';
//     }
//   }
// }
