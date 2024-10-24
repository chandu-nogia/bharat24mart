// ignore_for_file: file_names

import 'package:project/all_imports.dart';

class CancelOrder extends StatefulWidget {
  const CancelOrder({super.key});

  @override
  State<CancelOrder> createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: buildText(
            color: AppColorText.black,
            text: "Cancel Order",
            fontWeight: FontWeight.w500,
            fontSize: 25.w),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [
          SizedBox(
            height: 50.h,
          ),
          const Image(image: AssetImage("assets/image/cancelO.png")),
          buildText(
              color: AppColorText.black,
              text: "Order Cancellation",
              fontWeight: FontWeight.w500,
              fontSize: 18.w),
          SizedBox(
            height: 11.h,
          ),
          SizedBox(
            width: 220.w,
            child: const Center(
                child: Text(
              "Are you sure you want to send a cancellation request?",
              textAlign: TextAlign.center,
            )),
          ),
          SizedBox(
            height: 30.h,
          ),
          InkWell(
            onTap: () {
              // setState(() {
              //   // loader = !loader;
              // });
              // buildPush(context: context, widget: const ProductDetails());
            },
            child: buildContainerB(value: loader, text: "Cancel Order"),
          ),
        ]),
      ),
    );
  }
}
