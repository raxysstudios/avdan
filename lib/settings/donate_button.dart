import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class DonateButton extends StatefulWidget {
  @override
  _DonateButtonState createState() => _DonateButtonState();
}

class _DonateButtonState extends State<DonateButton> {
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  bool? loading;

  @override
  void initState() {
    _subscription = InAppPurchase.instance.purchaseStream.listen(
      (purchaseDetailsList) {
        purchaseDetailsList.forEach((purchaseDetails) async {
          if (purchaseDetails.status == PurchaseStatus.pending)
            loading = true;
          else if (purchaseDetails.status == PurchaseStatus.error)
            showError();
          else if (purchaseDetails.pendingCompletePurchase) {
            await InAppPurchase.instance.completePurchase(purchaseDetails);
            loading = false;
          }
        });
      },
      onDone: _subscription?.cancel,
      onError: (_) => showError(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Error.'),
      ),
    );
    loading = null;
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
    if (loading == true) return Text('Loading');
    if (loading == false)
      return TextButton.icon(
        onPressed: null,
        icon: Icon(Icons.check_outlined),
        label: Text('Thanks!'),
      );
    return OutlinedButton.icon(
      onPressed: loading == null ? donate : null,
      icon: Icon(Icons.coffee_outlined),
      label: Text('Donate'),
    );
  }
}
