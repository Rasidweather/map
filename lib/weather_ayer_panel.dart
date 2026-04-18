import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// افتح الشيت الجانبي
Future<void> showWeatherSideSheet(BuildContext context) {
  return showGeneralDialog(
    context: context,
    barrierLabel: 'weather-side-sheet',
    barrierDismissible: true,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (ctx, _, __) {
      final size = MediaQuery.of(ctx).size;

      // ==== قياسات دقيقة مثل الصورة ====
      const double kPanelWidth = 335; // عرض اللوح نفسه (يلتصق يمين)
      const double kSideInset = 0;    // 0 عشان يلمس الحافة اليمنى
      final double kTopInset = MediaQuery.of(ctx).padding.top + 8;

      return Stack(
        children: [
          // تأثير Blur للخلفية
          Positioned.fill(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
              child: const SizedBox.expand(),
            ),
          ),

          // لوح المحتوى ملاصق لليمين
          Positioned(
            top: kTopInset,
            right: kSideInset,
            bottom: 0,
            child: Material(
              color: Colors.transparent,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: size.height - kTopInset,
                  maxWidth: kPanelWidth,
                ),
                child: Container(
                  width: kPanelWidth,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(40, 43, 58, 0.88),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const _WeatherSideSheetExact(),
                ),
              ),
            ),
          ),

          // زر الإغلاق (دائري على يسار اللوح مثل الصورة)
          Positioned(
            top: kTopInset + 18,
            left: 10, // يخرج جزء منه خارج اللوح
            child: GestureDetector(
              onTap: () => Navigator.of(ctx).maybePop(),
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFF242733),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.35),
                      blurRadius: 10,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.close, color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      );
    },
    transitionBuilder: (_, anim, __, child) {
      final slide = Tween<Offset>(
        begin: const Offset(1, 0), // من اليمين
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic));
      return SlideTransition(position: slide, child: child);
    },
  );
}

/* ================== المحتوى بدقة أحجام الصورة ================== */

class _WeatherSideSheetExact extends StatelessWidget {
  const _WeatherSideSheetExact();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      // حالات السويتشات
      bool iconVsGfsIsIcon = _memGet<bool>('iconVsGfsIsIcon') ?? true;
      int mapMode = _memGet<int>('mapMode') ?? 0;

      void toggleIconGfs() {
        iconVsGfsIsIcon = !iconVsGfsIsIcon;
        _memSet('iconVsGfsIsIcon', iconVsGfsIsIcon);
        setState(() {});
      }

      void setMapMode(int i) {
        mapMode = i;
        _memSet('mapMode', mapMode);
        setState(() {});
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),

          // عناوين العناصر العلوية + السويتشات
          const _LabelRow('Forcast Model'), // نفس كتابة اللقطة
          const SizedBox(height: 6),
          _Segment2(
            isLeftOn: iconVsGfsIsIcon,
            left: 'Icon',
            right: 'GFS',
            onTap: toggleIconGfs,
          ),
          const SizedBox(height: 14),

          const _LabelRow('Map Mod'),
          const SizedBox(height: 6),
          _Segment3(
            values: const ['Light', 'Dark', 'Natural'],
            current: mapMode,
            onChanged: setMapMode,
          ),

          const SizedBox(height: 16),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle('Satellite & Radar'),
                  const SizedBox(height: 12),

                  // === شبكة البلاطات بنفس القياسات ===
                  _TileGrid(rows: const [
                    [
                      _Tile('images/Mask group (3).png', 'Visual', 'images/visual.png'),
                      _Tile('images/Mask group (7).png', 'Infrared Rays', 'images/infrared rays.png'),
                      _Tile('images/Mask group (6).png', 'Satellite', 'images/satellite.png'),
                    ],
                    [
                      _Tile('images/Mask group (2).png', 'Thunder', 'images/thunder.png'),
                      _Tile('images/Mask group (4).png', 'Rain Radar', 'images/Rain radar.png'),
                      _Tile('images/Mask group (5).png', 'Water Vapor', 'images/water vapor.png'),
                    ],
                  ]),

                  const SizedBox(height: 18),
                  const _SectionTitle('Weather Overlay'),
                  const SizedBox(height: 12),

                  _TileGrid(rows: const [
                    [
                      _Tile('images/Mask group (3).png', 'Thunder Storm', 'images/thunder storm.png'),
                      _Tile('images/Mask group (7).png', 'Rain', 'images/rain.png'),
                      _Tile('images/Mask group (6).png', 'Temperature', 'images/temperature anomaly.png'),
                    ],
                    [
                      _Tile('images/Mask group (2).png', 'Wind Gusts', 'images/reah.png'),
                      _Tile('images/Mask group (4).png', 'Rain radar', 'images/Rain radar.png'),
                      _Tile('images/Mask group (5).png','Water vapor', 'images/water vapor.png'),
                    ],
                  ]),

                  const SizedBox(height: 18),
                  const _SectionTitle('Hurricane'),
                  const SizedBox(height: 12),
                  _TileGrid(rows: const [
                    [
                      _Tile('images/Mask group (2).png', 'Hurricane', 'images/Hurricane.png'),
                    ]
                  ]),

