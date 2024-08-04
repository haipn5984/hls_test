import 'dart:io';

Future<bool> checkNetworkNoToast() async {
  try {
    // FocusScope.of(context).unfocus();
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
  // var connectivityResult = await (Connectivity().checkConnectivity());
  // if (connectivityResult == ConnectivityResult.mobile) {
  //   return true;
  // } else if (connectivityResult == ConnectivityResult.wifi) {
  //   return true;
  // }
  // return false;
}
