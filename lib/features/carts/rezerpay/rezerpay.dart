// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:developer';

import 'package:project/all_imports.dart';
import 'package:project/main.dart';
import 'package:razorpay_web/razorpay_web.dart';

final paymentProvider = Provider.autoDispose.family<PaymentGateway, Object?>(
    (ref, id) => PaymentGateway(ref: ref, id: id));

class PaymentGateway {
  final Ref<Object?> ref;
  Razorpay? _razorpay;
  // scafflld , naviagtion

  var id;

  PaymentGateway({required this.ref, this.id});

  intialGataway({
    required BuildContext context,
    double? totalAmmount,
  }) {
    _razorpay = Razorpay();
    Future.delayed(
      const Duration(microseconds: 1),
      () {
        _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, successFun);
        _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, errorFun);
        _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWalletFun);
      },
    );
  }

  successFun(PaymentSuccessResponse response) async {
    log("success payment response => ${response}");
    Future.delayed(Duration(microseconds: 1), () async {
      log(" success payment response => $response");
      return await ref
          .read(createOrderProvider)
          .createOrder(cartId: id, paymentMethod: 2);
    });
  }

  errorFun(PaymentSuccessResponse response) {
    log("error payment response => ${response.orderId}");
    log("error payment response => ${response.paymentId}");
    return navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (BuildContext context) => const CheckoutPage(),
    ));
  }

  externalWalletFun(PaymentSuccessResponse response) {
    log("wallet payment response => $response");
    return '';
  }

  paymentWinodowOpen(
      {required double ammount, String? phone, String? email, cartId}) {
    Map<String, dynamic> options = {
      'key': 'rzp_test_Gr4MFnNE0YOwvD',
      // 'key': 'rzp_live_S2LhMzvohsSb9g', // key
      'amount': '$ammount',
      'name': '',
      'cart_id': cartId,
      'description': '',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      "currency": "INR",
      'prefill': {'contact': '$phone', 'email': '$email'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      return _razorpay!.open(options);
    } catch (e) {
      log(" open error $e");
      return e.toString();
    }
  }
}
