// ignore_for_file: must_be_immutable, deprecated_member_use, unused_result, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:project/all_imports.dart';
import 'package:project/model/cart_model.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../home/product_Summary/prodSummaryRepoPage.dart';

// GlobalKey deleteKey = GlobalKey();
// List<TargetFocus> targets = [];
GlobalKey keyButton = GlobalKey();
GlobalKey keyFab = GlobalKey();

class CartPage extends ConsumerStatefulWidget {
  final bool backbutton;
  const CartPage({super.key, this.backbutton = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 0), () {
      ref.read(getCartProvider);
    });

    super.initState();
  }

  final ctr = Get.put(SingleProductItem());
  @override
  Widget build(BuildContext context) {
    // final loader = ref.watch(loaderData);

    final addProduct = ref.watch(addProductProvider);
    var cartgetBuild = ref.watch(getCartProvider);

    // ref.refresh(getCartProvider.future).whenComplete(() => true);
    // getCartModel.data!.cart!.length>0?

    return RefreshIndicator(
      color: AppColorBody.blue,
      onRefresh: () async => ref.refresh(getCartProvider.future).asStream(),
      child: Scaffold(
          appBar: AppBar(
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 20.w,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showTutorial(context: context);
                      });
                    },
                    child: Icon(
                      key: keyButton,
                      Icons.help,
                      color: AppColorBody.grey,
                    ),
                  ),
                )
              ],
              toolbarHeight: 60.h,
              automaticallyImplyLeading:
                  widget.backbutton == true ? true : false,
              title: buildText(
                  color: AppColorText.blue,
                  fontSize: 25.w,
                  text: "Cart",
                  fontWeight: FontWeight.w500),
              centerTitle: true,
              iconTheme: IconThemeData(color: AppColorBody.black)),
          body: cartgetBuild.when(
              skipError: true,
              skipLoadingOnReload: true,
              skipLoadingOnRefresh: true,
              loading: () => Center(
                  child: CircularProgressIndicator(color: AppColorBody.blue)),
              error: (error, stackTrace) => errorMethod(),
              data: (data) {
                GetCartModel getCartModel = GetCartModel.fromJson(data);

                return getCartModel.data!.cart!.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: buildText(
                                          color: AppColorText.blue,
                                          fontSize: 16.w,
                                          text:
                                              "${data['data']['cart'].length} items",
                                          fontWeight: FontWeight.w400)),
                                  SizedBox(height: 30.h),
                                  ListView.builder(
                                      reverse: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: data['data']['cart'].length,
                                      itemBuilder: (context, index) {
                                        String totalamount =
                                            "${data['data']['cart'][index]['total_amount']}";

                                        return SizedBox(
                                            child:
                                                data['data']['cart']
                                                        .toString()
                                                        .isNotEmpty
                                                    ? Column(children: [
                                                        Slidable(
                                                            direction:
                                                                Axis.horizontal,
                                                            endActionPane:
                                                                ActionPane(
                                                                    extentRatio:
                                                                        0.2.w,
                                                                    motion:
                                                                        const ScrollMotion(),
                                                                    children: [
                                                                  const SlidableAction(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      onPressed:
                                                                          null,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      foregroundColor:
                                                                          Colors
                                                                              .white,
                                                                      icon: Icons
                                                                          .share,
                                                                      label:
                                                                          ''),
                                                                  SlidableAction(
                                                                    padding: EdgeInsets
                                                                        .all(8
                                                                            .w),
                                                                    flex: 5,
                                                                    autoClose:
                                                                        true,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            6.r),
                                                                    onPressed:
                                                                        (context) async {
                                                                      await ref.read(cartDeleteProvider(data['data']['cart'][index]
                                                                              [
                                                                              'id']
                                                                          .toString()));
                                                                    },
                                                                    backgroundColor:
                                                                        AppColorBody
                                                                            .blue,
                                                                    foregroundColor:
                                                                        Colors
                                                                            .white,
                                                                    icon: CupertinoIcons
                                                                        .delete_solid,
                                                                  ),
                                                                ]),
                                                            child: SizedBox(
                                                                height: 57.h,
                                                                width: 1.sw,
                                                                child: Row(
                                                                    children: [
                                                                      InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (context) => Product_Summary(
                                                                                          id: getCartModel.data!.cart![index].product!.id.toString(),
                                                                                          values: true,
                                                                                        )));
                                                                          },
                                                                          child: SizedBox(
                                                                              height: 47.h,
                                                                              width: 33.w,
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: data['data']['cart'][index]['product']['image'].toString(),
                                                                                placeholder: (context, url) => const SizedBox(),
                                                                                errorWidget: (context, url, error) => new Icon(Icons.error),
                                                                              ))),
                                                                      SizedBox(
                                                                          width:
                                                                              25.w),
                                                                      InkWell(
                                                                        onTap: () => Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => Product_Summary(
                                                                                      id: getCartModel.data!.cart![index].product!.id.toString(),
                                                                                      values: true,
                                                                                    ))),
                                                                        child: Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              buildText(color: AppColorText.black, text: data['data']['cart'][index]['product_name'], fontWeight: FontWeight.w500, fontSize: 16.w),
                                                                              buildText(color: AppColorText.grey, text: "${data['data']['cart'][index]['product']['quantity']} ${data['data']['cart'][index]['product']['unit_Type']}", fontWeight: FontWeight.w500, fontSize: 16.w)
                                                                            ]),
                                                                      ),
                                                                      const Spacer(),
                                                                      Column(
                                                                          crossAxisAlignment: CrossAxisAlignment
                                                                              .end,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            buildText(
                                                                                color: AppColorText.black,
                                                                                text: "\u{20B9} $totalamount",
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 16.w),
                                                                            Row(children: [
                                                                              InkWell(
                                                                                  onTap: () {
                                                                                    if (data['data']['cart'][index]['product_quantity'] > 1) {
                                                                                      ref.read(cartEditProvider.notifier).cartEdit(data: {
                                                                                        'cart_id': data['data']['cart'][index]['id'],
                                                                                        'product_quantity': data['data']['cart'][index]['product_quantity'] - 1,
                                                                                      });
                                                                                    }
                                                                                  },
                                                                                  child: Container(
                                                                                      width: 20.w,
                                                                                      height: 20.h,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(4.r),
                                                                                        color: const Color(0x6545C8DC),
                                                                                      ),
                                                                                      child: Center(child: Icon(Icons.remove, color: AppColorBody.blue, size: 18.w)))),
                                                                              SizedBox(width: 10.w),
                                                                              buildText(color: AppColorText.blueGrey, fontSize: 16.w, text: addProduct == 0 ? "Add" : data['data']['cart'][index]['product_quantity'].toString(), fontWeight: FontWeight.w400),
                                                                              SizedBox(width: 10.w),
                                                                              InkWell(
                                                                                  onTap: () {
                                                                                    ref.read(cartEditProvider.notifier).cartEdit(data: {
                                                                                      'cart_id': data['data']['cart'][index]['id'].toString(),
                                                                                      'product_quantity': data['data']['cart'][index]['product_quantity'] + 1,
                                                                                    });
                                                                                  },
                                                                                  child: Container(
                                                                                      width: 20.w,
                                                                                      height: 20.h,
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: const Color(0x6545C8DC)),
                                                                                      child: Center(
                                                                                          child: Icon(
                                                                                        Icons.add,
                                                                                        color: AppColorBody.blue,
                                                                                        size: 18.w,
                                                                                      ))))
                                                                            ])
                                                                          ])
                                                                    ]))),
                                                        SizedBox(height: 22.h)
                                                      ])
                                                    : const Center(
                                                        child: Text(
                                                          "No data Please Add",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ));
                                      }),
                                  buildText(
                                      color: AppColorText.black,
                                      fontSize: 16.w,
                                      text: "Related Products",
                                      fontWeight: FontWeight.w400),
                                  SizedBox(height: 20.h),
                                  Container(
                                      child: getCartModel
                                              .data!.product!.isNotEmpty
                                          ? SizedBox(
                                              height: 200.h,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: getCartModel
                                                    .data!.product!.length,
                                                itemBuilder: (context, index) {
                                                  var discountprice = double
                                                          .parse(getCartModel
                                                              .data!
                                                              .product![index]
                                                              .price
                                                              .toString()) -
                                                      double.parse(getCartModel
                                                          .data!
                                                          .product![index]
                                                          .discount
                                                          .toString());

                                                  return InkWell(
                                                    onTap: () {
                                                      buildPush(
                                                          context: context,
                                                          widget: Product_Summary(
                                                              values: true,
                                                              id: getCartModel
                                                                  .data!
                                                                  .product![
                                                                      index]
                                                                  .id
                                                                  .toString()));
                                                    },
                                                    child: buildImage(
                                                        network: getCartModel
                                                            .data!
                                                            .product![index]
                                                            .image
                                                            .toString(),
                                                        text: getCartModel
                                                            .data!
                                                            .product![index]
                                                            .product
                                                            .toString(),
                                                        // ?.subcategories,
                                                        textRs: discountprice
                                                            .toString(),
                                                        canRs: getCartModel
                                                            .data!
                                                            .product![index]
                                                            .price
                                                            .toString()),
                                                  );
                                                },
                                              ),
                                            )
                                          : const SizedBox()),
                                  SizedBox(height: 20.h),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        buildText(
                                            color: AppColorText.black,
                                            fontSize: 16.w,
                                            text: "Subtotal",
                                            fontWeight: FontWeight.w400),
                                        buildText(
                                            color: AppColorText.black,
                                            text:
                                                "\u{20B9} ${double.parse(getCartModel.data!.totalCartAmount.toString()).toStringAsFixed(2)}",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.w)
                                      ]),
                                  SizedBox(height: 10.h),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        buildText(
                                            color: AppColorText.black,
                                            fontSize: 16.w,
                                            text: "Shipping fee",
                                            fontWeight: FontWeight.w400),
                                        buildText(
                                            color: AppColorText.black,
                                            text: "\u{20B9} 0",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.w)
                                      ]),
                                  SizedBox(height: 10.h),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        buildText(
                                            color: AppColorText.black,
                                            fontSize: 16.w,
                                            text: "Total",
                                            fontWeight: FontWeight.w500),
                                        buildText(
                                            color: AppColorText.black,
                                            text:
                                                "\u{20B9}   ${double.parse(getCartModel.data!.totalCartAmount.toString()).toStringAsFixed(2)}",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.w)
                                      ]),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          "You save \u{20B9} ${double.parse(getCartModel.data!.totalDiscountCartAmount.toString()).toStringAsFixed(2)} on complete Order",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 13.h))),
                                  SizedBox(height: 14.h),
                                  InkWell(
                                      onTap: () {
                                        ctr.loader.value = true;
                                        buildPush(
                                            context: context,
                                            widget: CheckoutPage(data: data));
                                        ctr.loader.value = false;
                                      },
                                      child: buildContainerB(
                                          value: ctr.loader.value,
                                          text: "Proceed to checkout"))
                                ])))
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("No Cart items"),
                            InkWell(
                                onTap: () {
                                  buildPush(
                                      context: context, widget: Bottombar());
                                  final ctr = Get.put(BottomeController());
                                  ctr.navigate.value = 0;
                                },
                                child: Text(
                                  "Go to Shoping",
                                  style: TextStyle(
                                      color: AppColorBody.blue, fontSize: 18.h),
                                )),
                          ],
                        ),
                      );
              })),
    );
  }
}
