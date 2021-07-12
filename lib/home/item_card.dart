import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  ItemCard({
    this.image,
    this.onTap,
    this.color,
  });
  final String? image;
  final Function()? onTap;
  final Color? color;

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
          child: Image.asset(
            image!,
            errorBuilder: (_, __, ___) {
              return Center(
                child: Text('?'),
              );
            },
          ),
        ),
      ),
    );
  }
}
