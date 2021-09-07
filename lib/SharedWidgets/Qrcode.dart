/*import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';*/

import 'package:drycleaners/projectImports.dart';

///This function will return Qrcode to DetailsPage
QrImage qrImage(qrcode,size) {
  final qrImg = QrImage(
    data: qrcode,
    version: QrVersions.auto,
    size: size,
    gapless: true,
    backgroundColor: Colors.white,
  );
  return qrImg;
}
