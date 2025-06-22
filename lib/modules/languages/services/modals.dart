import 'package:avdan/models/language.dart';
import 'package:flutter/material.dart';

Future<bool?> selectAltScript(
  BuildContext context,
  Language language,
) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: const Text('Выберите письменность'),
        clipBehavior: Clip.antiAlias,
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              '1. ${language.caption.main}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              '2. ${language.caption.alt!}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      );
    },
  );
}
