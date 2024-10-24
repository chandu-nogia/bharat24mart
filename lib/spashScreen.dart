// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:project/all_imports.dart';

import 'commons/widgetsPages/flutter_secure_token.dart';

class SpashScreen extends ConsumerStatefulWidget {
  const SpashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SpashScreenState();
}

class _SpashScreenState extends ConsumerState<SpashScreen> {
  void getLoginData() async {
    final tokenCtr = Get.put(MyStorage());
    final token1 = await tokenCtr.readData('token');
    Future.delayed(const Duration(seconds: 3), () {
      if (token1 != null && token1.isNotEmpty) {
        Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Bottombar()))
            .then((value) {
          final ctr = Get.put(BottomeController());
          ctr.navigate.value = 0;
        });
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getLoginData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
          height: 296.h,
          width: 309.w,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/splace.png'),
                  fit: BoxFit.cover))),
    ));
  }
}
