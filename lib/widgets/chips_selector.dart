import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';

class ChipsSelector extends StatelessWidget {
  ChipsSelector({
    required this.options,
    required this.selected,
    required this.setter,
  });
  final List<String> options;
  final String selected;
  final ValueSetter<String> setter;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => ChoiceChip(
        label: Row(
          children: [
            if (selected == options[index])
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Theme.of(context).accentColor,
                  ),
                  SizedBox(width: 4)
                ],
              ),
            Text(
              capitalize(options[index]),
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        visualDensity: VisualDensity(vertical: 1),
        selected: selected == options[index],
        onSelected: (bool selected) {
          if (selected) setter(options[index]);
        },
      ),
      separatorBuilder: (context, index) => SizedBox(width: 8),
      itemCount: options.length,
    );
  }
}
