// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:project/all_imports.dart';
import 'package:project/main.dart';
import 'package:project/model/get_address.dart';

import '../../../../commons/routerPages/dio_api.dart';
import '../../../userProfile/profile_edit_Controller.dart';

final typeValueProvider = StateProvider<String>((ref) => "");
final typeListProvider = StateProvider<List>((ref) {
  return [
    {"title": "HOME", "value": "HOME"},
    {"title": "OFFICE", "value": "OFFICE"},
    {"title": "OTHER", "value": "OTHER"}
  ];
});

final addAddressEditProvider = StateNotifierProvider.autoDispose((ref) {
  return ProfileEditNotifier(ref: ref);
});

class ProfileEditNotifier extends StateNotifier {
  Ref ref;

  ProfileEditNotifier({required this.ref}) : super('');

  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController houseController = TextEditingController();

  TextEditingController pinController = TextEditingController();

  bool loader = false;

  getapi({required Data data, context}) {
    // ref.read(stateProvider);
    ref.read(cityProvider.call(CityDatas(
        context: context, id: int.parse(data.stateId.toString()).toString())));
    ref.read(typeValueProvider.notifier).state = data.type.toString();
    ref.read(selectedStateProvider.notifier).state =
        int.parse(data.stateId.toString()).toString();
    ref.read(selectedCityProvider.notifier).state =
        int.parse(data.cityId.toString()).toString();

    houseController.text = data.address.toString();
    pinController.text = data.pincode.toString();
  }

  addAdress() async {
    Map data = {
      'type': ref.watch(typeValueProvider.notifier).state,
      'state_id': ref.read(selectedStateProvider.notifier).state,
      'city_id': ref.read(selectedCityProvider.notifier).state,
      'address': houseController.text.trim(),
      'pincode': pinController.text.trim(),
    };

    var response =
        await ApiMethod().putDioRequest(data: data, ApiUser.addAddress);

    if (response['success'] == true) {
      // ref.refresh(getAdressProvider.call(context));
      messageField(msg: response['message']);
      data.clear();
      ref.read(typeValueProvider.notifier).state = '';
      ref.refresh(getAdressProvider);
      navigatorKey.currentState!.pop();

      return response;
    } else {
      return messageField(msg: response["msg"]);
    }
  }

  editAdress({id}) async {
    Map data = {
      'address_id': id,
      'type': ref.watch(typeValueProvider.notifier).state,
      'state_id': ref.read(selectedStateProvider.notifier).state,
      'city_id': ref.read(selectedCityProvider.notifier).state,
      'address': houseController.text.trim(),
      'pincode': pinController.text.trim(),
    };

    var response =
        await ApiMethod().putDioRequest(data: data, ApiUser.editAdress);

    if (response['success'] == true) {
      messageField(msg: response['message']);
      ref.refresh(getAdressProvider);
      // Navigator.pop(context);
      navigatorKey.currentState!.pop();

      return response;
    } else {
      return messageField(msg: response["msg"]);
    }
  }

  deleteAddress({id}) async {
    Map data = {"address_id": id};

    dynamic response =
        await ApiMethod().putDioRequest(data: data, ApiUser.deleteAdress);
    ref.refresh(getAdressProvider);

    if (response['success'] == true) {
      messageField(msg: response['message'], snacColor: AppColorBody.red);
      // ref.refresh(getAdressProvider(context));

      return response;
    } else {
      return messageField(msg: response["message"]);
    }
  }
}
