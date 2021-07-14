import 'dart:async';
import 'package:avdan/data/utils.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class DonateButton extends StatefulWidget {
  @override
  _DonateButtonState createState() => _DonateButtonState();
}

class _DonateButtonState extends State<DonateButton> {
  late final StreamSubscription<List<PurchaseDetails>> subscription;

  @override
  void initState() {
    super.initState();
    subscription = InAppPurchase.instance.purchaseStream.listen(
      (purchaseDetailsList) {
        purchaseDetailsList.forEach((purchase) async {
          if (purchase.pendingCompletePurchase)
            await InAppPurchase.instance.completePurchase(purchase);
        });
      },
      onDone: () => subscription.cancel(),
    );
  }

  @override
  void dispose() {
    subscription.cancel();
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
    return OutlinedButton.icon(
      onPressed: purchase,
      icon: Icon(Icons.coffee_outlined),
      label: Text(capitalize(Localization.get('support'))),
    );
  }
}
