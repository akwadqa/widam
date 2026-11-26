import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Moves a light highlight across [child]. Wrap skeleton placeholders
/// ([AppSkeletonBox]) with it while data loads.
class AppShimmer extends StatefulWidget {
  const AppShimmer({
    super.key,
    required this.child,
    this.baseColor = AppColors.iceBlue,
    this.highlightColor = Colors.white,
  });

  final Widget child;
  final Color baseColor;
  final Color highlightColor;

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  static const Duration _period = Duration(milliseconds: 1400);
  static const List<double> _stops = [0.35, 0.5, 0.65];

  late final AnimationController _controller =
      AnimationController(vsync: this, duration: _period)..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) => ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) => LinearGradient(
          colors: [widget.baseColor, widget.highlightColor, widget.baseColor],
          stops: _stops,
          transform: _SlidingGradientTransform(_controller.value),
        ).createShader(bounds),
        child: child,
      ),
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform(this.progress);

  /// 0 → highlight off the start edge, 1 → off the end edge.
  final double progress;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(bounds.width * (progress * 2 - 1), 0, 0);
}

/// Rounded placeholder block for skeleton layouts.
class AppSkeletonBox extends StatelessWidget {
  const AppSkeletonBox({
    super.key,
    this.width,
    required this.height,
    this.radius,
  });

  final double? width;
  final double height;

  /// Defaults to a pill shape (half the height).
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.iceBlue,
        borderRadius: BorderRadius.circular(radius ?? height / 2),
      ),
    );
  }
}
