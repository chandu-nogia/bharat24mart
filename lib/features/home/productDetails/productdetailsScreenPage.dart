// ignore_for_file: file_names

import 'package:intl/intl.dart';
import 'package:project/all_imports.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    getInitDate();

    super.initState();
  }

  var isShow = 1;
  var isUnit = 1;

  TextEditingController tasteController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController dateControler = TextEditingController();
  TextEditingController amountController = TextEditingController();

  void getInitDate() {
    final dateTime = DateTime.now();
    final initDate = DateFormat("yyyy-MM-dd").format(dateTime).toString();
    dateControler = TextEditingController(text: initDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.h,
          title: buildText(
              text: "Product Details",
              color: AppColorText.white,
              fontWeight: FontWeight.w500,
              fontSize: 22.h),
          centerTitle: true,
          backgroundColor: AppColorBody.blue,
          iconTheme: IconThemeData(color: AppColorBody.white),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 80.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: const DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        "https://cdn.cbeditz.com/cbeditz/preview/nature-studio-background-download-116067183938qcqseezua.png"))),
                          ),
                          SizedBox(width: 8.w),
                          SizedBox(
                            height: 80.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildText(
                                    color: AppColorText.black,
                                    fontSize: 16.w,
                                    text: "Masala Butter Milk 250 ml",
                                    fontWeight: FontWeight.w400),
                                buildText(
                                    color: AppColorText.grey,
                                    fontSize: 14.w,
                                    text: "( \u{20B9} 15/liter)",
                                    fontWeight: FontWeight.w400),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      buildTextField(
                        context,
                        color: AppColorBody.white,
                        colorBorder: AppColorBody.grey,
                        controllerData: tasteController,
                        keyboardType: TextInputType.phone,
                        hintText: "Taste Like Heaven",
                        hintColor: AppColorText.black,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      buildText(
                          text: "Select Delivery Date",
                          color: AppColorText.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.w),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 50.h,
                        width: 1.sw,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColorBody.grey),
                            color: AppColorBody.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: TextField(
                          style: TextStyle(
                              fontSize: 14.w,
                              color: AppColorText.black,
                              fontWeight: FontWeight.w400),
                          readOnly: true,
                          onTap: () async {
                            var date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025));
                            dateControler.text =
                                date.toString().substring(0, 10);
                          },
                          controller: dateControler,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8.w),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12)),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              prefixIcon: Icon(
                                Icons.calendar_month_outlined,
                                size: 20.h,
                                color: AppColorBody.grey,
                              ),
                              hintText: "yyyy/mm/dd"),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      buildText(
                          text: "Select Shift",
                          color: AppColorText.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.w),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isShow = 1;
                              });
                            },
                            child: buildBuildContainer(
                                data: isShow, no: 1, itemText: "Morning"),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isShow = 2;
                              });
                            },
                            child: buildBuildContainer(
                                data: isShow, no: 2, itemText: "Evening"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      buildText(
                          text: "Select Unit",
                          color: AppColorText.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.w),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isUnit = 1;
                              });
                            },
                            child: buildBuildContainer(
                                data: isUnit, no: 1, itemText: "ML"),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isUnit = 2;
                              });
                            },
                            child: buildBuildContainer(
                                data: isUnit, no: 2, itemText: "Liter"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      buildText(
                          text: "Quantity",
                          color: AppColorText.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.w),
                      SizedBox(height: 10.h),
                      buildTextField(context,
                          color: AppColorBody.white,
                          colorBorder: AppColorBody.grey,
                          controllerData: quantityController,
                          hintText: "500",
                          hintColor: AppColorText.black),
                      SizedBox(height: 27.h),
                      buildText(
                          text:
                              "*Note: If you place an order for a subscribed products, then your subscribed product quantity will be replaced by this quantity.",
                          color: AppColorText.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.w),
                      SizedBox(height: 30.h),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        buildText(
                            text: "Total Price :",
                            color: AppColorText.deepPurple,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.h),
                        buildText(
                            text: "7500/",
                            color: AppColorText.deepPurple,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.h)
                      ]),
                      SizedBox(height: 20.h),
                      InkWell(
                        onTap: () {},
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              loader = !loader;
                            });
                            buildPush(
                                context: context,
                                widget: const ProductDetails());
                          },
                          child:
                              buildContainerB(value: loader, text: "Continue"),
                        ),
                      ),
                      SizedBox(height: 20.h)
                    ]))));
  }

  bool loader = false;
}
