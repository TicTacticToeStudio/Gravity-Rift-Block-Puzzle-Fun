import 'dart:math';
import 'package:flutter/material.dart';
import 'package:energy_blast/core/theme/app_colors.dart';

class CosmicBackground extends StatefulWidget {
  final Widget child;

  const CosmicBackground({super.key, required this.child});

  @override
  State<CosmicBackground> createState() => _CosmicBackgroundState();
}

class _CosmicBackgroundState extends State<CosmicBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _WarpSpeedPainter(_controller.value),
          child: widget.child,
        );
      },
    );
  }
}

class _WarpSpeedPainter extends CustomPainter {
  final double t;
  final Random _random = Random(101);
  late final List<_FlyingStar> _stars;
  late final List<_Comet> _comets;

  _WarpSpeedPainter(this.t) {
    _stars = List.generate(80, (index) {
      return _FlyingStar(
        angle: _random.nextDouble() * 2 * pi,
        startR: _random.nextDouble(),
        speed: _random.nextDouble() * 3.0 + 1.0,
        size: _random.nextDouble() * 1.5 + 0.5,
      );
    });

    _comets = List.generate(5, (index) {
      return _Comet(
        startT: index / 5.0,
        angle: _random.nextDouble() * 2 * pi,
        speed: _random.nextDouble() * 0.2 + 0.15,
        length: _random.nextDouble() * 100 + 80,
        delay: _random.nextDouble() * 0.05,
      );
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.background,
          Color(0xFF15122E),
          AppColors.background,
        ],
      ).createShader(rect);
    canvas.drawRect(rect, bgPaint);

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double maxDist = sqrt(centerX * centerX + centerY * centerY) * 1.2;

    // 2. Draw Flying Stars (Warp Speed)
    final starPaint = Paint()..strokeCap = StrokeCap.round;

    for (var star in _stars) {
      final double currentDist = (star.startR + (t * star.speed)) % 1.0;
      final double radius = currentDist * maxDist;

      final double x = centerX + cos(star.angle) * radius;
      final double y = centerY + sin(star.angle) * radius;

      // Star size grows from 0 (center) to max (edge)
      final double starSize = star.size * (currentDist * 4);

      double opacity = 1.0;
      if (currentDist < 0.05) {
        opacity = currentDist / 0.05;
      } else if (currentDist > 0.8) {
        opacity = 1.0 - ((currentDist - 0.8) / 0.2);
      }

      starPaint.color = Colors.white.withOpacity(opacity * 0.9);

      // FIXED MATH: Calculate where the star was slightly earlier.
      // We subtract a percentage of currentDist, ensuring the tail ALWAYS moves outwards.
      final double trailDist = currentDist - (currentDist * currentDist * 0.4);
      final double trailRadius = trailDist * maxDist;

      final double trailX = centerX + cos(star.angle) * trailRadius;
      final double trailY = centerY + sin(star.angle) * trailRadius;

      canvas.drawLine(
        Offset(trailX, trailY),
        Offset(x, y),
        starPaint..strokeWidth = starSize,
      );
    }

    // 3. Draw Comets
    for (var comet in _comets) {
      double cometT = (t - comet.startT) % 1.0;
      if (cometT < 0) cometT += 1.0;

      if (cometT < comet.speed) {
        final double progress = cometT / comet.speed;

        final double startX = centerX + cos(comet.angle) * maxDist;
        final double startY = centerY + sin(comet.angle) * maxDist;

        final double endX = centerX - cos(comet.angle) * maxDist;
        final double endY = centerY - sin(comet.angle) * maxDist;

        final currentPos = Offset.lerp(
            Offset(startX, startY),
            Offset(endX, endY),
            progress
        )!;

        final double tailX = currentPos.dx + cos(comet.angle) * comet.length;
        final double tailY = currentPos.dy + sin(comet.angle) * comet.length;

        final tailPaint = Paint()
          ..shader = LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.transparent],
          ).createShader(Rect.fromPoints(currentPos, Offset(tailX, tailY)))
          ..strokeWidth = 4.0
          ..strokeCap = StrokeCap.round;

        canvas.drawLine(currentPos, Offset(tailX, tailY), tailPaint);

        // Comet Head
        final outerGlow = Paint()
          ..color = AppColors.primary.withOpacity(0.6)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15.0);
        canvas.drawCircle(currentPos, 12, outerGlow);

        final innerGlow = Paint()
          ..color = Colors.white.withOpacity(0.9)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0);
        canvas.drawCircle(currentPos, 7, innerGlow);

        final core = Paint()..color = Colors.white;
        canvas.drawCircle(currentPos, 4, core);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _WarpSpeedPainter oldDelegate) => oldDelegate.t != t;
}

class _FlyingStar {
  final double angle;
  final double startR;
  final double speed;
  final double size;
  _FlyingStar({required this.angle, required this.startR, required this.speed, required this.size});
}

class _Comet {
  final double startT;
  final double angle;
  final double speed;
  final double length;
  final double delay;
  _Comet({required this.startT, required this.angle, required this.speed, required this.length, required this.delay});
}