// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:get/get.dart';
import 'package:project/commons/routerPages/dio_api.dart';

import '../../../all_imports.dart';
import '../../../model/single_Product.dart';

int currentpageProvider = 0;

class SingleProductItem extends GetxController {
  RxList<SingleProduct> singleProductList = <SingleProduct>[].obs;
  RxBool loader = false.obs;
  RxBool changeData = true.obs;
  update_fn() {
    singleProductList.value = singleProductList.value.map((e) {
      print("vl:::::: ${e.data!.productDetails!.status}");
      e.data!.productDetails!.status = e.data!.productDetails!.status! + 1;
      return e;
    }).toList();
  }

  RxString prices = ''.obs;
  increement({required rsProduct}) {
    prices.value =
        (rsProduct * singleProductList[0].data!.productDetails!.status)
            .toString();
  }

  decrement() {
    singleProductList.value = singleProductList.value.map((e) {
      print("vl:::::: ${e.data!.productDetails!.status}");
      e.data!.productDetails!.status = e.data!.productDetails!.status! - 1;
      return e;
    }).toList();
  }

  Future singleProduct(id) async {
    var data = {'product_id': id};

    var response =
        await ApiMethod().postDioRequest(ApiUser.singleProduct, data: data);

    print("res r $response");

    if (response['success'] == true) {
      return response;
    } else if (response['status'] == false) {
      return "Error: Some technical issue";
    }
  }

  addToCart({data}) async {
    var responses =
        await ApiMethod().putDioRequest(ApiUser.addcart, data: data);

    if (responses['success'] == true) {
      messageField(msg: responses["message"], snacColor: Colors.green);

      return responses;
    }
    return "No Data";
  }

  @override
  void onClose() {
    loader.value = false;
    changeData.value = true;
    prices.value = '';
    singleProductList.value.clear();
    super.onClose();
  }
}
