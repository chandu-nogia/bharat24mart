// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/all_imports.dart';
import 'package:project/commons/widgetsPages/future_data.dart';

import '../../userProfile/profile_edit_Controller.dart';
import '../homeRepoPage.dart';
import '../product_Summary/prodSummaryRepoPage.dart';

class SubCategoriesPage extends ConsumerStatefulWidget {
  final dynamic id;
  const SubCategoriesPage({super.key, this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SubCategoriesPageState();
}

class _SubCategoriesPageState extends ConsumerState<SubCategoriesPage> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _categary.clear();
    super.dispose();
  }

  List _categary = [];
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    // final categoriesBuild = ref.watch(categroryProvider);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          // toolbarHeight: 100.h,
          title: buildText(
              color: AppColorText.blue,
              text: "Search Items",
              fontWeight: FontWeight.w500,
              fontSize: 25.w),
          centerTitle: true,
        ),
        body: FutureData(
          fn: controller.categroryProduct(id: widget.id),
          data: (data) {
            List productlist = data['category'][0]['products'];

            void filterItems(String query) {
              if (query.isNotEmpty) {
                _categary.clear();
                _categary = productlist
                    .where((item) => item['product']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                    .toList();
              }
            }

            return Container(
                child: data['category'][0]['products'].length > 0
                    ? Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: customTextField(context,
                              // name: "Search",
                              controllerData: searchController,
                              color: AppColorBody.white,
                              colorBorder: AppColorBody.grey,
                              hintText: "Search...",
                              hintColor: AppColorBody.grey, onChanged: (value) {
                            setState(() {
                              filterItems(value);
                              controller.search.value = value;
                            });
                          }),
                        ),
                        SizedBox(height: 20.h),
                        searchController.text.isNotEmpty && _categary.isEmpty
                            ? const Center(child: Text("No Items"))
                            : Expanded(child:
                                LayoutBuilder(builder: (context, constraint) {
                                return GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                constraint.maxWidth > 500
                                                    ? 5
                                                    : 2,
                                            // crossAxisSpacing: 10.w,
                                            // mainAxisSpacing: 20.h,
                                            mainAxisExtent: 200.h),
                                    itemCount: _categary.isNotEmpty
                                        ? _categary.length
                                        : data['category'][0]['products']
                                            .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var datas = _categary.isNotEmpty
                                          ? _categary[index]
                                          : data['category'][0]['products']
                                              [index];
                                      return InkWell(
                                          onTap: () {
                                            buildPush(
                                                context: context,
                                                widget: Product_Summary(
                                                    values: true,
                                                    id: 
                                                        datas['id']
                                                            .toString()));
                                          },
                                          child: ListOfProducts(datas: datas));
                                    });
                              }))
                      ])
                    : const Center(child: Text("No Items")));
          },
        ));
  }
}

class ListOfProducts extends StatelessWidget {
  final dynamic datas;
  const ListOfProducts({super.key, this.datas});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColorBody.white,
          border: BorderDirectional(
              bottom: BorderSide(color: AppColorBody.grey),
              end: BorderSide(color: AppColorBody.grey))
          // borderRadius: BorderRadius.circular(5),
          // boxShadow: [
          //   BoxShadow(blurRadius: 1, spreadRadius: 0, color: AppColorBody.blue)
          // ]
          ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(children: [
          SizedBox(height: 8.h),
          ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Container(
                height: 110.h,
                width: 130.w,
                color: Colors.white,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: datas['image'].toString(),
                  placeholder: (context, url) => const SizedBox(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: buildText(
                  color: AppColorText.black,
                  text: datas['product'],
                  //  categrorys.data![index].name,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.w),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: buildText(
                  color: AppColorText.black,
                  text: "\u{20B9} ${datas['price']}",
                  //  categrorys.data![index].name,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.w),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: buildText(
                  color: CupertinoColors.activeGreen,
                  text: "Stock: ${datas['stock']}",
                  //  categrorys.data![index].name,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.w),
            ),
          ),
        ]),
      ),
    );
  }
}
