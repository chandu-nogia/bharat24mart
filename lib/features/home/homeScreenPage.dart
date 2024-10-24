// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import 'package:project/all_imports.dart';
import 'package:project/commons/widgetsPages/appBarPage.dart';
import 'package:project/commons/widgetsPages/future_data.dart';
// import 'package:project/features/home/homeRepoPage.dart';
import 'package:project/features/home/home_src.dart';

import '../../model/ProductModel.dart';
import 'homeRepoPage.dart';
import 'product_Summary/prodSummaryRepoPage.dart';
import 'product_Summary/search_products.dart';
import 'seeAllProductsummary/sub_categories.dart';

// import 'homeControllerpage.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    // final AsyncValue<dynamic> homeapiBuild =
    //     ref.watch<AsyncValue<dynamic>>(homeApiProvider);

    return RefreshIndicator.adaptive(
      color: AppColorBody.blue,
      onRefresh: () => Future.delayed(
          const Duration(milliseconds: 1), () => controller.getProduct()),
      child: Scaffold(
          key: _scaffoldKey,
          drawer: const DrawerWidget(),
          body: FutureData(
            fn: controller.getProduct(),
            data: (data) {
              if (data != null) {
                ProductsModel profileData = ProductsModel.fromJson(data);
                controller.homedataList.add(profileData);
                return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 28.h),
                                Row(children: [
                                  InkWell(
                                    onTap: () {
                                      _scaffoldKey.currentState?.openDrawer();
                                    },
                                    child: ImageIcon(
                                      const AssetImage(
                                          "assets/home/homeTop.png"),
                                      size: 36.w,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        buildText(
                                            color: AppColorText.black,
                                            text: "Deliver to",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.w),
                                        InkWell(
                                          onTap: () => _scaffoldKey.currentState
                                              ?.openDrawer(),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                buildText(
                                                    color: AppColorText.black,
                                                    text:
                                                        "Luminous tower sheikhghetv",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.w),
                                                const Icon(
                                                    Icons.keyboard_arrow_down)
                                              ]),
                                        )
                                      ]),
                                  const Spacer(),
                                  InkWell(
                                      onTap: () {
                                        // navigatorKey.currentState
                                        //     ?.push(MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             Bottombar()))
                                        //     .then((value) => ref
                                        //         .read(navigateProvider.notifier)
                                        //         .state = 1);
                                        buildPush(
                                            context: context,
                                            widget: HomeSearchPage());
                                      },
                                      child: Icon(Icons.search, size: 30.w))
                                ]),
                                SizedBox(height: 21.h),
                                SizedBox(
                                  width: 250.w,
                                  child: buildRichText(
                                      color: AppColorText.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25.w,
                                      widget: [
                                        const TextSpan(text: "Get your"),
                                        TextSpan(
                                            text: " Milk ",
                                            style: TextStyle(
                                              color: AppColorText.blue,
                                            )),
                                        const TextSpan(
                                            text: "delivered quickly"),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25.h),
                          SizedBox(
                            width: 1.sw,
                            height: 150.h,
                            child: CarouselSlider.builder(
                              options: CarouselOptions(
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  onPageChanged: (index, reason) {
                                    currentpageProvider = index;
                                  },
                                  scrollDirection: Axis.horizontal),
                              itemCount: controller
                                  .homedataList[0].data!.category!.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                      int pageViewIndex) =>
                                  Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.h),
                                child: SizedBox(
                                  height: 150.h,
                                  width: 315.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: controller.homedataList[0].data!
                                          .category![itemIndex].image
                                          .toString(),
                                      placeholder: (context, url) =>
                                          const SizedBox(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller
                                  .homedataList[0].data!.category!.length,
                              itemBuilder: (context, outerIndex) {
                                var itemData = controller.homedataList[0].data!
                                    .category![outerIndex];
                                return Container(
                                  child: itemData.products!.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: Column(children: [
                                            Row(
                                              children: [
                                                buildText(
                                                    color: AppColorText.blue,
                                                    text: itemData.name
                                                        .toString(),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18.w),
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    buildPush(
                                                        context: context,
                                                        widget:
                                                            SubCategoriesPage(
                                                                id:
                                                                    // ref
                                                                    //         .read(categaryIdProvider
                                                                    //             .notifier)
                                                                    //         .state =
                                                                    controller
                                                                        .homedataList[
                                                                            0]
                                                                        .data!
                                                                        .category![
                                                                            outerIndex]
                                                                        .id
                                                                        .toString()));
                                                  },
                                                  child: buildText(
                                                      color: AppColorText.grey,
                                                      text: "See All",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.w),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 14.h,
                                            ),
                                            SizedBox(
                                                height: 200.h,
                                                width: 1.sw,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: itemData
                                                        .products?.length,
                                                    itemBuilder:
                                                        (context, innerIndex) {
                                                      var item =
                                                          itemData.products![
                                                              innerIndex];
                                                      var discount =
                                                          "${double.parse(item.price.toString()) - double.parse(item.discount.toString())}";

                                                      return InkWell(
                                                        onTap: () {
                                                          buildPush(
                                                              context: context,
                                                              widget: Product_Summary(
                                                                  values: true,
                                                                  id: item.id
                                                                      .toString()));
                                                        },
                                                        child: buildImage(
                                                            network: item.image
                                                                .toString(),
                                                            text: item.product,
                                                            // ?.subcategories,
                                                            textRs: discount
                                                                .toString(),
                                                            canRs: item.price
                                                                .toString()),
                                                      );
                                                    })),
                                            SizedBox(height: 14.h)
                                          ]))
                                      : SizedBox(),
                                );
                              })
                        ]));
              } else {
                return Center(child: loaderCircular());
              }
            },
          )),
    );
  }

  // Widget buildRow(context, {navigator, widgets, text, imageIcon}) {
  //   return Padding(
  //     padding: EdgeInsets.only(top: 30.h),
  //     child: InkWell(
  //       onTap: () {
  //         buildPush(context: context, widget: navigator);
  //       },
  //       child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
  //         SizedBox(
  //           width: 10.w,
  //         ),
  //         ImageIcon(
  //           AssetImage(imageIcon),
  //           color: AppColorBody.white,
  //           size: 20.w,
  //         ),
  //         SizedBox(width: 14.w),
  //         buildText(
  //             color: AppColorText.white,
  //             text: text,
  //             fontWeight: FontWeight.w500,
  //             fontSize: 14.w),
  //         const Spacer(),
  //         widgets ?? const SizedBox()
  //       ]),
  //     ),
  //   );
  // }
}
