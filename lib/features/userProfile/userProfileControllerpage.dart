// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/commons/routerPages/dio_api.dart';
import '../../commons/routerPages/apiPage.dart';

import '../../commons/widgetsPages/snackBarPage.dart';

final imageProvider = Provider<String>((ref) {
  return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgLoFFWDuNrpPkxtTcERVyDe1vn_tPsmEBbw&usqp=CAU";
});

final profilegetProvider = FutureProvider.autoDispose((ref) async {
  // ref.keepAlive();

  var response = await ApiMethod().postDioRequest(ApiUser.profile);

  if (response['success'] == true) {
    return response;
  } else if (response['success'] == false) {
    return messageField(msg: response["message"]);
  } else {
    messageField(msg: response["message"]);
    return "Error: Some technical issue";
  }
});
