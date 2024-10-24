import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

// final storageProvider = Provider<MyStorage>((ref) => MyStorage());

class MyStorage extends GetxController {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  writeData({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  readData(String key) async {
    var data = await storage.read(key: key);
    // log(" read data $data");
    return data;
  }

  // readDataAll(String key) async {
  //   var data = await storage.readAll();
  //   // log(" read data $data");
  //   return data;
  // }

  deleteData(String key) async {
    await storage.delete(key: key);
  }

  deleteDataAll() async {
    await storage.deleteAll();
  }
}
