// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:project/all_imports.dart';
import 'package:project/commons/widgetsPages/future_data.dart';
import 'package:project/features/home/homeRepoPage.dart';

import '../../../model/category_model.dart';
import 'sub_categories.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  TextEditingController searchController = TextEditingController();
  final controller = Get.put(HomeController());
  @override
  void initState() {
    controller.categories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // toolbarHeight: 100.h,
        title: buildText(
            color: AppColorText.blue,
            text: "Categories",
            fontWeight: FontWeight.w500,
            fontSize: 25.w),
        centerTitle: true,
      ),
      body: FutureData(
        fn: controller.categories(),
        data: (data) {
          Categrory categrorys = Categrory.fromJson(data);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(children: [
              Expanded(
                child: LayoutBuilder(builder: (context, constraint) {
                  return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: constraint.maxWidth > 500 ? 5 : 3,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 20.h,
                          mainAxisExtent: 140.h),
                      itemCount: categrorys.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            buildPush(
                                context: context,
                                widget: SubCategoriesPage(
                                    id: categrorys.data![index].id.toString()));
                          },
                          child: Container(
                            height: 130.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColorBody.grey),
                                borderRadius: BorderRadius.circular(4.r)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10.w,
                                  bottom: 10.w,
                                  top: 15.w,
                                  right: 10.w),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Center(
                                        child: CircleAvatar(
                                      radius: 30.r,
                                      backgroundImage: NetworkImage(categrorys
                                          .data![index].image
                                          .toString()),
                                      backgroundColor: const Color(0xFFC3F7FF),
                                    )),
                                    buildText(
                                        color: AppColorText.black,
                                        text: categrorys.data![index].name,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.w),
                                  ]),
                            ),
                          ),
                        );
                      });
                }),
              ),
            ]),
          );
        },
      ),
    );
  }
}
