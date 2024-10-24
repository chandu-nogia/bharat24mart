// ignore_for_file: file_names

import 'package:project/all_imports.dart';
import 'package:project/features/cancelOrder/cancelOrderScreenPage.dart';
import 'package:project/features/chatRoom/chatRoom.dart';

class TrackOrderPage extends StatefulWidget {
  const TrackOrderPage({super.key});

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: buildText(
            color: AppColorText.black,
            text: "Track Order",
            fontWeight: FontWeight.w500,
            fontSize: 25.w),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                        color: AppColorBody.shadow,
                        offset: Offset(1.w, 1.w),
                        blurRadius: 4.w,
                        spreadRadius: 0)
                  ],
                  color: AppColorBody.white),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 14.w),
                child: Column(children: [
                  Row(
                    children: [
                      ImageIcon(const AssetImage("assets/image/timeClock.png"),
                          color: AppColorBody.grey),
                      SizedBox(width: 10.w),
                      SizedBox(
                        width: 200.w,
                        child: buildText(
                            color: AppColorText.grey,
                            text: "Delivery today at 3:00 pm",
                            fontWeight: FontWeight.w400,
                            fontSize: 14.w),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      ImageIcon(const AssetImage("assets/image/locImage.png"),
                          color: AppColorBody.grey),
                      SizedBox(width: 10.w),
                      SizedBox(
                        width: 200.w,
                        child: buildText(
                            color: AppColorText.grey,
                            text:
                                "Luminous tower, Flat E2, Sheikh ghat, Sylhet",
                            fontWeight: FontWeight.w400,
                            fontSize: 14.w),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                        color: AppColorBody.shadow,
                        offset: Offset(1.w, 1.w),
                        blurRadius: 4.w,
                        spreadRadius: 0)
                  ],
                  color: AppColorBody.white),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.w),
                child: Column(children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColorBody.blue,
                        radius: 20.r,
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildText(
                              color: AppColorText.black,
                              text: "John Doe Bhai",
                              fontWeight: FontWeight.w500,
                              fontSize: 16.w),
                          buildText(
                              color: AppColorText.grey,
                              text: "0123456789",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.w),
                        ],
                      ),
                      const Spacer(),
                      ImageIcon(const AssetImage("assets/image/callImage.png"),
                          color: AppColorBody.grey),
                      SizedBox(
                        width: 15.w,
                      ),
                      InkWell(
                        onTap: () {
                          buildPush(context: context, widget: const Chat_Room());
                        },
                        child: ImageIcon(
                            const AssetImage("assets/image/chatImage.png"),
                            color: AppColorBody.grey),
                      )
                    ],
                  )
                ]),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(
                        color: AppColorText.black,
                        text: "Order #1334426",
                        fontWeight: FontWeight.w500,
                        fontSize: 18.w),
                    buildText(
                        color: AppColorText.grey,
                        text: "Amount: \u{20B9} 500",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.w),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    buildPush(context: context, widget: const CancelOrder());
                  },
                  child: Container(
                    width: 96.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border:
                            Border.all(color: AppColorBody.blue, width: 2.w)),
                    child: Center(
                      child: buildText(
                          color: AppColorText.blue,
                          text: "Cancel order",
                          fontWeight: FontWeight.w400,
                          fontSize: 12.w),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20.h),
            buildText(
                color: AppColorText.black,
                text: "ETA: 15 minutes",
                fontWeight: FontWeight.w500,
                fontSize: 18.w),
            SizedBox(
              height: 20.h,
            ),
            buildOrder(text1: "Order placed", text2: "2:30 PM, 27/Jun/2024"),
            buildOrderLine(height: 20.h),
            buildOrder(
                text1: "Items processed",
                text2: "Bagged in warehouse at 2:40 pm"),
            buildOrderLine(height: 20.h),
            buildOrder(
                text1: "Delivering", text2: "Your couries is on the way"),
            Row(
              children: [
                buildOrderLine(height: 165.h, color: AppColorBody.grey),
                SizedBox(
                  width: 35.w,
                ),
                Image(
                  image: const AssetImage("assets/image/mapImage.png"),
                  height: 130.h,
                  width: 260.w,
                )
              ],
            ),
            buildOrder(
                text1: "Shopping delivered",
                text2: "Expected at 3:05 pm, 27/Jun/2024",
                color: AppColorBody.grey),
          ]),
        ),
      ),
    );
  }
}
