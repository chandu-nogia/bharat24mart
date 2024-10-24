// ignore_for_file: must_be_immutable, file_names

import 'package:get/get.dart';
import 'package:project/all_imports.dart';
import 'package:project/features/home/seeAllProductsummary/CategoriesPage.dart';
import 'package:project/features/userProfile/userProfileScreenPage.dart';

// final navigateProvider = StateProvider<int>((ref) {
//   return 0;
// });
class BottomeController extends GetxController {
  RxInt navigate = 0.obs;
  List allData = [
    Home(),
    const CategoriesPage(),
    const CartPage(backbutton: false),
    const UserProfilePage(backbutton: false),
  ];
}

class Bottombar extends StatelessWidget {
  Bottombar({super.key});

  final controller = Get.put(BottomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          body: controller.allData[controller.navigate.value],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              enableFeedback: true,
              selectedItemColor: AppColorBody.blue,
              unselectedItemColor: AppColorBody.grey,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: TextStyle(
                  color: AppColorBody.blue,
                  fontSize: 12.w,
                  fontWeight: FontWeight.w400),
              onTap: (value) {
                controller.navigate.value = value;
                // setState(() {});
              },
              currentIndex: controller.navigate.value,
              items: [
                BottomNavigationBarItem(
                    icon: ImageIcon(const AssetImage('assets/home/home.png'),
                        size: 20.w),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                        const AssetImage('assets/home/Categories.png'),
                        size: 20.w),
                    label: 'Categories'),
                BottomNavigationBarItem(
                    icon: ImageIcon(const AssetImage('assets/home/Cart.png'),
                        size: 20.w),
                    label: 'Cart'),
                BottomNavigationBarItem(
                    icon: ImageIcon(const AssetImage('assets/home/profile.png'),
                        size: 20.w),
                    label: 'Profile')
              ])),
    );
  }
}
