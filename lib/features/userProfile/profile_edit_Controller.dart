// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:image_picker/image_picker.dart';

import 'package:project/all_imports.dart';

import 'package:project/commons/routerPages/dio_api.dart';
import 'package:project/main.dart';

import 'userProfileControllerpage.dart';

final stateListProvider = StateProvider.autoDispose<List>((ref) => []);
final cityListProvider = StateProvider.autoDispose<List>((ref) => []);
final selectedStateProvider = StateProvider.autoDispose<String?>((ref) => null);
final selectedCityProvider = StateProvider.autoDispose<String?>((ref) => null);

final defaultValueProvider = StateProvider.autoDispose<String>((ref) => "");
final dropDownListDataProvider = StateProvider.autoDispose<List<Map>>((ref) => [
      {"title": "Male", "value": "1"},
      {"title": "Female", "value": "2"},
      {"title": "Trans", "value": "0"}
    ]);

final initdataProvider = StateProvider.autoDispose<InitData>((ref) {
  ref.keepAlive();
  final customFields = ref.watch(fielsProvider.notifier);

  return InitData(
    ref: ref,
    cusomfield: customFields,
  );
});

class InitData {
  Ref ref;

  TextFieldclass cusomfield;
  InitData({
    required this.ref,
    required this.cusomfield,
  });

  initData({data, context}) {
    ref.read(stateProvider);

    cusomfield.mobileController.text = data['data']['phone'].toString();
    cusomfield.nameController.text = data['data']['name'].toString().trim();
    ref.read(defaultValueProvider.notifier).state =
        data['data']['gender'].toString().trim();
    cusomfield.emailController.text = data['data']['email'].toString().trim();
    Future.delayed(
      const Duration(milliseconds: 0),
      () {
        if (data['data']['address'].toString().isEmpty) {
          return "";
        } else {
          ref.read(cityProvider.call(CityDatas(
              context: context,
              id: int.parse(data['data']['address']['state_id'].toString())
                  .toString()
                  .trim())));
          ref.read(selectedStateProvider.notifier).state =
              int.parse(data['data']['address']['state_id'].toString())
                  .toString()
                  .trim();

          ref.read(selectedCityProvider.notifier).state =
              int.parse(data['data']['address']['city_id'].toString())
                  .toString()
                  .trim();

          cusomfield.houseController.text =
              data['data']['address']['address'].toString().trim();
          cusomfield.pinController.text =
              data['data']['address']['pincode'].toString().trim();

          // ref.refresh(profileEditProvider.notifier).cityData(
          //     context: context, id: (data['data']['address']['city_id'].toString()));
        }
      },
    );
  }
}

final fielsProvider = ChangeNotifierProvider.autoDispose((ref) {
  return TextFieldclass(ref: ref);
});

class TextFieldclass extends ChangeNotifier {
  Ref? ref;
  TextFieldclass({required this.ref});
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  notifyListeners();
  cleans() {
    ref!.onDispose(() {
      mobileController.dispose();
      nameController.dispose();
      genderController.dispose();
      emailController.dispose();
      houseController.dispose();
    });
  }
}

final customTextFieldController = StateNotifierProvider.autoDispose((ref) {
  // ref.keepAlive();
  final defaultvalue = ref.watch(defaultValueProvider);
  final states = ref.watch(selectedStateProvider);
  final city = ref.watch(selectedStateProvider);
  final customFields = ref.watch(fielsProvider.notifier);
  // print("::::::::PPPPPP$states");
  return CustomTextFieldController(
      ref: ref,
      states: states,
      citys: city,
      fields: customFields,
      defaultValue: defaultvalue);
});

class CustomTextFieldController extends StateNotifier {
  final Ref ref;
  String? states;
  String? citys;
  TextFieldclass fields;
  String? defaultValue;
  CustomTextFieldController(
      {required this.ref,
      required this.defaultValue,
      required this.states,
      required this.citys,
      required this.fields})
      : super('');

  bool loader = false;
  String? sends;
  File? sendFile;
  String filename = "";

  final picker = ImagePicker();
  XFile? pickedFile;

