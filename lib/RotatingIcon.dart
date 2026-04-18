import 'package:flutter/material.dart';

class RotatingIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final double size;

  const RotatingIcon({
    super.key,
    required this.icon,
    required this.color,
    this.size = 24,
  });

  @override
  State<RotatingIcon> createState() => _RotatingIconState();
}

class _RotatingIconState extends State<RotatingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Icon(widget.icon, color: widget.color, size: widget.size),
    );
  }
}
