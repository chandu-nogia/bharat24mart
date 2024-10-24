// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project/all_imports.dart';
import 'package:project/features/carts/checkout/address_page/add_address_provider.dart';

import '../../../commons/widgetsPages/appBarPage.dart';

import '../../../model/get_address.dart';
import '../carts/checkout/address_page/add_address_page.dart';

class SavedAddress extends ConsumerStatefulWidget {
  const SavedAddress({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedAddressState();
}

class _SavedAddressState extends ConsumerState<SavedAddress> {
  @override
  Widget build(BuildContext context) {
    final isCheckout = ref.watch(checkoutProvider);
    // final isOnTap = ref.watch(onTapProvider);
    final getAdressBuild = ref.watch(getAdressProvider);

    return Container(
      color: Colors.white,
      child: getAdressBuild.when(
          loading: () => loaderCircular(),
          error: (error, stackTrace) => errorMethod(),
          data: (data) {
            GetAdress getAddress = GetAdress.fromJson(data);
            return Scaffold(
              appBar: AppBar(
                title: buildText(
                    color: AppColorText.blue,
                    fontSize: 25.w,
                    text: "Saved Address",
                    fontWeight: FontWeight.w500),
                centerTitle: true,
                iconTheme: IconThemeData(color: AppColorBody.grey),
              ),
              body: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h),
                    InkWell(
                      onTap: () {
                        buildPush(
                            context: context, widget: AddAdress(page: false));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildText(
                              color: AppColorText.black,
                              text: "Add new address",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.w),
                          // Container(
                          //   child:
                          //       Image.asset("assets/image/addicon.png"),
                          // )
                          Icon(
                            Icons.add_circle_outline_outlined,
                            color: AppColorBody.black,
                            weight: 20,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: getAddress.data!.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            direction: Axis.horizontal,
                            endActionPane: ActionPane(
                                extentRatio: 0.3.w,
                                motion: const ScrollMotion(),
                                children: [
                                  const SlidableAction(
                                      padding: EdgeInsets.zero,
                                      onPressed: null,
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.white,
                                      icon: Icons.share,
                                      label: ''),
                                  SlidableAction(
                                    flex: 4,
                                    padding: EdgeInsets.all(8.w),
                                    spacing: 5.2,
                                    autoClose: true,
                                    borderRadius: BorderRadius.circular(6.r),
                                    onPressed: (context) async {
                                      ref
                                          .read(addAddressEditProvider.notifier)
                                          .deleteAddress(
                                              id: getAddress.data![index].id
                                                  .toString());
                                    },
                                    backgroundColor: AppColorBody.blue,
                                    foregroundColor: Colors.white,
                                    icon: CupertinoIcons.delete_solid,
                                  ),
                                ]),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        height: 10.h,
                                        width: 10.w,
                                        child: Radio(
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            activeColor: AppColorBody.blue,
                                            value: index,
                                            groupValue: isCheckout,
                                            onChanged: (int? value) {
                                              ref
                                                  .read(
                                                      checkoutProvider.notifier)
                                                  .state = value!;
                                            })),
                                    SizedBox(width: 10.w),
                                    buildText(
                                        color: AppColorText.black,
                                        text: getAddress.data![index].type
                                            .toString(),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.w),
                                    const Spacer(),
                                    InkWell(
                                        onTap: () async {
                                          await buildPush(
                                              context: context,
                                              widget: AddAdress(
                                                data: getAddress.data![index],
                                                page: true,
                                              ));
                                        },
                                        child: Image.asset(
                                            color: Colors.black,
                                            "assets/image/editcheck.png")
                                        // const Icon(  editcheck.png
                                        //     Icons.edit_outlined)
                                        ),
                                  ],
                                ),
                                SizedBox(
                                    width: 310.w,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 15.w, left: 8.w),
                                      child: Text(
                                        textAlign: TextAlign.start,
                                        getAddress.data![index].completeAddress
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15.w),
                                      ),
                                    )),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          );
                        }),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              )),
            );
          }),
    );
  }

  bool check = false;

  Widget buildOnTapCheckout({data, no, text}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Row(
        children: [
          buildContainer(
              borderColor: AppColorBody.black,
              color: data == no ? AppColorBody.blue : AppColorBody.white,
              borderRadius: 2.r,
              height: 20.h,
              width: 20.w,
              widget: const SizedBox()),
          SizedBox(
            width: 13.w,
          ),
          buildText(
              color: AppColorText.black,
              text: text,
              fontWeight: FontWeight.w400,
              fontSize: 14.w),
        ],
      ),
    );
  }
}
