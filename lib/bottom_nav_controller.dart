import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;
  var hasUnreadNotifications = false.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  void markNotificationAsRead() {
    hasUnreadNotifications.value = false;
  }

  void receiveNewNotification() {
    hasUnreadNotifications.value = true;
  }
}

