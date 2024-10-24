// ignore_for_file: avoid_print, unnecessary_new

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/all_imports.dart';
import 'package:project/model/get_address.dart';

// import 'package:project/features/userProfile/profile_edit_Controller.dart';

import '../../../userProfile/profile_edit_Controller.dart';
import 'add_address_provider.dart';

class AddAdress extends ConsumerStatefulWidget {
  final dynamic data;
  final bool page;
  const AddAdress({this.data, super.key, required this.page});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddAdressState();
}

class _AddAdressState extends ConsumerState<AddAdress> {
  @override
  void initState() {
    ref.read(stateProvider);
    Future.delayed(
      const Duration(milliseconds: 0),
      () {
        widget.page == true
            ? ref
                .read(addAddressEditProvider.notifier)
                .getapi(data: widget.data)
            : null;
      },
    );

    // ref.read(addAddressEditProvider.notifier).stateData(context: context);

    super.initState();
  }

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final profileData = ref.watch(addAddressEditProvider.notifier);

    final selectedState = ref.watch(selectedStateProvider);
    var selectedCity = ref.watch(selectedCityProvider);
    final stateList = ref.watch(stateListProvider);
    final cityList = ref.watch(cityListProvider);
    final type = ref.watch(typeValueProvider);
    final typesList = ref.watch(typeListProvider);
    var width = MediaQuery.of(context).size.width;
    // ref.refresh(getAdressProvider.call(context));
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100.h,
          title: buildText(
              color: AppColorText.blue,
              text: widget.page == true ? "Edit Address" : "Add New Address",
              fontWeight: FontWeight.w500,
              fontSize: 25.w),
          centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(30.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: SizedBox(
              width: width / 1.3,
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(height: 11.h),
                    Padding(
                        padding: EdgeInsets.only(bottom: 5.h),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: buildText(
                              color: AppColorText.black,
                              text: "Type",
                              fontWeight: FontWeight.w400,
                              fontSize: 14.w),
                        )),
                    DropdownButtonFormField<String>(
                      isDense: true,
                      itemHeight: 48.h,
                      // itemHeight: 45,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.w),
                          isDense: true,
                          // contentPadding: EdgeInsets.only(right: 0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColorBody.blue),
                              borderRadius: BorderRadius.circular(12.r)),
                          filled: true,
                          focusColor: AppColorBody.white,
                          // enabled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColorBody.grey),
                              borderRadius: BorderRadius.circular(12.r)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColorBody.red),
                              borderRadius: BorderRadius.circular(12.r)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColorBody.grey),
                              borderRadius: BorderRadius.circular(12.r)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColorBody.grey),
                              borderRadius: BorderRadius.circular(12.r)),
                          fillColor: AppColorBody.white),
                      isExpanded: true,
                      value: type,
                      items: [
                        const DropdownMenuItem(
                          value: "",
                          child: Text("Select Types"),
                        ),
                        ...typesList.map<DropdownMenuItem<String>>((datas) {
                          return DropdownMenuItem(
                            value: datas['value'],
                            child: Text(datas['title']),
                          );
                        }),
                      ],
                      onChanged: (newValue) {
                        // setState(() {
                        ref.read(typeValueProvider.notifier).state = newValue!;

                        print(" ::::: $newValue");
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'field required';
                        } else if (value == "") {
                          return "Please select Type";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: width / 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(bottom: 5.h),
                                  child: buildText(
                                      color: AppColorText.black,
                                      text: "State",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.w)),
                              Container(
                                width: width / 2.8,
                                // height: 45.h,

                                child: DropdownButtonFormField<String>(
                                  isDense: true,
                                  itemHeight: 48.h,
                                  // itemHeight: 45,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.w),
                                      isDense: true,
                                      // contentPadding: EdgeInsets.only(right: 0),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColorBody.blue),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      filled: true,
                                      focusColor: AppColorBody.white,
                                      // enabled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColorBody.grey),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColorBody.red),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColorBody.grey),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColorBody.grey),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      fillColor: AppColorBody.white),
                                  autofocus: true,
                                  isExpanded: true,
                                  value: selectedState,
                                  hint: const Text("Select State"),
                                  items:
                                      // const DropdownMenuItem(
                                      //     value: "", child: Text("Select State")),
                                      stateList.map<DropdownMenuItem<String>>(
                                          (datas) {
                                    return new DropdownMenuItem(
                                      value: datas['id'].toString(),
                                      child: Text(datas['name'].toString()),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    ref
                                        .read(selectedStateProvider.notifier)
                                        .state = newValue;
                                    ref
                                        .read(cityListProvider.notifier)
                                        .state
                                        .clear();

                                    ref
                                        .read(selectedCityProvider.notifier)
                                        .state = null;
                                    ref.read(cityProvider.call(CityDatas(
                                        context: context, id: newValue)));
                                    print("::::::;;:::$newValue");
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select state';
                                    } else if (value == "") {
                                      return "Please select state";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          // const Spacer(),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 5.h, left: 8.w),
                                  child: buildText(
                                      color: AppColorText.black,
                                      text: "City",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.w)),
                              Container(
                                width: width / 2.8,
                                child: DropdownButtonFormField<String>(
                                  isDense: true,
                                  itemHeight: 48.h,
                                  // itemHeight: 45,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.w),
                                      isDense: true,
                                      // contentPadding: EdgeInsets.only(right: 0),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColorBody.blue),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      filled: true,
                                      focusColor: AppColorBody.white,
                                      // enabled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColorBody.grey),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColorBody.red),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColorBody.grey),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColorBody.grey),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      fillColor: AppColorBody.white),
                                  isExpanded: true,
                                  value: selectedCity,
                                  hint: const Text("Select City"),
                                  items: selectedState != null
                                      ? cityList.map<DropdownMenuItem<String>>(
                                          (datas) {
                                          return new DropdownMenuItem(
                                            value: datas['id'].toString(),
                                            child:
                                                Text(datas['name'].toString()),
                                          );
                                        }).toList()
                                      : [],
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      ref
                                          .read(selectedCityProvider.notifier)
                                          .state = newValue;

                                      print("Please not city");
                                      print("defaoult  $selectedCity");
                                      // }
                                    } else {
                                      [];
                                    }

                                    print(" ::::: $newValue");
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select city';
                                    } else if (value == "") {
                                      return "Please select city";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    customTextField(context, validation: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your full Address";
                      } else {
                        return null;
                      }
                    },
                        name: "Full Address",
                        controllerData: profileData.houseController,
                        color: AppColorBody.white,
                        colorBorder: AppColorBody.grey,
                        hintText: "Loream",
                        hintColor: AppColorBody.grey),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 150.w,
                        child: customTextField(context, validation: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Pincode";
                          } else if (value.length < 6) {
                            return "Enter 6 digit Pincode";
                          } else {
                            return null;
                          }
                        },
                            name: "Pincode",
                            controllerData: profileData.pinController,
                            color: AppColorBody.white,
                            maxLength: 6,
                            colorBorder: AppColorBody.grey,
                            keyboardType: TextInputType.phone,
                            hintText: "302012",
                            hintColor: AppColorBody.grey),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    InkWell(
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          if (widget.page == true) {
                            Data dataList = widget.data;
                            ref
                                .read(addAddressEditProvider.notifier)
                                .editAdress(id: dataList.id);
                          } else {
                            ref
                                .read(addAddressEditProvider.notifier)
                                .addAdress();
                          }
                        }
                      },
                      child: buildContainerB(
                          value: profileData.loader, text: "Submit"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
