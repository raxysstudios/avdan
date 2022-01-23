import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class DonateButton extends StatefulWidget {
  final String androidProductId;
  final String iosProductId;
  final Widget icon;
  final Widget label;

  const DonateButton({
    this.label = const Text('Donate'),
    this.icon = const Icon(Icons.coffee_rounded),
    this.androidProductId = 'support',
    this.iosProductId = 'support',
    Key? key,
  }) : super(key: key);

  @override
  _DonateButtonState createState() => _DonateButtonState();
}

class _DonateButtonState extends State<DonateButton> {
  late final StreamSubscription<List<PurchaseDetails>> subscription;
  bool get isValidPlatform => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  void initState() {
    if (isValidPlatform) {
      subscription = InAppPurchase.instance.purchaseStream.listen(
        (purchaseDetailsList) async {
          for (var purchase in purchaseDetailsList) {
            if (purchase.pendingCompletePurchase) {
              await InAppPurchase.instance.completePurchase(purchase);
            }
          }
        },
        onDone: () => subscription.cancel(),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    if (isValidPlatform) {
      subscription.cancel();
    }
    super.dispose();
  }

  void purchase() async {
    final response = await InAppPurchase.instance.queryProductDetails(
      {Platform.isIOS ? widget.iosProductId : widget.androidProductId},
    );
    await InAppPurchase.instance.buyConsumable(
      purchaseParam: PurchaseParam(
        productDetails: response.productDetails.first,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: isValidPlatform ? purchase : null,
      icon: widget.icon,
      label: widget.label,
    );
  }
}
