import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

Future<String> scanQRcode() async {
  await Permission.camera.request();
  String barcode = await scanner.scan();
  if (barcode != null) {
    return barcode;
  }
  return null;
}
