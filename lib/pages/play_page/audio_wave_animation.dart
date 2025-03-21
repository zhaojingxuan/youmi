import 'dart:math';

import 'package:flutter/material.dart';

class AudioWaveAnimation extends StatefulWidget {
  final double size;
  final Color color;
  final int barCount;

  const AudioWaveAnimation({
    super.key,
    required this.size,
    required this.color,
    this.barCount = 5,
  });

  @override
  AudioWaveAnimationState createState() => AudioWaveAnimationState();
}

class AudioWaveAnimationState extends State<AudioWaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
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
          size: Size(widget.size, widget.size),
          painter: WavePainter(
            animationValue: _controller.value,
            color: widget.color,
            barCount: widget.barCount,
          ),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  final Color color;
  final int barCount;

  WavePainter({
    required this.animationValue,
    required this.color,
    required this.barCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final barWidth = size.width / (barCount * 2 - 1);
    final maxHeight = size.height * 0.8;

    for (var i = 0; i < barCount; i++) {
      // 使用正弦函数创建波动效果，添加相位差
      final phase = i * 0.3;
      final heightFactor =
          (sin(2 * pi * animationValue + phase) + 1) / 2 * 0.5 + 0.5;
      final barHeight = maxHeight * heightFactor;

      final left = i * 2 * barWidth;
      final top = (size.height - barHeight) / 2;
      final rect = Rect.fromLTWH(left, top, barWidth, barHeight);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(barWidth / 2)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        color != oldDelegate.color ||
        barCount != oldDelegate.barCount;
  }
}
