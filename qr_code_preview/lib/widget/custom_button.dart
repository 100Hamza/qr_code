// import 'package:flutter/material.dart';
// import 'package:pretty_qr_code/pretty_qr_code.dart';
//
// class CustomButton extends StatefulWidget {
//   final QrImage qrImage;
//   @protected
//   final PrettyQrDecoration decoration;
//   @protected
//   final Future<String?> Function(int)? onExportPressed;
//   const CustomButton({super.key, required this.qrImage, required this.onExportPressed, required this.decoration});
//
//   @override
//   State<CustomButton> createState() => _CustomButtonState();
// }
//
// class _CustomButtonState extends State<CustomButton> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (){
// final path = widget.onExportPressed?.call(512);
//         debugPrint('path: $path');
//         if (!context.mounted) return;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(path == null ? 'Saved' : 'Saved to $path'),
//           ),
//         );
//       },
//       child: Container(
//         width: 150,
//         padding: const EdgeInsets.all(20),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue,),
//         child: const Text('Download'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class CustomButton extends StatefulWidget {
  final QrImage qrImage;
  final PrettyQrDecoration decoration;
  final Future<String?> Function(int)? onExportPressed;

  const CustomButton({
    super.key,
    required this.qrImage,
    required this.onExportPressed,
    required this.decoration,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final path = await widget.onExportPressed?.call(512);
        debugPrint('path: $path');

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(path == null ? 'Save failed' : 'Saved to $path'),
          ),
        );
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        child: const Text('Download', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
