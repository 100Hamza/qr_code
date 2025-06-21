import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_code_preview/features/io_save_image.dart';
import 'package:qr_code_preview/widget/custom_button.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @protected
  late QrCode qrCode;

  @protected
  late QrImage qrImage;

  @protected
  late PrettyQrDecoration decoration;

  @override
  void initState() {
    super.initState();

    qrCode = QrCode.fromData(
      data: 'https://www.linkedin.com/in/muhammad-hamza-23b222211',
      errorCorrectLevel: QrErrorCorrectLevel.H,
    );

    qrImage = QrImage(qrCode);

    decoration = const PrettyQrDecoration(
      // TODO: if you want a dotted qr code then you should add PrettyQrRoundedSymbol instead of PrettyQrSmoothSymbol
      shape: PrettyQrSmoothSymbol(
          color: Colors.black,
          // TODO add radius to the corners using roundFactor but the value should be between 0 and 1
          roundFactor: 1),
      //  TODO: if you want to add an image/logo at the center of the QR code you add image if you don't want it you can simply remove the below line
      image: PrettyQrDecorationImage(
        image: const AssetImage('images/flutter.png'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pretty QR Code'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PrettyQrView(
                qrImage: qrImage,
                decoration: decoration,
              ),
            ),
            CustomButton(
              qrImage: qrImage,
              onExportPressed: (size) {
                return qrImage.exportAsImage(
                  context,
                  size: 512,
                  decoration: decoration,
                );
              },
              decoration: decoration,
            )
          ],
        ),
      ),
    );
  }
}
