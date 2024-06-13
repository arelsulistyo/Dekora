import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'payment_success_screen.dart';

class PaymentWebView extends StatefulWidget {
  final String snapToken;

  const PaymentWebView({Key? key, required this.snapToken}) : super(key: key);

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  @override
  void initState() {
    super.initState();
    _launchURL();
  }

  void _launchURL() async {
    final url =
        'https://app.sandbox.midtrans.com/snap/v2/vtweb/${widget.snapToken}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Opening payment page...',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentSuccessScreen(),
                  ),
                );
              },
              child: Text('Return to App'),
            ),
          ],
        ),
      ),
    );
  }
}
