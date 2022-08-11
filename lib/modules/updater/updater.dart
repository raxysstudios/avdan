import 'package:avdan/models/pack.dart';
import 'package:avdan/modules/updater/services/packs.dart';
import 'package:flutter/material.dart';

class UpdaterScreen extends StatefulWidget {
  const UpdaterScreen({super.key});

  @override
  State<UpdaterScreen> createState() => _UpdaterScreenState();
}

class _UpdaterScreenState extends State<UpdaterScreen> {
  var pending = <Pack>[];

  @override
  void initState() {
    super.initState();
    fetchUpdatedPacks(context).then(
      (p) => setState(
        () {
          pending = p;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(),
    );
  }
}
