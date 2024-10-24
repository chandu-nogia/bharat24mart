import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../all_imports.dart';
import '../../commons/routerPages/dio_api.dart';

class GetProfileController extends GetxController {
  final mobileController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final genderController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final houseController = TextEditingController().obs;
  final pinController = TextEditingController().obs;

  RxString? sends = ''.obs;
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
            sends!.value = sendFile!.path.split("/").last;
            print("file pic $pickedFile");

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
    // loader = true;

    FormData fromData = FormData({
      'image': pickedFile != null
          ? await MultipartFile(pickedFile!.path, filename: sends!.value)
          : "",
      'name': nameController.value.text.trim(),
      'phone': mobileController.value.text.trim(),
      // 'gender': defaultValue!.trim(),
      'email': emailController.value.text.trim(),
      // 'state_id': ref.read(selectedStateProvider.notifier).state,
      // 'city_id': ref.read(selectedCityProvider.notifier).state,
      'address': houseController.value.text.trim(),
      'pincode': pinController.value.text.trim(),
    });

    var response =
        await ApiMethod().putDioRequest(ApiUser.editProfile, data: fromData);

    if (response['success'] == true) {
      messageField(msg: response["message"].toString());
      // ref.refresh(profilegetProvider.future).asStream();
      // navigatorKey.currentState!.pop();
      // Navigator.pop(context);

      // profileonDispose();
      // loader = false;
      messageField(msg: response["message"].toString());
      return response;
    } else {
      // loader = false;
      messageField(msg: response["msg"]);
      return "Error: Some technical issue";
    }
  }
}
