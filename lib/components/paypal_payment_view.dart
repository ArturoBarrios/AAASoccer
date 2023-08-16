import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:soccermadeeasy/extensions/snackbar_dialogue.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../commands/paypal_payment/paypal_provider.dart';

class PaypalPaymentView extends StatefulWidget {
  const PaypalPaymentView({
    Key? key,
    this.paymentUrl,
    this.returnUrl,
    this.cancelUrl,
  }) : super(key: key);

  final String? paymentUrl;
  final String? returnUrl;
  final String? cancelUrl;

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentViewState();
  }
}

class PaypalPaymentViewState extends State<PaypalPaymentView> {
  Future<void> capturePayment(
      {final String? payerID, final String? token}) async {
    final paypalRepository = ProviderContainer().read(paypalRepositoryProvider);

    final result = await paypalRepository.capturePaymentForOrder(
      orderId: token ?? '',
    );
    result.when(
      left: (final left) => ScaffoldMessenger.of(context).show(
        type: SnackBarType.failure,
        message: left.message,
      ),
      right: (right) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).show(
          type: SnackBarType.success,
          message: 'Payment done!',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.contains(widget.returnUrl ?? '')) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              final token = uri.queryParameters['token'];
              if (payerID != null) {
                await capturePayment(payerID: payerID, token: token);
              } else {
                Navigator.of(context).pop();
              }
              Navigator.of(context).pop();
            }
            if (request.url.contains(widget.cancelUrl ?? '')) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('${widget.paymentUrl}'));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
