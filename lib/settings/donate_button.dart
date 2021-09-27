import 'dart:async';
import 'package:avdan/data/utils.dart';
import 'package:avdan/store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class DonateButton extends StatefulWidget {
  const DonateButton({Key? key}) : super(key: key);

  @override
  _DonateButtonState createState() => _DonateButtonState();
}

class _DonateButtonState extends State<DonateButton> {
  late final StreamSubscription<List<PurchaseDetails>> subscription;
  bool get isValidPlatform =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;

  @override
  void initState() {
    super.initState();
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
      {'support'},
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
      icon: const Icon(Icons.coffee_outlined),
      label: Text(capitalize(Localization.get('support'))),
    );
  }
}
