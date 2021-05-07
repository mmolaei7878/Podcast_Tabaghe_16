import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';

class ConnectionController extends GetxController {
  StreamSubscription<ConnectivityResult> subscription;

  var isConnected = true.obs;

  checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected(false);
    } else if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isConnected(true);
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected(false);
      } else if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        isConnected(true);
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }
}
