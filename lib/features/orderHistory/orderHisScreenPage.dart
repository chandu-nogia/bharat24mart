// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';

import 'package:project/all_imports.dart';

import '../../model/Get_order_model.dart';
import 'order_Provider.dart';

class OrderHistoryPage extends ConsumerStatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderHistoryPageState();
}

class _OrderHistoryPageState extends ConsumerState<OrderHistoryPage>
    with SingleTickerProviderStateMixin {
  int isShow = 0;
  late final TabController tabController;

  @override
  void initState() {
    ref.read(getOrderProvider);
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {});
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getOrder = ref.watch(getOrderProvider);

    return Container(
      color: Colors.white,
      child: getOrder.when(
          skipError: true,
          skipLoadingOnReload: true,
          skipLoadingOnRefresh: true,
          error: (error, stackTrace) => errorMethod(),
          loading: () => Center(
              child: CircularProgressIndicator(color: AppColorBody.blue)),
          data: (data) {
            GetOrder getorderList = GetOrder.fromJson(data);
            return Scaffold(
                appBar: AppBar(
                    // toolbarHeight: 100.h,
                    title: buildText(
                        color: AppColorText.black,
                        text: "Order History",
                        fontWeight: FontWeight.w500,
                        fontSize: 25.w),
                    centerTitle: true),
                body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(children: [
                      SizedBox(height: 10.h),
                      TabBar(
                          onTap: (value) {
                            setState(() {
                              isShow = value;
                            });
                          },
                          indicatorPadding: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          dividerColor: Colors.transparent,
                          indicatorColor: Colors.transparent,
                          controller: tabController,
                          tabs: [
                            buildTab(no: 0, text: "Active (2)", data: isShow),
                            buildTab(
                                data: isShow, no: 1, text: "Past Orders (20)"),
                          ]),
                      SizedBox(height: 20.h),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: tabController,
                                  children: [
                                    RefreshIndicator(
                                      color: AppColorBody.blue,
                                      onRefresh: () async {
                                        return ref.refresh(getOrderProvider);
                                      },
                                      child: ListView.builder(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: getorderList
                                              .data!.activeOrder!.length,
                                          itemBuilder: (context, index) {
                                            var statuss = getorderList
                                                .data!
                                                .activeOrder![index]
                                                .orderStatus!;

                                            print("status $statuss");
                                            String statustype = "";
                                            if (statuss == 0) {
                                              statustype = ref
                                                  .read(statusProvider.notifier)
                                                  .state["0"];
                                            } else if (statuss == 1) {
                                              statustype = ref
                                                  .read(statusProvider.notifier)
                                                  .state["1"];
                                            } else if (statuss == 2) {
                                              statustype = ref
                                                  .read(statusProvider.notifier)
                                                  .state["2"];
                                            } else if (statuss == 3) {
                                              statustype = ref
                                                  .read(statusProvider.notifier)
                                                  .state["3"];
                                            } else if (statuss == 4) {
                                              statustype = ref
                                                  .read(statusProvider.notifier)
                                                  .state["4"];
                                            } else if (statuss == 5) {
                                              statustype = ref
                                                  .read(statusProvider.notifier)
                                                  .state["5"];
                                            } else {
                                              statustype = ref
                                                  .read(statusProvider.notifier)
                                                  .state["6"];
                                            }

                                            var date = getorderList.data!
                                                .activeOrder![index].createdAt
                                                .toString()
                                                .substring(0, 10);

                                            return SizedBox(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.w),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          buildText(
                                                              color:
                                                                  AppColorText
                                                                      .black,
                                                              text:
                                                                  "ORDER ID: ${getorderList.data!.activeOrder![index].orderId}",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14.w),
                                                          SizedBox(width: 10.w),
                                                          buildText(
                                                              color:
                                                                  AppColorText
                                                                      .black,
                                                              text: date,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14.w)
                                                        ]),
                                                  ),
                                                  ListView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: getorderList
                                                          .data!
                                                          .activeOrder![index]
                                                          .items!
                                                          .length,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, inerindex) {
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.w),
                                                          child: Row(children: [
                                                            InkWell(
                                                              // onTap: () {
                                                              //   ref
                                                              //       .read(singleProductProvider
                                                              //           .call(getorderList
                                                              //               .data!
                                                              //               .activeOrder![
                                                              //                   index]
                                                              //               .items![
                                                              //                   inerindex]
                                                              //               .productUniId)
                                                              //           .future)
                                                              //       .then((value) => buildPush(
                                                              //           context:
                                                              //               context,
                                                              //           widget: Product_Summary(
                                                              //               values:
                                                              //                   true,
                                                              //               id: getorderList.data!.activeOrder![index].items![inerindex].productUniId)));
                                                              // },
                                                              child: SizedBox(
                                                                  height: 86.h,
                                                                  width: 86.w,
                                                                  child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(10.r),
                                                                      child: CachedNetworkImage(
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        imageUrl:
                                                                            "${ApiUser.netUrl}${getorderList.data!.activeOrder![index].items![inerindex].image}",
                                                                        placeholder:
                                                                            (context, url) =>
                                                                                const SizedBox(),
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            const Icon(Icons.error),
                                                                      )
                                                                      //  Image.network(
                                                                      //   "${ApiUser.netUrl}${getorderList[0].data!.activeOrder![index].items![inerindex].image}",
                                                                      //   fit: BoxFit.fill,
                                                                      // ),
                                                                      )),
                                                            ),
                                                            SizedBox(
                                                                width: 25.w),
                                                            InkWell(
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    buildText(
                                                                        color: AppColorText
                                                                            .black,
                                                                        text:
                                                                            "${getorderList.data!.activeOrder![index].items![inerindex].name}",
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            18.w),
                                                                    buildText(
                                                                        color: AppColorText
                                                                            .grey,
                                                                        text:
                                                                            "Quantity: ${getorderList.data!.activeOrder![index].items![inerindex].quantity}",
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            15.w),
                                                                    buildText(
                                                                        color: AppColorText
                                                                            .black,
                                                                        text:
                                                                            "\u{20B9} ${getorderList.data!.activeOrder![index].items![inerindex].totalAmount}",
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            16.w),
                                                                  ]),
                                                            ),
                                                          ]),
                                                        );
                                                      }),
                                                  Row(
                                                    children: [
                                                      ImageIcon(
                                                          const AssetImage(
                                                              "assets/image/outdelivery.png"),
                                                          color: AppColorBody
                                                              .deepGreen),
                                                      SizedBox(width: 13.w),
                                                      buildText(
                                                          color: AppColorText
                                                              .deepGreen,
                                                          text: statustype,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14.w),
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: () {
                                                          buildPush(
                                                              context: context,
                                                              widget:
                                                                  const TrackOrderPage());
                                                        },
                                                        child: buildContainerB(
                                                            borderRadius:
                                                                15.5.r,
                                                            height: 31.h,
                                                            width: 100.w,
                                                            value: false,
                                                            text: "Track Order",
                                                            fontSize: 14.w,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Divider(
                                                        height: 1,
                                                        color:
                                                            AppColorBody.grey),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                    RefreshIndicator(
                                        color: AppColorBody.blue,
                                        onRefresh: () async {
                                          return ref.refresh(getOrderProvider);
                                        },
                                        child: ListView.builder(
                                            physics:
                                                AlwaysScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: getorderList
                                                .data!.pastorder!.length,
                                            itemBuilder: (context, index) {
                                              var statuss = getorderList
                                                  .data!
                                                  .pastorder![index]
                                                  .orderStatus!;
                                              print("status $statuss");
                                              String statustype = "";
                                              if (statuss == 0) {
                                                statustype = ref
                                                    .read(
                                                        statusProvider.notifier)
                                                    .state["0"];
                                              } else if (statuss == 1) {
                                                statustype = ref
                                                    .read(
                                                        statusProvider.notifier)
                                                    .state["1"];
                                              } else if (statuss == 2) {
                                                statustype = ref
                                                    .read(
                                                        statusProvider.notifier)
                                                    .state["2"];
                                              } else if (statuss == 3) {
                                                statustype = ref
                                                    .read(
                                                        statusProvider.notifier)
                                                    .state["3"];
                                              } else if (statuss == 4) {
                                                statustype = ref
                                                    .read(
                                                        statusProvider.notifier)
                                                    .state["4"];
                                              } else if (statuss == 5) {
                                                statustype = ref
                                                    .read(
                                                        statusProvider.notifier)
                                                    .state["5"];
                                              } else {
                                                statustype = ref
                                                    .read(
                                                        statusProvider.notifier)
                                                    .state["6"];
                                              }

                                              var date = getorderList.data!
                                                  .pastorder![index].createdAt
                                                  .toString()
                                                  .substring(0, 10);

                                              return SizedBox(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.w),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            buildText(
                                                                color:
                                                                    AppColorText
                                                                        .black,
                                                                text:
                                                                    "ORDER ID: ${getorderList.data!.pastorder![index].orderId}",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14.w),
                                                            buildText(
                                                                color:
                                                                    AppColorText
                                                                        .black,
                                                                text: date,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14.w),
                                                          ]),
                                                    ),
                                                    ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount: getorderList
                                                            .data!
                                                            .pastorder![index]
                                                            .items!
                                                            .length,
                                                        shrinkWrap: true,
                                                        itemBuilder: (context,
                                                            inerindex) {
                                                          return Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4.w),
                                                            child: Row(
                                                                children: [
                                                                  InkWell(
                                                                    onTap:
                                                                        () {},
                                                                    child: Container(
                                                                        height: 86.h,
                                                                        width: 86.w,
                                                                        child: ClipRRect(
                                                                            borderRadius: BorderRadius.circular(10.r),
                                                                            child: CachedNetworkImage(
                                                                              fit: BoxFit.fill,
                                                                              imageUrl: "${ApiUser.netUrl}${getorderList.data!.pastorder![index].items![inerindex].image}",
                                                                              placeholder: (context, url) => const SizedBox(),
                                                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                            )
                                                                            //  Image.network(
                                                                            //   "${ApiUser.netUrl}${getorderList[0].data!.activeOrder![index].items![inerindex].image}",
                                                                            //   fit: BoxFit.fill,
                                                                            // ),
                                                                            )),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          40.w),
                                                                  InkWell(
                                                                    child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          buildText(
                                                                              color: AppColorText.black,
                                                                              text: "${getorderList.data!.pastorder![index].items![inerindex].name}",
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 18.w),
                                                                          buildText(
                                                                              color: AppColorText.grey,
                                                                              text: "Quantity: ${getorderList.data!.pastorder![index].items![inerindex].quantity}",
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 15.w),
                                                                          buildText(
                                                                              color: AppColorText.black,
                                                                              text: "\u{20B9} ${getorderList.data!.pastorder![index].items![inerindex].totalAmount}",
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 16.w),
                                                                        ]),
                                                                  ),
                                                                ]),
                                                          );
                                                        }),
                                                    Row(
                                                      children: [
                                                        ImageIcon(
                                                            const AssetImage(
                                                                "assets/image/outdelivery.png"),
                                                            color: AppColorBody
                                                                .deepGreen),
                                                        SizedBox(width: 13.w),
                                                        buildText(
                                                            color: AppColorText
                                                                .deepGreen,
                                                            text: statustype,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14.w),
                                                        Spacer(),
                                                        InkWell(
                                                            onTap: () {
                                                              buildPush(
                                                                  context:
                                                                      context,
                                                                  widget:
                                                                      const TrackOrderPage());
                                                            },
                                                            child: buildContainerB(
                                                                borderRadius:
                                                                    15.5.r,
                                                                height: 31.h,
                                                                width: 100.w,
                                                                value: false,
                                                                text:
                                                                    "Track Order",
                                                                fontSize: 14.w,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal))
                                                      ],
                                                    ),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Divider(
                                                            height: 1,
                                                            color: AppColorBody
                                                                .grey))
                                                  ]));
                                            }))
                                  ]))),
                      SizedBox(height: 30.h)
                    ])));
          }),
    );
  }
}
