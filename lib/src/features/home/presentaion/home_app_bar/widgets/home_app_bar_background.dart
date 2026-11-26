import 'package:flutter/material.dart';

import '../../../../../theme/app_colors.dart';

/// Light-blue gradient behind the top of the home page, fading to white at
/// the bottom, with a soft glow and two outlined chat-bubble shapes.
///
/// It is taller than the header so the fade continues behind the first
/// content card. [topInset] is the status bar height: the decorations are
/// placed relative to the content below it, as in the design.
class HomeAppBarBackground extends StatelessWidget {
  const HomeAppBarBackground({super.key, required this.topInset});

  final double topInset;

  /// Height below the status bar.
  static const double contentHeight = 250;

  // 115° CSS angle expressed as Flutter alignments.
  static const Alignment _gradientBegin = Alignment(-1, -0.47);
  static const Alignment _gradientEnd = Alignment(1, 0.47);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: topInset + contentHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: _gradientBegin,
                end: _gradientEnd,
                colors: [
                  AppColors.poloBlue,
                  AppColors.skyBlue,
                  AppColors.paleCyanBlue,
                ],
                stops: [0, 0.55, 1],
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0),
                  Colors.white.withValues(alpha: 0.35),
                  Colors.white,
                ],
                stops: const [0, 0.55, 1],
              ),
            ),
          ),
          PositionedDirectional(
            top: topInset - 110,
            end: -130,
            width: 360,
            height: 360,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.75),
                    Colors.white.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: topInset - 50,
            end: -60,
            width: 230,
            height: 210,
            child: CustomPaint(
              painter: _ChatBubblePainter(
                  color: Colors.white.withValues(alpha: 0.95)),
            ),
          ),
          PositionedDirectional(
            top: topInset + 18,
            start: -34,
            width: 120,
            height: 114,
            child: CustomPaint(
              painter: _ChatBubblePainter(
                  color: Colors.white.withValues(alpha: 0.7)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Draws the outline of a round speech bubble with its tail at the bottom
/// left, scaled from a 200 × 190 design box.
class _ChatBubblePainter extends CustomPainter {
  const _ChatBubblePainter({required this.color});

  final Color color;

  static const Size _designSize = Size(200, 190);
  static const double _strokeWidth = 3;
  static const Radius _bubbleRadius = Radius.circular(80);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(110, 20)
      ..arcToPoint(const Offset(66, 166.8),
          radius: _bubbleRadius, largeArc: true)
      ..lineTo(28, 182)
      ..lineTo(40, 144)
      ..arcToPoint(const Offset(110, 20), radius: _bubbleRadius)
      ..close();

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeJoin = StrokeJoin.round;

    canvas
      ..save()
      ..scale(size.width / _designSize.width, size.height / _designSize.height)
      ..drawPath(path, paint)
      ..restore();
  }

  @override
  bool shouldRepaint(_ChatBubblePainter oldDelegate) =>
      oldDelegate.color != color;
}
