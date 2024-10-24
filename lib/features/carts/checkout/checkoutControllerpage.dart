// ignore_for_file: file_names

import 'package:project/all_imports.dart';

import '../../../commons/routerPages/dio_api.dart';
import '../../../main.dart';

final edit1Provider = StateProvider((ref) => true);
final edit2Provider = StateProvider((ref) => true);
final checkoutProvider = StateProvider((ref) => 0);
final onTapProvider = StateProvider((ref) => 1);

final createOrderProvider = Provider.autoDispose((ref) {
  return OrderProduct(ref: ref);
});

class OrderProduct {
  final Ref<Object?> ref;
  OrderProduct({required this.ref});

  Future createOrder({paymentMethod, cartId}) async {
    Map<dynamic, dynamic> data = {
      "payment_method": paymentMethod,
      "cart_id": cartId
    };

    var response =
        await ApiMethod().putDioRequest(ApiUser.createOreder, data: data);

    ref.refresh(getCartProvider.future).asStream();

    if (response['success'] == true) {
      print("datassss   @@%%%   $data");
      messageField(msg: response['message']);
      navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (context) => const OrderPlacedSuccessfull()));
      // buildPush(context: context, widget: const OrderPlacedSuccessfull());
      return response;
    } else if (response['success'] == false) {
      messageField(msg: response['message']);
      return "No data";
    } else {
      return messageField(msg: response["message"]);
    }
  }
}

final getAdressProvider = FutureProvider.autoDispose((ref) async {
  return getAdress(ref: ref);
});

getAdress({required Ref ref}) async {
  var response = await ApiMethod().getDioRequest(ApiUser.getAddress);

  if (response['success'] == true) {
    return response;
  } else if (response['success'] == false) {
    messageField(msg: response['message']);
    return "Error: Some technical issue";
  } else {
    return 'Error: Some technical issue';
  }
}

final walletProvider = FutureProvider.family((ref, ammount) {
  return wallet(ref: ref, amount: ammount);
});

wallet({Ref? ref, amount}) async {
  var response = await ApiMethod().postDioRequest(ApiUser.wallet);

  if (response['success'] == true) {
    messageField(msg: response['message']);
    if (int.parse(response['data']['amount'].toString()) > amount) {
      print('rrrrEE');
    } else {
      print("OP");
    }

    return response;
  } else if (response['success'] == false) {
    return messageField(msg: response['message']);
  }
}
