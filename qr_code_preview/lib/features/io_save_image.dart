import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:permission_handler/permission_handler.dart';

extension PrettyQrImageExtension on QrImage {
  Future<String?> exportAsImage(
      BuildContext context, {
        required int size,
        required PrettyQrDecoration decoration,
      }) async {
    final configuration = createLocalImageConfiguration(context);

    // Request storage permission on Android if not granted
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        return null;
      }
    }

    // Get the directory path for Downloads on Android or Documents on iOS
    final docDirectory = Platform.isIOS
        ? await getApplicationDocumentsDirectory()
        : Directory('/storage/emulated/0/Download');

    if (docDirectory == null) return null;

    // Get QR image bytes
    final bytes = await toImageAsBytes(
      size: size,
      decoration: decoration,
      configuration: configuration,
    );

    String baseFileName = 'sample Qr Code';
    String fileName = '$baseFileName.jpg';
    var file = File("${docDirectory.path}/$fileName");
    int fileNumber = 1;
    while (await file.exists()) {
      fileName = '$baseFileName ($fileNumber).jpg';
      file = File('${docDirectory.path}/$fileName');
      fileNumber++;
    }

    await file.writeAsBytes(bytes!.buffer.asUint8List());
    return file.path;
  }
}
