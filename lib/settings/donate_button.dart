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
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  bool loading = false;

  @override
  void initState() {
    _subscription = InAppPurchase.instance.purchaseStream.listen(
      (purchaseDetailsList) {
        purchaseDetailsList.forEach((purchaseDetails) async {
          if (purchaseDetails.status == PurchaseStatus.pending)
            loading = true;
          else if (purchaseDetails.status == PurchaseStatus.error)
            showSnack('Thanks!');
          else if (purchaseDetails.pendingCompletePurchase) {
            await InAppPurchase.instance.completePurchase(purchaseDetails);
            loading = false;
          }
        });
      },
      onDone: _subscription?.cancel,
      onError: (_) => showSnack('Error!'),
    );
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void showSnack(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
    loading = false;
  }

  void donate() async {
    print('Looking for product');
    final response =
        await InAppPurchase.instance.queryProductDetails({'donation'});
    print('Found product');
    await InAppPurchase.instance.buyConsumable(
      purchaseParam: PurchaseParam(
        productDetails: response.productDetails.first,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: loading ? null : donate,
      icon: Icon(Icons.coffee_outlined),
      label: Text(capitalize(Localization.get('support'))),
    );
  }
}
