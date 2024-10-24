// ignore_for_file: file_names

import 'package:project/all_imports.dart';
// import 'package:project/features/home/product_Summary/prodSummaryScreenPage.dart';


Widget buildListView() {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: 20,
    itemBuilder: (context, index) {
      return Column(
        children: [
          SizedBox(
            height: 70.h,
            width: 1.sw,
            child: Row(
              children: [
                Container(
                  height: double.infinity,
                  width: 60.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/home/ShowImage.png"))),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildText(overflow: TextOverflow.ellipsis,
                          color: AppColorText.white,
                          text: "Milk Name hhhhhhhhhhgghhhh",
                          fontSize: 16.h,
                          fontWeight: FontWeight.w400),
                      buildText(
                          color: AppColorText.white,
                          text: "500 Ml",
                          fontSize: 12.w,
                          fontWeight: FontWeight.w400),
                      SizedBox(
                        height: 22.h,
                        width: 200.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText(
                                color: AppColorText.white,
                                text: "\u{20B9} 30.50",
                                fontSize: 12.w,
                                fontWeight: FontWeight.w400),
                            InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => Product_Summary(),
                                //     ));
                              },
                              child: buildContainer(
                                  borderRadius: 8.w,
                                  color: AppColorBody.yellow,
                                  height: 22.h,
                                  width: 60.w,
                                  borderColor: AppColorBody.yellow,
                                  widget: Center(
                                    child: Text(
                                      "Buy",
                                      style: TextStyle(
                                          color: AppColorText.white,
                                          fontSize: 16.h),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Divider(
            color: AppColorBody.white,
            thickness: 2.h,
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      );
    },
  );
}