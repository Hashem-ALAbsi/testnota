import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  // final InternetConnectionChecker _internetConnectionChecker =
  //     InternetConnectionChecker();
  // bool hasinternet = false;
  // late StreamSubscription internetsubscription;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionState);
    // _internetConnectionChecker.onStatusChange.listen((event) {
    //   final hasinternet = event == InternetConnectionStatus.connected;
    //   this.hasinternet = hasinternet;
    // });
  }

  void _updateConnectionState(
    ConnectivityResult connectivityResult,
  ) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
          messageText: const Text(
            "Please Connect To INTERNET",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red[400]!,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  // void _updateConnectionStatenet(
  //   InternetConnectionStatus hasinternet,
  // ) {
  //   final hasinternet = InternetConnectionStatus.connected;
  //   if (hasinternet == false) {
  //     Get.rawSnackbar(
  //         messageText: const Text(
  //           "Please Connect To INTERNET",
  //           style: TextStyle(color: Colors.white, fontSize: 14),
  //         ),
  //         isDismissible: false,
  //         duration: const Duration(days: 1),
  //         backgroundColor: Colors.red[400]!,
  //         icon: const Icon(
  //           Icons.wifi_off,
  //           color: Colors.white,
  //           size: 35,
  //         ),
  //         margin: EdgeInsets.zero,
  //         snackStyle: SnackStyle.GROUNDED);
  //   } else {
  //     if (Get.isSnackbarOpen) {
  //       Get.closeCurrentSnackbar();
  //     }
  //   }
  // }
}