                  const SizedBox(height: 18),
                  const _SectionTitle('Waves'),
                  const SizedBox(height: 12),
                  _TileGrid(rows: const [
                    [
                      _Tile('images/png1.jpg', 'Tidal Waves', null),
                      _Tile('images/png2.jpg', 'Wind Waves', 'assets/rainy_2d.png'),
                      _Tile('images/png3.jpg', 'Waves & Mixed Waves', 'images/temper.png'),
                    ],
                    [
                      _Tile('images/png4.jpg', 'Maximum Wave Height', 'images/pressure.png'),
                      _Tile('images/png3.jpg', 'Sea Temperature', 'assets/snow_2d.png'),
                    ],
                  ]),

                  const SizedBox(height: 18),
                  const _SectionTitle('Air Quality'),
                  const SizedBox(height: 12),
                  _TileGrid(rows: const [
                    [
                      _Tile('images/png1.jpg', '2.5 Micron Particles', 'images/pressure.png'),
                      _Tile('images/png2.jpg', 'Fog', 'images/temper.png'),
                      _Tile('images/png3.jpg', 'Air Quality Index', 'images/reah.png'),
                    ],
                    [
                      _Tile('images/png4.jpg', '10 Micron Particles', 'images/pressure.png'),
                      _Tile('images/png3.jpg', 'Co₂', 'assets/sunny.png'),
                      _Tile('images/png1.jpg', 'So₂', 'images/reah.png'),
                    ],
                    [
                      _Tile('images/png4.jpg', 'Total Column Co₂', 'images/pressure.png'),
                      _Tile('images/png3.jpg', 'Tropospheric Ozone', 'assets/sunny.png'),
                    ],
                  ]),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

/* ================== Widgets & Styles ================== */

// قياسات دقيقة للبلاطات حسب اللقطة
const double _tileW = 85.3;
const double _tileH = 60.0;
const double _iconOverlaySize = 25.0;
const double _tileRadius = 12.0;
const double _tileSpacingH = 18.0; // أفقي بين البلاطات
const double _tileSpacingV = 18.0; // رأسي بين الصفوف

class _LabelRow extends StatelessWidget {
  const _LabelRow(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
         Image.asset('images/time 1.png'),
        const SizedBox(width: 6),

        Text(text,
            style: const TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18, // حجم كبير مثل الصورة
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

/// سويتش ثنائي بشكل كبسولة
class _Segment2 extends StatelessWidget {
  const _Segment2({
    required this.isLeftOn,
    required this.left,
    required this.right,
    required this.onTap,
  });
  final bool isLeftOn;
  final String left, right;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white, width: 1),
          color: const Color(0xFF1F2230),
        ),
        child: Row(
          children: [
            Expanded(child: _segItem(text: left, active: isLeftOn)),
            Expanded(child: _segItem(text: right, active: !isLeftOn)),
          ],
        ),
      ),
    );
  }
}

/// سويتش ثلاثي
class _Segment3 extends StatelessWidget {
  const _Segment3({
    required this.values,
    required this.current,
    required this.onChanged,
  });
  final List<String> values;
  final int current;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white, width: 1),
        color: const Color(0xFF1F2230),
      ),
      child: Row(
        children: List.generate(values.length, (i) {
          final active = i == current;
          return Expanded(
            child: InkWell(
              onTap: () => onChanged(i),
              child: _segItem(text: values[i], active: active),
            ),
          );
        }),
      ),
    );
  }
}

Widget _segItem({required String text, required bool active}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 140),
    margin: const EdgeInsets.all(3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      color: active ? Colors.white : Colors.transparent,
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: active ? Colors.black : Colors.white,
        ),
      ),
    ),
  );
}

/// تعريف بيانات البلاطة
class _Tile {
  final String bg;
  final String title;
  final String? overlay;
  const _Tile(this.bg, this.title, this.overlay);
}

/// شبكة بلاطات بأحجام ثابتة ومسافات مثل الصورة
class _TileGrid extends StatelessWidget {
  const _TileGrid({required this.rows});
  final List<List<_Tile>> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final row in rows) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int i = 0; i < row.length; i++) ...[
                _TileItem(tile: row[i]),
                if (i != row.length - 1) const SizedBox(width: _tileSpacingH),
              ],
            ],
          ),
          const SizedBox(height: 8),
          // عناوين تحت كل صف
          Row(
            children: [
              for (int i = 0; i < row.length; i++) ...[
                SizedBox(
                  width: _tileW,
                  child: Text(
                    row[i].title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (i != row.length - 1) const SizedBox(width: _tileSpacingH),
              ],
            ],
          ),
          const SizedBox(height: _tileSpacingV),
        ],
      ],
    );
  }
}

/// عنصر البلاطة نفسها
class _TileItem extends StatelessWidget {
  const _TileItem({required this.tile});
  final _Tile tile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _tileW,
      height: _tileH,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // صورة الخلفية مع الحد الأبيض
          ClipRRect(
            borderRadius: BorderRadius.circular(_tileRadius),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(_tileRadius),
              ),
              child: Image.asset(
                tile.bg,
                width: _tileW,
                height: _tileH,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: _tileW,
                  height: _tileH,
                  color: const Color(0xFF3E4255),
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported,
                      color: Colors.white70),
                ),
              ),
            ),
          ),
          if (tile.overlay != null)
            SizedBox(
              width: _iconOverlaySize,
              height: _iconOverlaySize,
              child: Image.asset(
                tile.overlay!,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
        ],
      ),
    );
  }
}

/* ======= ذاكرة مؤقتة بسيطة للحالات ======= */
final Map<String, Object?> _mem = {};
T? _memGet<T>(String k) => _mem[k] as T?;
void _memSet(String k, Object? v) => _mem[k] = v;
