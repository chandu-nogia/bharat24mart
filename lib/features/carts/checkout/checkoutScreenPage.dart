// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project/all_imports.dart';
import 'package:project/features/carts/checkout/address_page/add_address_provider.dart';

import '../../../commons/widgetsPages/appBarPage.dart';

import '../../../model/get_address.dart';

import '../rezerpay/rezerpay.dart';
import 'address_page/add_address_page.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  // final bool page;
  final dynamic data;
  const CheckoutPage({super.key, this.data});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  final TextEditingController homeController = TextEditingController();

  final TextEditingController officeController = TextEditingController();
  @override
  void initState() {
    ref.read(getAdressProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isCheckout = ref.watch(checkoutProvider);
    final isOnTap = ref.watch(onTapProvider);
    final getAdressBuild = ref.watch(getAdressProvider);
    // ref.read(getAdressProvider(context));

    List cartId = [];
    for (var user in widget.data['data']['cart']) {
      cartId.add(user['id']);
    }

    return Container(
      color: Colors.white,
      child: getAdressBuild.when(
          loading: () => loaderCircular(),
          error: (error, stackTrace) => errorMethod(),
          data: (data) {
            GetAdress getAddress = GetAdress.fromJson(data);
            return Scaffold(
                appBar: AppBar(
                  title: buildText(
                      color: AppColorText.blue,
                      fontSize: 25.w,
                      text: "Checkout",
                      fontWeight: FontWeight.w500),
                  centerTitle: true,
                  iconTheme: IconThemeData(color: AppColorBody.grey),
                ),
                body: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 40.h),
                              InkWell(
                                onTap: () {
                                  buildPush(
                                      context: context,
                                      widget: const AddAdress(page: false));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildText(
                                        color: AppColorText.black,
                                        text: "Add new address",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.w),
                                    // Container(
                                    //   child:
                                    //       Image.asset("assets/image/addicon.png"),
                                    // )
                                    Icon(
                                      Icons.add_circle_outline_outlined,
                                      color: AppColorBody.black,
                                      weight: 20,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 30.h),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: getAddress.data!.length,
                                  itemBuilder: (context, index) {
                                    return
                                        // Slidable(
                                        //   direction: Axis.horizontal,
                                        //   endActionPane: ActionPane(
                                        //       extentRatio: 0.3.w,
                                        //       motion: const ScrollMotion(),
                                        //       children: [
                                        //         const SlidableAction(
                                        //             padding: EdgeInsets.zero,
                                        //             onPressed: null,
                                        //             backgroundColor: Colors.white,
                                        //             foregroundColor: Colors.white,
                                        //             icon: Icons.share,
                                        //             label: ''),
                                        //         SlidableAction(
                                        //           flex: 4,
                                        //           padding: EdgeInsets.all(8.w),
                                        //           spacing: 5.2,
                                        //           autoClose: true,
                                        //           borderRadius:
                                        //               BorderRadius.circular(6.r),
                                        //           onPressed: (context) async {
                                        //             ref
                                        //                 .read(addAddressEditProvider
                                        //                     .notifier)
                                        //                 .deleteAddress(
                                        //                     id: getAddress
                                        //                         .data![index].id
                                        //                         .toString());
                                        //           },
                                        //           backgroundColor:
                                        //               AppColorBody.blue,
                                        //           foregroundColor: Colors.white,
                                        //           icon: CupertinoIcons.delete_solid,
                                        //         ),
                                        //       ]),
                                        //   child:

                                        Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                height: 10.h,
                                                width: 10.w,
                                                child: Radio(
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    activeColor:
                                                        AppColorBody.blue,
                                                    value: index,
                                                    groupValue: isCheckout,
                                                    onChanged: (int? value) {
                                                      ref
                                                          .read(checkoutProvider
                                                              .notifier)
                                                          .state = value!;
                                                    })),
                                            SizedBox(width: 10.w),
                                            buildText(
                                                color: AppColorText.black,
                                                text: getAddress
                                                    .data![index].type
                                                    .toString(),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.w),
                                            const Spacer(),
                                            InkWell(
                                                onTap: () async {
                                                  await buildPush(
                                                      context: context,
                                                      widget: AddAdress(
                                                        data: getAddress
                                                            .data![index],
                                                        page: true,
                                                      ));
                                                },
                                                child: Image.asset(
                                                    color: Colors.black,
                                                    "assets/image/editcheck.png")
                                                // const Icon(  editcheck.png
                                                //     Icons.edit_outlined)
                                                ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 310.w,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 15.w, left: 8.w),
                                                  child: Text(
                                                    textAlign: TextAlign.start,
                                                    getAddress.data![index]
                                                        .completeAddress
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15.w),
                                                  ),
                                                )),
                                            const Spacer(),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.h),
                                              child: InkWell(
                                                  onTap: () {
                                                    ref
                                                        .read(
                                                            addAddressEditProvider
                                                                .notifier)
                                                        .deleteAddress(
                                                            id: getAddress
                                                                .data![index].id
                                                                .toString());
                                                  },
                                                  child: const Icon(
                                                      CupertinoIcons
                                                          .delete_solid)),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 20.h),
                                      ],
                                      // ),
                                    );
                                  }),
                              SizedBox(height: 30.h),
                              buildText(
                                  color: AppColorText.black,
                                  text: "Payment method",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.w),
                              SizedBox(height: 20.h),
                              InkWell(
                                  onTap: () {
                                    ref.read(onTapProvider.notifier).state = 1;
                                  },
                                  child: buildOnTapCheckout(
                                      data: isOnTap, text: "Wallet", no: 1)),
                              InkWell(
                                  onTap: () {
                                    ref.read(onTapProvider.notifier).state = 2;
                                  },
                                  child: buildOnTapCheckout(
                                      data: isOnTap,
                                      text: "Cash on delivery",
                                      no: 2)),
                              InkWell(
                                  onTap: () {
                                    ref.read(onTapProvider.notifier).state = 3;
                                  },
                                  child: buildOnTapCheckout(
                                      data: isOnTap, text: "Online", no: 3)),
                              SizedBox(height: 50.h),
                            ]))),
                bottomNavigationBar: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                    child: ListView(shrinkWrap: true, children: [
                      buildText(
                          color: AppColorText.black,
                          text:
                              "Total ${widget.data['data']['cart'].length} items in cart",
                          fontWeight: FontWeight.w400,
                          fontSize: 14.w),
                      SizedBox(height: 22.h),
                      SizedBox(
                        height: 45.h,
                        child: HorizontalSlidableButton(
                            isRestart: true,
                            // initialPosition: SlidableButtonPosition.start,
                            height: 44.h,
                            // width: 1.sw,
                            buttonWidth: 70.0.w,
                            color: AppColorBody.white,
                            label: buildContainer(
                                borderColor: AppColorBody.blue,
                                color: AppColorBody.blue,
                                borderRadius: 4.r,
                                height: 44.h,
                                width: 56.w,
                                widget: ImageIcon(
                                    const AssetImage("assets/image/swipe.png"),
                                    color: AppColorBody.white,
                                    size: 12.w)),
                            child: Center(
                                child: buildText(
                                    color: AppColorText.blue,
                                    text: "Swipe to place order",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.w)),
                            onChanged: (position) async {
                              position == SlidableButtonPosition.start;
                              if (position == SlidableButtonPosition.end) {
                                if (getAddress.data!.isEmpty) {
                                  messageField(msg: "Please Add Address");
                                } else {
                                  if (ref.read(onTapProvider.notifier).state ==
                                      3) {
                                    Future.delayed(
                                        const Duration(milliseconds: 1),
                                        () async {
                                      await ref
                                          .read(paymentProvider.call(cartId))
                                          .intialGataway(context: context);

                                      await ref
                                          .read(paymentProvider.call(cartId))
                                          .paymentWinodowOpen(
                                              cartId: cartId,
                                              ammount: double.parse(widget
                                                      .data['data']
                                                          ['total_cart_amount']
                                                      .toString()) *
                                                  100,
                                              phone: '7023330560');
                                    });
                                  } else if (ref
                                          .read(onTapProvider.notifier)
                                          .state ==
                                      2) {
                                    await ref
                                        .read<OrderProduct>(createOrderProvider)
                                        .createOrder(
                                            cartId: cartId, paymentMethod: 1);
                                  } else {
                                    await ref
                                        .read<OrderProduct>(createOrderProvider)
                                        .createOrder(
                                            cartId: cartId, paymentMethod: 0);
                                  }
                                }
                              }

                              SlidableButtonPosition.start;
                            }),
                      ),
                      SizedBox(height: 30.h)
                    ])));
          }),
    );
  }

  Widget buildOnTapCheckout({data, no, text}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Row(
        children: [
          buildContainer(
              borderColor: AppColorBody.black,
              color: data == no ? AppColorBody.blue : AppColorBody.white,
              borderRadius: 2.r,
              height: 20.h,
              width: 20.w,
              widget: const SizedBox()),
          SizedBox(
            width: 13.w,
          ),
          buildText(
              color: AppColorText.black,
              text: text,
              fontWeight: FontWeight.w400,
              fontSize: 14.w),
        ],
      ),
    );
  }
}
