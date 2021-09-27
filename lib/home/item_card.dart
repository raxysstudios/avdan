import 'package:avdan/data/translation.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Translation? item;
  final String? image;
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
          child: image == null
              ? Center(
                  child: Text(
                    item!.learning!.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : Image.asset(
                  image!,
                  errorBuilder: (_, __, ___) {
                    return const Center(
                      child: Text('?'),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
