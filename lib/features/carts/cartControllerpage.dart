// ignore_for_file: file_names, avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore_for_file: deprecated_member_use, unused_result, prefer_typing_uninitialized_variables,

import 'package:project/commons/widgetsPages/ColorPage.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../commons/routerPages/apiPage.dart';
import '../../commons/routerPages/dio_api.dart';
import '../../commons/widgetsPages/snackBarPage.dart';
import 'cartScreenPage.dart';

final AutoDisposeProviderFamily<dynamic, Object?> cartDeleteProvider = Provider
    .autoDispose
    .family<dynamic, Object>((AutoDisposeProviderRef ref, id) =>
        CartEditNotifier(ref: ref).deleteCart(id: id));

final AutoDisposeFutureProvider getCartProvider =
    FutureProvider.autoDispose((ref) {
  ref.notifyListeners();
  return CartEditNotifier(ref: ref).getCart();
});

// final AutoDisposeStateProvider changeData =
//     StateProvider.autoDispose((AutoDisposeStateProviderRef ref) => true);
final AutoDisposeStateProvider addProductProvider =
    StateProvider.autoDispose((ref) => 1);

final AutoDisposeStateNotifierProvider cartQuantityProvider =
    StateNotifierProvider.autoDispose((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier {
  CartNotifier() : super('');
  bool loader = false;

  int addProduct = 1;
  void increement({required rsProduct}) {
    state = (rsProduct * addProduct);
  }
}

final AutoDisposeStateNotifierProvider<CartEditNotifier, dynamic>
    cartEditProvider =
    StateNotifierProvider.autoDispose<CartEditNotifier, dynamic>(
        (AutoDisposeStateNotifierProviderRef ref) =>
            CartEditNotifier(ref: ref));

class CartEditNotifier extends StateNotifier<dynamic> {
  Ref<Object?> ref;
  CartEditNotifier({required this.ref}) : super('');

  dynamic cartEdit({dynamic data}) async {
    Map<dynamic, dynamic> response =
        await ApiMethod().putDioRequest(ApiUser.editCart, data: data);

    if (response['success'] == true) {
      ref.refresh<AsyncValue<dynamic>>(getCartProvider);
      return response;
    } else if (response['success'] == false) {
      return messageField(msg: response['message']);
    } else {
      return 'Some technical issue';
    }
  }

  dynamic deleteCart({dynamic id}) async {
    Map<dynamic, dynamic> data = <dynamic, dynamic>{'cart_id': id};

    Map<dynamic, dynamic> response =
        await ApiMethod().putDioRequest(ApiUser.deleteCart, data: data);

    if (response['success'] == true) {
      ref.refresh<AsyncValue<dynamic>>(getCartProvider);
      messageField(msg: response["message"], snacColor: AppColorBody.red);
      data.clear();
      return response;
    } else if (response['success'] == false) {
      return messageField(msg: response['message']);
    } else {
      return 'Some technical issue';
    }
  }

  dynamic getCart() async {
    Map<dynamic, dynamic> response =
        await ApiMethod().postDioRequest(ApiUser.getCart);
    if (response['success'] == true) {
      return response;
    } else if (response['success'] == false) {
      return messageField(msg: response['message']);
    } else {
      return 'Error: Some technical issue';
    }
  }
}




//!        ===========================           //
void showTutorial({required BuildContext context}) async {
  await TutorialCoachMark(
    targets: [
      TargetFocus(identify: "Target 1", keyTarget: keyButton, contents: [
        TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Container(
                // color: Colors.red,
                // height: 100,
                // width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Slide to Delete Items -->",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Container(
                      height: 500,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/image/delete_item.png"),
                              fit: BoxFit.cover)),
                    )
                  ],
                ),
              );
            })
      ]),
      TargetFocus(identify: "Target 2", keyTarget: keyFab, contents: [
        TargetContent(
            align: ContentAlign.left,
            builder: (context, controller) {
              return const Text("This is a floating action button",
                  style: TextStyle(color: Colors.white));
            })
      ])
    ],
    colorShadow: AppColorBody.blue,
    textSkip: "SKIP",
    pulseAnimationDuration: Duration(milliseconds: 500),
    focusAnimationDuration: Duration(milliseconds: 500),
    onFinish: () => print("finish"),
    onClickTarget: (target) => print('target clicked'),
  )
    ..show(context: context);
}
