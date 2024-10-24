// ignore_for_file: file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../commons/routerPages/apiPage.dart';

import '../../commons/routerPages/dio_api.dart';

final getOrderProvider = FutureProvider.autoDispose((ref) async {
  ref.keepAlive();
  return getOrder(ref: ref);
});

getOrder({Ref? ref}) async {
  var response = await ApiMethod().postDioRequest(ApiUser.getOrder);

  if (response['success'] == true) {
    return response;
  } else {
    return "Error: Some technical issue";
  }
}

// 0=CANCELED,1=CREATED,2=PREPARING,3=READY,4=DISPATCHED,5=DELIVERED,6=COMPLETED

final statusProvider = StateProvider<Map>((ref) {
  return {
    "0": "Your Order Cancelled",
    "1": "Your Order Create",
    "2": "Your Order Preparing",
    "3": "Your Items Ready",
    "4": "Yor Order Dispatched",
    "5": "Delivered",
    "6": "Complete"
  };
});

final orderstatusProvider = StateNotifierProvider((ref) {
  return StatusNotifier(ref: ref);
});

class StatusNotifier extends StateNotifier {
  Ref<Object?> ref;
  StatusNotifier({required this.ref}) : super("");
  // String statustype = "";
  orderstatus({statuss}) {
    if (statuss == 0) {
      state = ref.read(statusProvider.notifier).state["0"];
    } else if (statuss == 1) {
      state = ref.read(statusProvider.notifier).state["1"];
    } else if (statuss == 2) {
      state = ref.read(statusProvider.notifier).state["2"];
    } else if (statuss == 3) {
      state = ref.read(statusProvider.notifier).state["3"];
    } else if (statuss == 4) {
      state = ref.read(statusProvider.notifier).state["4"];
    } else if (statuss == 5) {
      state = ref.read(statusProvider.notifier).state["5"];
    } else {
      state = ref.read(statusProvider.notifier).state["6"];
    }
  }
}
