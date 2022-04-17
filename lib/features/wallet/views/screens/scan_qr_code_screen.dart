import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/navigator/app_router.dart';
import '../../../../cores/utils/sizer_utils.dart';

class ScanQRCodeScreen extends StatelessWidget {
  const ScanQRCodeScreen({Key? key}) : super(key: key);

  static final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  static QRViewController? qrController;

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;
    qrController!.scannedDataStream.listen((scanData) async {
      final Barcode result = scanData;
      qrController!.pauseCamera();
      AppRouter.instance.goBack(result.code);
    });
  }

  Future<void> toggleTouch() async {
    await qrController!.toggleFlash();
  }

  Future<void> flipCamera() async {
    await qrController!.flipCamera();
  }

  @override
  Widget build(BuildContext context) {
    final double scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return CustomScaffoldWidget(
      usePadding: false,
      useSingleScroll: false,
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea,
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(horizontal: sp(20), vertical: sp(10)),
            child: Row(
              children: <Widget>[
                QrCodeScannerToolWidget(
                  icon: Icons.arrow_back_ios_new,
                  callback: AppRouter.instance.goBack,
                ),
                const Spacer(),
                QrCodeScannerToolWidget(
                  icon: Icons.cameraswitch_rounded,
                  callback: () => flipCamera(),
                ),
                SizedBox(width: sp(10)),
                QrCodeScannerToolWidget(
                  icon: Icons.flash_on_outlined,
                  callback: () => toggleTouch(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QrCodeScannerToolWidget extends StatelessWidget {
  const QrCodeScannerToolWidget({
    Key? key,
    required this.icon,
    this.callback,
  }) : super(key: key);

  final IconData icon;
  final Function()? callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        onPressed: () => callback!(),
        icon: Icon(icon, color: Colors.grey.shade200),
      ),
    );
  }
}
