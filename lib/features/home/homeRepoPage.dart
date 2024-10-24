// ignore_for_file: file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../commons/routerPages/apiPage.dart';
import '../../commons/routerPages/dio_api.dart';
import '../../model/ProductModel.dart';

// final homeApiProvider = FutureProvider.autoDispose((ref) {
//   return getProduct(ref: ref);
// });

class HomeController extends GetxController {
  RxString search = ''.obs;
  List<ProductsModel> homedataList = [];
  getProduct() async {
    var response = await ApiMethod().postDioRequest(ApiUser.products);
    print("rsss $response");
    if (response['success'] == true) {
      return response;
    } else if (response['success'] == false) {
      return "Error: Some technical issue";
    } else {
      return "Error: Some technical issue";
    }
  }

  // final categaryIdProvider = StateProvider<String>((ref) {
  //   return '';
  // });

  // final categroryProvider = FutureProvider.autoDispose((ref) {
  //   final id = ref.watch(categaryIdProvider);
  //   return categroryProduct(ref: ref, id: id);
  // });

  categroryProduct({id}) async {
    dynamic data = {"category_id": id};
    var response =
        await ApiMethod().putDioRequest(ApiUser.products, data: data);
    print("rsss $response");
    if (response['success'] == true) {
      return response['data'];
    } else if (response['success'] == false) {
      return "Error: Some technical issue";
    } else {
      return "Error: Some technical issue";
    }
  }

  categories() async {
    var response = await ApiMethod().postDioRequest(ApiUser.category);

    if (response['success'] == true) {
      return response;
    } else if (response['success'] == false) {
      return "Error: Some technical issue";
    } else {
      return "Error: Some technical issue";
    }
  }
}
