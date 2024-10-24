// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project/all_imports.dart';
import 'package:project/commons/widgetsPages/appBarPage.dart';
import '../../commons/widgetsPages/flutter_secure_token.dart';

import '../chatRoom/chatRoom.dart';
import '../orderHistory/orderHisScreenPage.dart';
import '../userProfile/userProfileControllerpage.dart';
import '../userProfile/userProfileScreenPage.dart';
import 'save_address.dart';

class DrawerWidget extends ConsumerWidget {
  // var botompage;
  const DrawerWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileDetails = ref.watch(profilegetProvider);
    return profileDetails.when(
      loading: () => loaderCircular(),
      error: (error, stackTrace) => errorMethod(),
      data: (data) {
        // profileModel profiledata = profileModel.fromJson(data);
        return Drawer(
            width: 344.w,
            backgroundColor: AppColorBody.blue,
            shape: const RoundedRectangleBorder(),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(CupertinoIcons.clear_circled,
                              color: AppColorBody.white, size: 40.w)),
                      SizedBox(height: 40.h),
                      InkWell(
                        onTap: () => buildPush(
                            context: context,
                            widget: const UserProfilePage(backbutton: true)),
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 35.r,
                                backgroundImage: NetworkImage(
                                    data['data']['image'].toString(),
                                    scale: 1.0)),
                            SizedBox(
                              width: 12.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildText(
                                    color: AppColorText.white,
                                    text: data['data']['name'].toString(),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.w),
                                buildText(
                                    color: AppColorText.white,
                                    text:
                                        "${data['data']['country_code'].toString()} ${data['data']['phone'].toString()}",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.w),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),
                      InkWell(
                        onTap: () {
                          buildPush(context: context, widget: Bottombar());

                          final ctr = Get.put(BottomeController());
                          ctr.navigate.value = 1;
                        },
                        child: Container(
                            width: 250.w,
                            height: 38.h,
                            decoration: BoxDecoration(
                                color: AppColorBody.blueLit,
                                borderRadius: BorderRadius.circular(4.r)),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10.w),
                                  ImageIcon(
                                      const AssetImage(
                                          "assets/image/allCateg.png"),
                                      color: AppColorBody.white,
                                      size: 20.w),
                                  SizedBox(width: 14.w),
                                  buildText(
                                      color: AppColorText.white,
                                      text: "All categories",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.w),
                                ])),
                      ),
                      buildRow(
                          imageIcon: "assets/image/topDeals.png",
                          text: "Top Deals"),
                      InkWell(
                        onTap: () {
                          buildPush(
                              context: context,
                              widget: const OrderHistoryPage());
                        },
                        child: buildRow(
                            imageIcon: "assets/image/orderH.png",
                            text: "Order history"),
                      ),
                      buildRow(
                          imageIcon: "assets/image/trackO.png",
                          text: "Track Your Order"),
                      InkWell(
                        onTap: () =>
                            buildPush(context: context, widget: SavedAddress()),
                        child: buildRow(
                            icon: Icon(
                              Icons.bookmark_add_outlined,
                              color: Colors.white,
                              size: 20.w,
                            ),
                            text: "Saved Address"),
                      ),
                      InkWell(
                        onTap: () => buildPush(
                            context: context, widget: const Chat_Room()),
                        child: buildRow(
                            imageIcon: "assets/image/liveChat.png",
                            text: "Live chat"),
                      ),
                      InkWell(
                          onTap: () async {
                            ref.refresh(profilegetProvider);
                            final tokenCtr = Get.put(MyStorage());
                            await tokenCtr.deleteData('token');
                            navigatorRemove(
                                context: context, widget: LoginPage());
                          },
                          child: buildRow(
                              imageIcon: "assets/image/logout.png",
                              text: "Logout"))
                    ])));
      },
    );
  }
}

Widget buildRow({widgets, text, imageIcon, icon}) {
  return Padding(
    padding: EdgeInsets.only(top: 30.h),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(width: 10.w),
      icon ??
          ImageIcon(AssetImage(imageIcon),
              color: AppColorBody.white, size: 20.w),
      SizedBox(width: 14.w),
      buildText(
          color: AppColorText.white,
          text: text,
          fontWeight: FontWeight.w500,
          fontSize: 14.w),
      const Spacer(),
      widgets ?? const SizedBox()
    ]),
  );
}
