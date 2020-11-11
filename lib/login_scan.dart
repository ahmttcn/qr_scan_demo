import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/model/scan_result.dart';
import 'package:flutter/material.dart';

class LoginScanPage extends StatefulWidget {
  @override
  _LoginScanPageState createState() => _LoginScanPageState();
}

class _LoginScanPageState extends State<LoginScanPage> {
  String qrCodeResult;

  bool backCamera = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scan using:" + (backCamera ? "Front Camera" : "Back Camera"),
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          IconButton(
            icon: backCamera ? Icon(Icons.camera_alt) : Icon(Icons.camera),
            onPressed: () {
              setState(() {
                backCamera = !backCamera;
                camera = backCamera ? 1 : -1;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () async {
              ScanResult codeSanner = await BarcodeScanner.scan(
                options: ScanOptions(
                  useCamera: -1,
                ),
              ); //barcode scnner
              setState(() {
                qrCodeResult = codeSanner.rawContent;
                Navigator.pop(context, qrCodeResult.toString());
              });
            },
          )
        ],
      ),
      body: Center(
        child: Text(
          (qrCodeResult == null) || (qrCodeResult == "")
              ? "Please Scan to show some result"
              : "Result:" + qrCodeResult,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

int camera = 1;
