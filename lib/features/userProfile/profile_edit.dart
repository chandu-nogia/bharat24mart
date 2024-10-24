// ignore_for_file: unnecessary_new, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/commons/widgetsPages/ColorPage.dart';
import 'package:project/commons/widgetsPages/buttonPage.dart';
import 'package:project/commons/widgetsPages/textpage.dart';
import 'package:project/features/userProfile/profile_edit_Controller.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  final dynamic data;
  const EditProfilePage({this.data, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  @override
  void initState() {
    setState(() {
      // ref.read(stateProvider(context));
      Future.delayed(const Duration(milliseconds: 0), () {
        ref.read(initdataProvider).initData(data: widget.data);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedState = ref.watch(selectedStateProvider);
    var selectedCity = ref.watch(selectedCityProvider);
    final stateList = ref.watch(stateListProvider);
    final cityList = ref.watch(cityListProvider);
    final defaultValue = ref.watch(defaultValueProvider);
    final dropDownListData = ref.watch(dropDownListDataProvider);
    final editProfile = ref.watch(fielsProvider.notifier);
    final customs = ref.watch(customTextFieldController.notifier);
    setState(() {});
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100.h,
        title: buildText(
            color: AppColorText.black,
            text: "Edit Profile",
            fontWeight: FontWeight.w500,
            fontSize: 25.w),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Center(
          child: SizedBox(
            width: width / 1.3,
            child: Form(
              key: editProfile.formkey,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  customs.sendFile != null
                      ? CircleAvatar(
                          radius: 30.r,
                          backgroundImage: FileImage(customs.sendFile!),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                ref
                                    .read(customTextFieldController.notifier)
                                    .uploadImage();
                              });
                            },
                            child: Center(
                                child: ImageIcon(
                              const AssetImage("assets/image/Group.png"),
                              size: 20.w,
                              color: AppColorBody.white,
                            )),
                          ),
                        )
                      : CircleAvatar(
                          radius: 30.r,
                          backgroundImage: NetworkImage(
                              widget.data['data']['image'].toString()
                              // "https://products.mydairy.tech/images/profile/default.png"
                              ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                ref
                                    .read(customTextFieldController.notifier)
                                    .uploadImage();
                              });
                            },
                            child: Center(
                                child: ImageIcon(
                              const AssetImage("assets/image/Group.png"),
                              size: 20.w,
                              color: AppColorBody.white,
                            )),
                          ),
                        ),
                  SizedBox(height: 11.h),
                  customTextField(context, validation: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your Name";
                    } else {
                      return null;
                    }
                  },
                      name: "Name",
                      controllerData: editProfile.nameController,
                      color: AppColorBody.white,
                      colorBorder: AppColorBody.grey,
                      hintText: "Name",
                      hintColor: AppColorBody.grey),
                  customTextField(context, keyboardType: TextInputType.phone,
                      validation: (String? value) {
                    if (value!.isEmpty) {
                      return "Please enter your Numbers";
                    } else if (value.length < 10) {
                      return "Please enter 10 digit Number";
                    } else {
                      return null;
                    }
                  },
                      name: "Number",
                      controllerData: editProfile.mobileController,
                      color: AppColorBody.white,
                      maxLength: 10,
                      prifixIcon: Padding(
                          padding: EdgeInsets.all(12.5.r),
                          child: const Text("+91",
                              style: TextStyle(fontSize: 16))),
                      colorBorder: AppColorBody.grey,
                      hintText: "Phone Number",
                      hintColor: AppColorBody.grey),
                  Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: buildText(
                            color: AppColorText.black,
                            text: "Gender",
                            fontWeight: FontWeight.w400,
                            fontSize: 14.w),
                      )),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.h),
                          isDense: true,
                          // contentPadding: EdgeInsets.only(right: 0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColorBody.blue),
                              borderRadius: BorderRadius.circular(12.r)),
                          filled: true,
                          focusColor: AppColorBody.white,
                          enabled: true,
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
                      autofocus: true,
                      isExpanded: true,
                      value: defaultValue,
                      items: [
                        const DropdownMenuItem(
                          value: "",
                          child: Text("Select Gender"),
                        ),
                        ...dropDownListData
                            .map<DropdownMenuItem<String>>((datas) {
                          return DropdownMenuItem(
                            value: datas['value'],
                            child: Text(datas['title']),
                          );
                        }),
                      ],
                      validator: (value) {
                        if (value == null) {
                          return 'field required';
                        } else if (value == "") {
                          return "Please select gender";
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        ref.read(defaultValueProvider.notifier).state =
                            newValue!;
                        if (defaultValue == "") {
                          print("Please select gender");
                        } else {
                          print("defaoult  $defaultValue");
                        }

                        print(" ::::: $newValue");
                      }),
                  SizedBox(height: 10.h),
                  customTextField(context,
                      name: "Email",
                      controllerData: editProfile.emailController,
                      color: AppColorBody.white,
                      colorBorder: AppColorBody.grey,
                      hintText: "email",
                      hintColor: AppColorBody.grey),
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
                            SizedBox(
                              width: width / 2.8,
                              child: DropdownButtonFormField<String>(
                                isDense: true,
                                itemHeight: 48.h,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.w),
                                    isDense: true,
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
                                        borderSide:
                                            BorderSide(color: AppColorBody.red),
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
                                items: stateList
                                    .map<DropdownMenuItem<String>>((datas) {
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
                        SizedBox(width: 10.w),
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
                              // height: 45.h,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  itemHeight: 48.h,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
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

                                      print("defaoult  $selectedCity");
                                      // }
                                    } else {
                                      [];
                                    }

                                    print(" ::::: $newValue");
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select City';
                                    } else if (value == "") {
                                      return "Please select State";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  customTextField(
                    context,
                    name: "House No, Building Name",
                    controllerData: editProfile.houseController,
                    color: AppColorBody.white,
                    colorBorder: AppColorBody.grey,
                    hintText: "Loream",
                    hintColor: AppColorBody.grey,
                    validation: (value) {
                      if (value!.isEmpty) {
                        return "Please enter full address";
                      } else {
                        return null;
                      }
                    },
                  ),
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
                          controllerData: editProfile.pinController,
                          color: AppColorBody.white,
                          maxLength: 6,
                          colorBorder: AppColorBody.grey,
                          keyboardType: TextInputType.phone,
                          hintText: "302012",
                          hintColor: AppColorBody.grey),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  InkWell(
                    onTap: () {
                      if (editProfile.formkey.currentState!.validate()) {
                        ref
                            .read(customTextFieldController.notifier)
                            .editProfile();
                      }
                    },
                    child: buildContainerB(
                        value: customs.loader, text: "Save Address"),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
