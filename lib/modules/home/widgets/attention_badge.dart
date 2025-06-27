import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class AttentionBadge extends StatelessWidget {
  const AttentionBadge({
    this.show = true,
    required this.child,
    super.key,
  });

  final bool show;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      showBadge: true,
      position: badges.BadgePosition.topEnd(
        top: 2,
        end: 2,
      ),
      badgeStyle: badges.BadgeStyle(
        badgeColor: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.all(6),
      ),
      badgeAnimation: badges.BadgeAnimation.scale(
        loopAnimation: true,
      ),
      child: child,
    );
  }
}
