import 'dart:developer';

import 'package:get/get.dart';
import 'package:project/all_imports.dart';
import 'package:project/commons/widgetsPages/appBarPage.dart';
import 'package:project/commons/widgetsPages/future_data.dart';

import '../../userProfile/profile_edit_Controller.dart';
import '../homeRepoPage.dart';
import '../seeAllProductsummary/sub_categories.dart';
import 'prodSummaryRepoPage.dart';

final searchListProvider = StateProvider((ref) {
  return '';
});

class HomeSearchPage extends ConsumerStatefulWidget {
  const HomeSearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends ConsumerState<HomeSearchPage> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    searchList.clear();
    super.dispose();
  }

  List searchList = [];
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    // final categoriesBuild = ref.watch(homeApiProvider);
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
          fn: controller.getProduct(),
          data: (data) {
            List productlist = data['data']['category'];

            filterItems(String query) {
              if (query.isEmpty) {
                setState(() {
                  searchList.clear();
                });
              } else {
                setState(() {
                  searchList = productlist
                      .expand((i) => i['products'])
                      .where((item) => item['product']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                });
              }
            }

            return Container(
                child: Column(children: [
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

                    ref.read(searchListProvider.notifier).state = value;
                    log("Item List ${searchList}");
                  });
                }),
              ),
              SizedBox(height: 20.h),
              searchList.isNotEmpty
                  ? Expanded(
                      child: LayoutBuilder(builder: (context, constraint) {
                      return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      constraint.maxWidth > 500 ? 5 : 2,
                                  mainAxisExtent: 200.h),
                          itemCount: searchList.length,
                          itemBuilder: (BuildContext context, int index) {
                            // dynamic datas = pro[0]['data']['category'][index];
                            return InkWell(
                                onTap: () {
                                  buildPush(
                                      context: context,
                                      widget: Product_Summary(
                                          values: true,
                                          id:  searchList[index]
                                                  ['id']
                                              .toString()));
                                },
                                child:
                                    ListOfProducts(datas: searchList[index]));
                          });
                    }))
                  : const Center(child: Text("No Items"))
            ]));
          },
        ));
  }
}