  uploadImage() async {
    Future.delayed(
      const Duration(milliseconds: 0),
      () async {
        try {
          pickedFile = await picker.pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            sendFile = File(pickedFile!.path);
            sends = sendFile!.path.split("/").last;
            print("fffddd${pickedFile}");

            log(sends.toString());
            return sendFile;
          } else {
            return '';
          }
        } catch (error) {
          return error.toString();
        }
      },
    );
  }

  editProfile() async {
    // var city = ref.watch(stateCityProvider);
    loader = true;

    FormData fromData = FormData.fromMap({
      'image': pickedFile != null
          ? await MultipartFile.fromFile(pickedFile!.path, filename: sends)
          : "",
      'name': fields.nameController.text.trim(),
      'phone': fields.mobileController.text.trim(),
      'gender': defaultValue!.trim(),
      'email': fields.emailController.text.trim(),
      'state_id': ref.read(selectedStateProvider.notifier).state,
      'city_id': ref.read(selectedCityProvider.notifier).state,
      'address': fields.houseController.text.trim(),
      'pincode': fields.pinController.text.trim(),
    });
    profileonDispose() {
      fields.mobileController.clear();
      fields.nameController.clear();
      fields.emailController.clear();
      defaultValue = '';
      ref.read(selectedStateProvider.notifier).state = null;
      ref.invalidate(selectedCityProvider);
      fields.houseController.clear();
      fields.pinController.clear();
    }
    var response =
        await ApiMethod().putDioRequest(ApiUser.editProfile, data: fromData);

    if (response['success'] == true) {
      messageField(msg: response["message"].toString());
      ref.refresh(profilegetProvider.future).asStream();
      navigatorKey.currentState!.pop();
      // Navigator.pop(context);

      profileonDispose();
      loader = false;
      messageField(msg: response["message"].toString());
      return response;
    } else {
      loader = false;
      messageField(msg: response["msg"]);
      return "Error: Some technical issue";
    }
  }
}

final stateProvider = FutureProvider.autoDispose((ref) async {
  return stateData(ref: ref);
});
stateData({Ref? ref}) async {
  var response = await ApiMethod().postDioRequest(ApiUser.states);

  if (response['success'] == true) {
    var data = response['data'];
    ref!.notifyListeners();

    ref.read(stateListProvider.notifier).state = await data;

    return response;
  } else {
    return "Error: Some technical issue";
  }
}

class CityDatas {
  String? id;
  BuildContext? context;
  CityDatas({this.id, this.context});
}

final cityProvider =
    FutureProvider.autoDispose.family<Future, CityDatas>((ref, arg) async {
  final context = arg.context;
  final id = arg.id;

  return cityData(context: context, id: id, ref: ref);
});

cityData({String? id, required context, required Ref ref}) async {
  Map datas = {"state_id": id};
  var response = await ApiMethod()
      .putDioRequest("${ApiUser.city}?state_id=$id", data: datas);

  if (response['success'] == true) {
    var data = response['data'];
    log(id!);

    ref.read(cityListProvider.notifier).state = data;

    datas.clear();

    return response;
  } else {
    return "Error: Some technical issue";
  }
}
// }

Widget customTextField(context,
    {controllerData,
    color,
    colorBorder,
    String? Function(String?)? validation,
    keyboardType,
    obscureText,
    hintText,
    suffixIcon,
    padding,
    readOnly,
    maxLines,
    hintColor,
    String? name,
    Function(String)? onChanged,
    prifix,
    prifixIcon,
    maxLength}) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 5.r, bottom: 5.h),
            child: buildText(
                color: AppColorText.black,
                text: name,
                fontWeight: FontWeight.w400,
                fontSize: 14.w)),
        Padding(
          padding: EdgeInsets.only(bottom: padding ?? 15.h),
          child: TextFormField(
            readOnly: readOnly ?? false,
            validator: validation,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            maxLines: maxLines ?? 1,
            maxLength: maxLength ?? 30,
            style: TextStyle(
                color: AppColorText.black,
                fontFamily: "Roboto",
                fontWeight: FontWeight.normal),
            keyboardType: keyboardType ?? TextInputType.multiline,
            textInputAction: TextInputAction.next,
            controller: controllerData,
            enabled: true,
            obscureText: obscureText ?? false,
            onChanged: onChanged,
            decoration: InputDecoration(
                errorMaxLines: 2,
                isDense: true,
                contentPadding: EdgeInsets.all(10.w),
                counterText: "",
                prefix: prifix,
                prefixIcon: prifixIcon,
                suffixIcon: suffixIcon,
                // suffixIcon: suffixIcon ?? const SizedBox(),
                hintStyle: TextStyle(
                    color: hintColor ?? AppColorText.white,
                    fontFamily: "Roboto"),
                hintText: hintText,
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColorBody.red),
                    borderRadius: BorderRadius.circular(12.0.r)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColorBody.blue),
                    borderRadius: BorderRadius.circular(12.0.r)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColorBody.blue, width: 1.8.r),
                    borderRadius: BorderRadius.circular(12.0.r)),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12.r)),
                fillColor: color ?? AppColorBody.blue,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12.r))),
          ),
        ),
      ],
    ),
  );
}
