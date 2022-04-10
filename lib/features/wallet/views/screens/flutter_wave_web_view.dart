import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jolobbi_app/features/profile/model/user_profile_data_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/constants/keys.dart';

class FlutterWeb extends StatefulWidget {
  final Function()? onClosed;
  final String description;
  final String amount;
  final String transactionRef;
  final UserProfileDataModel user;
 
  final String? error;

  const FlutterWeb({
    Key? key,
    this.error,
    this.onClosed,
    required this.description,
    required this.amount,
    required this.transactionRef,
    required this.user,
  }) : super(key: key);

  @override
  _FlutterWebState createState() => _FlutterWebState();
}

class _FlutterWebState extends State<FlutterWeb> {
  String contentBase64 = '';
  bool isLoading = false;
  bool hasError = false;

  @override
  void initState() {
    contentBase64 = base64Encode(const Utf8Encoder().convert(_buildHtml()));
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget("Make Payment", textColor: kcWhite),
        centerTitle: true,
        backgroundColor: kcPrimaryColor,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
              ),
              child: WebView(
                initialUrl: 'data:text/html;base64,$contentBase64',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  // if (!_controller.isCompleted)
                  //   _controller.complete(webViewController);
                  // _webViewController = webViewController;
                },
                // onPageStarted: (String url) {
                //   // hasFoward = await _webViewController?.canGoForward();
                //   setState(() {
                //     isLoading = true;
                //     hasError = false;
                //   });
                // },
                javascriptChannels: <JavascriptChannel>{
                  _flutterWaveChannel(context),
                },

                onPageFinished: (String url) async {
                  isLoading = false;
                  setState(() {});
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  JavascriptChannel _flutterWaveChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        if (message.message == 'close') {
          log('close');
          // Navigator.pop(context);
          //modal close untimely, do not
        } else {
          log("success message");
          log(json.decode(message.message).toString());
          handleResponse(json.decode(message.message));
        
        }
      },
    );
  }

  
  void handleResponse(Map<String, dynamic> body) {
    if (body['status'] == "successful") {
      return Navigator.pop(context, body);
    } else {
      // showErrorSnackBar('Error Making Payment');
    }
  }

  /// build Flutterwave html page
  String _buildHtml() => ''' <!DOCTYPE html>
    <html lang="en">
        <head>
          <meta charset="UTF-8">
          <meta http-equiv="X-UA-Compatible" content="ie=edge">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Flutterwave Payment</title>
          <script src="https://checkout.flutterwave.com/v3.js"></script>
        </head>
        <body onload="makePayment" style="background-color:#fff;height:100vh;overflow: scroll;">
          <!-- <form>
            <script src="https://checkout.flutterwave.com/v3.js"></script>
            <button type="button" onClick="alert('here we are')">Pay Now</button>
          </form> -->
          <script>
            window.onload = makePayment();
            function makePayment() { 
              FlutterwaveCheckout({
                public_key: "$flutterWavePublicKey",
                tx_ref: "${widget.transactionRef}",
                amount: "${widget.amount}",
                currency: "NGN",
                country: "NG",
                payment_options: "card",
                // redirect_url: // specified redirect URL
                //   "https://webhook.dev.ajobox.com?m=card",
                customer: {
                  email: "${widget.user.email}",
                  phone_number: "${widget.user.mobile}",
                  name: "${widget.user.name} ",
                },
                callback: function (data) {
                  console.log(data);
                  Print.postMessage(JSON.stringify(data))
                },
                onclose: function() {
                  // close modal
                  Print.postMessage("close")
                },
                customizations: {
                  title: "REborn App",
                  description: '${widget.description}',
                  // logo: "https://buildout.ajobox.com/faviicon.co",
                },
              });
            }
          </script>
        </body>
    </html>''';
}
