import 'package:avdan/data/translation.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final Translation? item;
  final Image? image;
  final Function()? onTap;
  final Color? color;

  const ItemCard({
    Key? key,
    this.item,
    this.image,
    this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        highlightColor: color,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: image ??
              Center(
                child: Builder(
                  builder: (contenxt) {
                    if (image != null) return image!;
                    if (item != null) {
                      return Consumer<Store>(
                        builder: (contenxt, store, child) {
                          return Text(
                            item!.text(store.learning, store.alt),
                            style: const TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
        ),
      ),
    );
  }
}
