import 'package:flutter/material.dart';
import 'package:energy_blast/core/theme/app_colors.dart';

class PulsingSurprisePiece extends StatefulWidget {
  final double size;

  const PulsingSurprisePiece({super.key, required this.size});

  @override
  State<PulsingSurprisePiece> createState() => _PulsingSurprisePieceState();
}

class _PulsingSurprisePieceState extends State<PulsingSurprisePiece> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            margin: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: AppColors.secondary, // Neon Pink/Purple
              borderRadius: BorderRadius.circular(widget.size * 0.1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondary.withValues(alpha: 0.8),
                  blurRadius: 15 * _animation.value,
                  spreadRadius: 3 * _animation.value,
                )
              ],
            ),
            child: Icon(
              Icons.question_mark,
              color: Colors.white,
              size: widget.size * 0.7,
            ),
          ),
        );
      },
    );
  }
}