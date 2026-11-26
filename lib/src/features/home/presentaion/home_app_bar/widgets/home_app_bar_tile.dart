import 'package:flutter/material.dart';

import '../../utils/home_decorations.dart';

/// White rounded tappable tile used by the header search field and the
/// language button.
class HomeAppBarTile extends StatelessWidget {
  const HomeAppBarTile({
    super.key,
    required this.child,
    required this.onTap,
    this.width,
    this.semanticLabel,
  });

  final Widget child;
  final VoidCallback onTap;
  final double? width;
  final String? semanticLabel;

  static const double height = 50;
  static const double _radius = 18;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(_radius);
    return Semantics(
      button: true,
      label: semanticLabel,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
          border: Border.all(color: HomeDecorations.whiteBorder),
          boxShadow: HomeDecorations.headerTileShadow,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius,
            child: child,
          ),
        ),
      ),
    );
  }
}
