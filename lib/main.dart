import 'package:flutter/material.dart';
import 'package:myqr_demo/login_scan.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'QR Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Qr Variables
  var qrText = "...";
  var cameraState = "Front Camera";
  var result = "";
  QRViewController _qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Scanned Data is $qrText"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanQr,
        tooltip: 'Scan',
        child: Icon(Icons.qr_code_scanner),
      ),
    );
  }

  void _scanQr() async {
    result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScanPage()));
    setState(() {
      qrText = result;
    });
  }

  Widget qrView() {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.blue,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text("Scanned Code is $result"),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            child: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    ));
  }

  void _onQRViewCreated(QRViewController controller) {
    this._qrViewController = controller;
    _qrViewController.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }

  @override
  void dispose() {
    _qrViewController.dispose();
    super.dispose();
  }
}
