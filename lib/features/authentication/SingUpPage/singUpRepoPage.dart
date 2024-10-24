// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, file_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../commons/routerPages/apiPage.dart';
import '../../../commons/routerPages/dio_api.dart';

// import 'singUpControllerpage.dart';

// final authApiProvider =
//     Provider<Authentication>((ref) => Authentication(ref: ref));

class Authentication {


  Authentication();
  createAccount({required Map data}) async {
    var response =
        await ApiMethod().putDioRequest(ApiUser.signUpApi, data: data);
    dynamic datas = jsonEncode(response);
    dynamic res = jsonDecode(datas);

    // ref!.read(lodeingSignupprovider.notifier).state = false;

    return res;
  }

  Future loginApi({Map? data}) async {
    var response =
        await ApiMethod().putDioRequest(ApiUser.logInApi, data: data!);

    return response;
  }
}
