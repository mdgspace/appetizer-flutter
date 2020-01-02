import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';

Future showConnectivityStatus() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
    }
  } on SocketException catch (_) {
    print('not connected');
    Fluttertoast.showToast(
      msg: "Please check your connection!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 7,
      fontSize: 12.0,
    );
  }
}
