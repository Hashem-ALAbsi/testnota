import 'package:get/get.dart';
import 'package:testnota/controller/network_controller.dart';

class DependecyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
