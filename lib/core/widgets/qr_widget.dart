import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrWidget {
  _showQr(String data) {
    return SizedBox(
      width: 350,
      height: 250,
      child: BarcodeWidget(
        data: data,
        barcode: Barcode.qrCode(),
      ),
    );
  }

  // Future<String?> scan() async {
  //   try {
  //     String code = await FlutterBarcodeScanner.scanBarcode(
  //         "#2A99CF", "Cancel", true, ScanMode.QR);
  //     return code;
  //   } catch (e) {
  //     print("Error scanning barcode: $e");
  //     return null;
  //   }
  // }

  qrDialog(BuildContext context, String data) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: _showQr(data),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
                size: 30,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}
