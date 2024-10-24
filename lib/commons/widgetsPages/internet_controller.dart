// import 'package:connectivity_plus/connectivity_plus.dart';

// import 'package:project/all_imports.dart';

// final internetCheckProvider = StateNotifierProvider((ref) {
//   return InternetNotifier();
// });

// class InternetNotifier extends StateNotifier {
//   String status;
//   Ref? ref;
//   InternetNotifier({this.status = "Waiting...", this.ref}) : super('');

//   Connectivity connectivity = Connectivity();

//   void checkConnection() {
//     ref!.onAddListener(
//       () {},
//     );

//     var checkInternet = connectivity.checkConnectivity();
//     // connectivity.onConnectivityChanged.listen(netstatus);
//     if (checkInternet == ConnectivityResult.mobile) {
//       status = "Mobile data";
//     } else if (checkInternet == ConnectivityResult.wifi) {
//       status = "wifi";
//     }
//   }

//   // netstatus(ConnectivityPlusLinuxPlugin cr) {
//   //   if (cr == ConnectivityResult.none) {
//   //     messageField("No Internet");
//   //   }
//   // }
// }
