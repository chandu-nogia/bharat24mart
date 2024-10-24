// ignore_for_file: camel_case_types, must_be_immutable, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, unused_local_variable, unnecessary_brace_in_string_interps, use_build_context_synchronously, file_names, unused_result

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import 'package:project/all_imports.dart';
import 'package:project/commons/widgetsPages/future_data.dart';

import '../../../model/single_Product.dart';

import '../../userProfile/userProfileScreenPage.dart';
import '../seeAllProductsummary/CategoriesPage.dart';
import 'prodSummaryRepoPage.dart';

class Product_Summary extends StatefulWidget {
  dynamic id;
  bool values;
  Product_Summary({super.key, this.id, required this.values});

  @override
  State<Product_Summary> createState() => _Product_SummaryState();
}

class _Product_SummaryState extends State<Product_Summary> {
  @override
  void dispose() {
    controller.loader.value = false;
    controller.changeData.value = true;
    controller.prices.value = '';
    controller.singleProductList.value.clear();
    super.dispose();
  }

  @override
  void initState() {
    controller.singleProduct(widget.id);
    super.initState();
  }

  final controller = Get.put(SingleProductItem());
  @override
  Widget build(BuildContext context) {
    // final isChange = ref.watch(changeData);

    return Scaffold(
      body: widget.values == true
          ? FutureData(
              fn: controller.singleProduct(widget.id),
              data: (data) {
                controller.singleProductList.value
                    .add(SingleProduct.fromJson(data));
                // SingleProduct singleProductList = SingleProduct.fromJson(data);
                // print("oosss  $singleProductList");
                // SingleProduct singleProduct = SingleProduct.fromJson(data);

                var body =
                    controller.singleProductList[0].data!.productDetails!;
                String price =
                    "${double.parse(body.price.toString()) - double.parse(body.discount.toString())}";

                List<String> item = [
                  body.image.toString(),
                  body.image.toString()
                ];
                return SingleChildScrollView(
                    child: Obx(
                  () => Column(
                    children: [
                      SizedBox(height: 30.h),
                      const Align(
                          alignment: Alignment.centerLeft, child: BackButton()),
                      Padding(
                          padding: const EdgeInsets.only(right: 30, left: 30),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(height: 10.h),
                                // InkWell(
                                //     onTap: () {
                                //       Navigator.pop(context);
                                //     },
                                //     child: Icon(Icons.clear_outlined,
                                //         color: AppColorBody.white, size: 20.h)),
                                Center(
                                    child: SizedBox(
                                        // width: 204.w,
                                        // height: 200.h,
                                        child: CarouselSlider(
                                            items: item.map((e) {
                                              return CachedNetworkImage(
                                                height: 47.h,
                                                imageUrl: e,
                                                placeholder: (context, url) =>
                                                    const SizedBox(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        new Icon(Icons.error),
                                              );
                                              //  Image.network(e);
                                            }).toList(),
                                            options: CarouselOptions(
                                                initialPage: 0,
                                                enableInfiniteScroll: true,
                                                reverse: false,
                                                autoPlay: true,
                                                autoPlayInterval:
                                                    const Duration(seconds: 3),
                                                autoPlayAnimationDuration:
                                                    const Duration(
                                                        milliseconds: 800),
                                                autoPlayCurve:
                                                    Curves.fastOutSlowIn,
                                                onPageChanged: (index, reason) {
                                                  currentpageProvider = index;
                                                },
                                                scrollDirection:
                                                    Axis.horizontal)))),
                                SizedBox(height: 16.h),
                                // Center(
                                //     child: DotsIndicator(
                                //         decorator: DotsDecorator(
                                //             spacing: EdgeInsets.all(4.w),
                                //             activeColor: AppColorBody.blue),
                                //         dotsCount: item.length,
                                //         position: currentPageBuild)),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        height: 40.h,
                                        width: 170.w,
                                        child: buildText(
                                            color: AppColorText.black,
                                            fontSize: 18.w,
                                            text: controller
                                                .singleProductList[0]
                                                .data!
                                                .productDetails!
                                                .product
                                                .toString(),
                                            fontWeight: FontWeight.w400)),
                                    buildText(
                                        color: AppColorText.black,
                                        fontSize: 14.w,
                                        text:
                                            "\u{20B9} ${controller.prices.value.toString().isNotEmpty ? double.parse(controller.prices.value.toString()).toStringAsFixed(2) : price}",
                                        fontWeight: FontWeight.w400),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    buildText(
                                        color: AppColorText.grey,
                                        fontSize: 16.w,
                                        text:
                                            "${body.quantity} ${body.unitType}",
                                        fontWeight: FontWeight.w400),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        controller.singleProductList[0].data!
                                                    .productDetails!.status ==
                                                1
                                            ? const SizedBox()
                                            : controller.decrement();

                                        controller.increement(
                                            rsProduct:
                                                double.parse(price.toString()));
                                        controller.changeData.value = true;
                                      },
                                      child: Container(
                                        width: 25.w,
                                        height: 25.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                          color: const Color(0x6545C8DC),
                                        ),
                                        child: Center(
                                            child: Icon(
                                          Icons.remove,
                                          color: AppColorBody.blue,
                                        )),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    buildText(
                                        color: AppColorText.grey,
                                        fontSize: 16.w,
                                        text: controller.singleProductList[0]
                                            .data!.productDetails!.status
                                            .toString(),
                                        fontWeight: FontWeight.w400),
                                    SizedBox(width: 10.w),
                                    InkWell(
                                      onTap: () {
                                        controller.update_fn();

                                        controller.increement(
                                            rsProduct:
                                                double.parse(price.toString()));
                                      },
                                      child: Container(
                                        width: 25.w,
                                        height: 25.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                          color: const Color(0x6545C8DC),
                                        ),
                                        child: Center(
                                            child: Icon(
                                          Icons.add,
                                          color: AppColorBody.blue,
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                buildText(
                                    color: AppColorText.black,
                                    fontSize: 20.w,
                                    text: "Description",
                                    fontWeight: FontWeight.w400),
                                SizedBox(height: 15.h),
                                buildText(
                                    color: AppColorText.black,
                                    fontSize: 14.w,
                                    text: controller.singleProductList[0].data!
                                        .productDetails!.description,
                                    fontWeight: FontWeight.w400),
                                SizedBox(height: 20.h),
                                buildText(
                                    color: AppColorText.black,
                                    fontSize: 16.w,
                                    text: "Related Products",
                                    fontWeight: FontWeight.w400),
                                SizedBox(height: 20.h),
                                SizedBox(
                                    height: 200.h,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller
                                            .singleProductList[0]
                                            .data!
                                            .products!
                                            .length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          var items = controller
                                              .singleProductList[0]
                                              .data!
                                              .products![index];
                                          var discount =
                                              "${double.parse(items.price.toString()) - double.parse(items.discount.toString())}";

                                          return InkWell(
                                              onTap: () {
                                                controller.changeData.value =
                                                    true;

                                                buildPush(
                                                    context: context,
                                                    widget: Product_Summary(
                                                        values: true,
                                                        id: controller
                                                            .singleProductList[
                                                                0]
                                                            .data!
                                                            .products![index]
                                                            .id
                                                            .toString()));
                                              },
                                              child: buildImage(
                                                  network:
                                                      items.image.toString(),
                                                  text:
                                                      items.product.toString(),
                                                  textRs: discount,
                                                  canRs:
                                                      items.price.toString()));
                                        })),
                                SizedBox(height: 10.h),
                                InkWell(
                                    onTap: () async {
                                      controller.changeData.value = true;

                                      controller.addToCart(data: {
                                        'product_id': body.id.toString(),
                                        'product_name': body.product.toString(),
                                        'product_amount': controller
                                                .prices.value
                                                .toString()
                                                .isNotEmpty
                                            ? controller.prices.value
                                            : price,
                                        'product_quantity': controller
                                            .singleProductList[0]
                                            .data!
                                            .productDetails!
                                            .status!
                                            .toString()
                                      });

                                      controller.changeData.value = false;
                                    },
                                    child: controller.changeData.value
                                        ? buildContainerB(
                                            value: controller.loader.value,
                                            text: "Add to Cart")
                                        : InkWell(
                                            onTap: () {
                                              buildPush(
                                                  context: context,
                                                  widget: Bottombar());
                                              final ctr =
                                                  Get.put(BottomeController());
                                              ctr.navigate.value = 2;

                                              controller.changeData.value =
                                                  true;

                                              controller.changeData.value =
                                                  false;
                                            },
                                            child: buildContainerB(
                                                value: controller.loader.value,
                                                text: "Go to Cart"))),
                                SizedBox(height: 20.h)
                              ])),
                    ],
                  ),
                ));
              })
          : allData[navigate],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          selectedItemColor: AppColorBody.blue,
          unselectedItemColor: AppColorBody.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(
              color: AppColorBody.blue,
              fontSize: 12.w,
              fontWeight: FontWeight.w400),
          onTap: (value) {
            setState(() {
              widget.values = false;
              navigate = value;
              controller.changeData.value = true;
            });
          },
          currentIndex: navigate,
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(const AssetImage('assets/home/home.png'),
                    size: 20.w),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: ImageIcon(const AssetImage('assets/home/Categories.png'),
                    size: 20.w),
                label: 'Categories'),
            BottomNavigationBarItem(
                icon: ImageIcon(const AssetImage('assets/home/Cart.png'),
                    size: 20.w),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: ImageIcon(const AssetImage('assets/home/profile.png'),
                    size: 20.w),
                label: 'Profile'),
          ]),
    );
  }

  List allData = [
    Home(),
    const CategoriesPage(),
    const CartPage(backbutton: false),
    const UserProfilePage(backbutton: false),
  ];
  int navigate = 0;
}
