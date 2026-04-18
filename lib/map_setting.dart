import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// يفتح شيت جانبي ملاصق لليمين، ويعرض أي محتوى تبنيه في [builder]
Future<void> showRightSideSheet({
  required BuildContext context,
  required WidgetBuilder builder,
  double panelWidth = 360,     // عدّل العرض لو حابب
  EdgeInsets panelMargin = const EdgeInsets.only(top: 8, right: 0, bottom: 0),
  Duration transition = const Duration(milliseconds: 260),
  bool blurBackground = true,
  Color barrierColor = Colors.black54,
}) {
  final size = MediaQuery.of(context).size;

  return showGeneralDialog(
    context: context,
    barrierLabel: 'right-side-sheet',
    barrierDismissible: true,
    barrierColor: barrierColor,
    transitionDuration: transition,
    pageBuilder: (ctx, _, __) {
      final topInset = MediaQuery.of(ctx).padding.top + panelMargin.top;

      return Stack(
        children: [
          // Blur اختياري للخلفية
          if (blurBackground)
            Positioned.fill(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
                child: const SizedBox.expand(),
              ),
            ),

          // الحاوية الملتصقة باليمين — نعرض بداخلها المحتوى كما هو من builder
          Positioned(
            top: topInset,
            right: panelMargin.right,
            bottom: panelMargin.bottom,
            child: Material(
              color: Colors.transparent,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: size.height - topInset - panelMargin.bottom,
                  maxWidth: panelWidth,
                ),
                child: SizedBox(
                  width: panelWidth,
                  child: builder(ctx), // <<<<<< محتواك كما هو
                ),
              ),
            ),
          ),
        ],
      );
    },
    transitionBuilder: (_, anim, __, child) {
      final slide = Tween<Offset>(
        begin: const Offset(1, 0), // يدخل من اليمين
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic));
      return SlideTransition(position: slide, child: child);
    },
  );
}

/// ويدجت صغيرة آمنة لفتح الشيت داخل build بدون استدعاء مباشر
class SideSheetOpeners extends StatefulWidget {
  const SideSheetOpeners({
    super.key,
    required this.open,
    required this.onClosedOrReset,
    required this.sheetBuilder,
    this.panelWidth = 360,
  });

  final bool open;
  final VoidCallback onClosedOrReset;
  final WidgetBuilder sheetBuilder;
  final double panelWidth;

  @override
  State<SideSheetOpeners> createState() => _SideSheetOpenerState();
}

class _SideSheetOpenerState extends State<SideSheetOpeners> {
  bool _openingNow = false;

  @override
  void initState() {
    super.initState();
    if (widget.open) _scheduleOpen();
  }

  @override
  void didUpdateWidget(covariant SideSheetOpeners oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.open && widget.open) _scheduleOpen();
  }

  void _scheduleOpen() {
    if (_openingNow) return;
    _openingNow = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await showRightSideSheet(
        context: context,
        panelWidth: widget.panelWidth,
        builder: widget.sheetBuilder,
      );
      if (!mounted) return;
      widget.onClosedOrReset(); // مثل: setState(() => displayWeatherSidebar = false);
      _openingNow = false;
    });
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
