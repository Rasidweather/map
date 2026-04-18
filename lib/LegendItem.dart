import 'package:flutter/material.dart';


class LegendItem extends StatefulWidget {
  final String title;
  final String speed;
  final Color iconColor;
  final String label;
  final Color? lineColor;
  final Gradient? lineGradient;

  const LegendItem({
    super.key,
    required this.title,
    required this.speed,
    required this.iconColor,
    required this.label,
    this.lineColor,
    this.lineGradient,
  });

  @override
  State<LegendItem> createState() => _LegendItemState();
}

class _LegendItemState extends State<LegendItem>
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RotationTransition(
                turns: _controller,
                child: Icon(Icons.cyclone, color: widget.iconColor),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title,
                        style: TextStyle(color: Colors.white)),
                    if (widget.speed.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(widget.speed,
                              style: TextStyle(color: Colors.white70)),
                          SizedBox(height: 3),
                          Container(
                            height: 4,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: widget.lineGradient == null
                                  ? (widget.lineColor ?? Colors.white)
                                  : null,
                              gradient: widget.lineGradient,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


