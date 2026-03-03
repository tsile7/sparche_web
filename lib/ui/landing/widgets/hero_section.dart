import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sparche_web/core/colors.dart';
import 'package:stacked/stacked.dart';
import '../landing_viewmodel.dart';
import 'download_buttons.dart';
import 'shared_widgets.dart';

/// Hero section — warm ivory bg, editorial serif headline,
/// soft radial blobs, floating contextual cards.
class HeroSection extends ViewModelWidget<LandingViewModel> {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context, LandingViewModel vm) {
    final width    = MediaQuery.of(context).size.width;
    final isMobile = width < 820;

    return Stack(
      children: [
        // ── Soft decorative blobs ────────────────────────────────────────
        const Positioned.fill(child: _HeroBlobs()),

        // ── Content ──────────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: isMobile ? 64 : 100,
            bottom: isMobile ? 72 : 100,
            left: isMobile ? 24 : 60,
            right: isMobile ? 24 : 60,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: isMobile
                  ? _MobileHero(vm: vm)
                  : _DesktopHero(vm: vm),
            ),
          ),
        ),
      ],
    );
  }
}

// Soft radial blobs 

class _HeroBlobs extends StatefulWidget {
  const _HeroBlobs();
  @override
  State<_HeroBlobs> createState() => _HeroBlobsState();
}

class _HeroBlobsState extends State<_HeroBlobs>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _ctrl,
    builder: (_, __) => CustomPaint(
      painter: _BlobPainter(_ctrl.value),
    ),
  );
}

class _BlobPainter extends CustomPainter {
  final double t;
  _BlobPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    // Warm violet blob — top left
    _blob(canvas, size,
      cx: size.width * (.08 + .04 * math.sin(t * math.pi)),
      cy: size.height * (.2  + .06 * math.cos(t * math.pi)),
      r: size.width * .38,
      color: const Color(0xFF6120E2).withOpacity(.06),
    );
    // Peach blob — right
    _blob(canvas, size,
      cx: size.width * (.92 + .03 * math.sin(t * math.pi * 1.3)),
      cy: size.height * (.35 + .05 * math.cos(t * math.pi * 1.3)),
      r: size.width * .3,
      color: const Color(0xFFFFB830).withOpacity(.07),
    );
    // Mint blob — bottom
    _blob(canvas, size,
      cx: size.width * .5,
      cy: size.height * 1.0,
      r: size.width * .28,
      color: const Color(0xFF00C9A7).withOpacity(.05),
    );
  }

  void _blob(Canvas c, Size s, {
    required double cx, required double cy,
    required double r, required Color color,
  }) {
    final p = Paint()
      ..shader = RadialGradient(colors: [color, Colors.transparent])
          .createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r));
    c.drawCircle(Offset(cx, cy), r, p);
  }

  @override
  bool shouldRepaint(_BlobPainter o) => o.t != t;
}

// Desktop 
class _DesktopHero extends StatelessWidget {
  final LandingViewModel vm;
  const _DesktopHero({required this.vm});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 10,
        child: _HeroCopy(vm: vm, isMobile: false),
      ),
      const SizedBox(width: 56),
      Expanded(
        flex: 9,
        child: _HeroVisual(),
      ),
    ],
  );
}

// Mobile 

class _MobileHero extends StatelessWidget {
  final LandingViewModel vm;
  const _MobileHero({required this.vm});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      _HeroCopy(vm: vm, isMobile: true),
      const SizedBox(height: 56),
      _HeroVisual(),
    ],
  );
}

// Hero copy block 

class _HeroCopy extends StatelessWidget {
  final LandingViewModel vm;
  final bool isMobile;
  const _HeroCopy({required this.vm, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final ta = isMobile ? TextAlign.center : TextAlign.left;
    final ca = isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: ca,
      children: [
        //  Eyebrow pill 
        FadeUpIn(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LiveDot(),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: kBrandPastel,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: kBrand.withOpacity(.2)),
                ),
                child: const Text(
                  'Available For Download',
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: kBrand,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        // Serif headline 
        FadeUpIn(
          delay: const Duration(milliseconds: 80),
          child: RichText(
            textAlign: ta,
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'DMSerifDisplay',
                fontSize: isMobile ? 44 : 64,
                fontWeight: FontWeight.w400,
                letterSpacing: -1.8,
                height: 1.0,
                color: kTxtInk,
              ),
              children: const [
                TextSpan(text: 'Shop smarter.\nSpend '),
                // Italic accent word — classic editorial technique
                TextSpan(
                  text: 'wiser.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: kBrand,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 22),

        // Subtitle 
        FadeUpIn(
          delay: const Duration(milliseconds: 150),
          child: Text(
            'Keep loyalty cards, track expenses, and manage your shopping '
            'list — all in one pocket-sized app.',
            textAlign: ta,
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: isMobile ? 15 : 17,
              fontWeight: FontWeight.w400,
              height: 1.75,
              color: kTxtBody,
            ),
          ),
        ),

        const SizedBox(height: 28),

        // Feature chips 
        FadeUpIn(
          delay: const Duration(milliseconds: 210),
          child: Wrap(
            spacing: 8, runSpacing: 8,
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            children: const [
              AccentChip('🃏  Loyalty Cards', accent: kAccentViolet),
              AccentChip('📷  Barcode Scanning', accent: kAccentCoral),
              AccentChip('💸  Expense Tracker', accent: kAccentTeal),
              AccentChip('🛒  Shopping List', accent: kAccentAmber),
            ],
          ),
        ),

        const SizedBox(height: 38),

        // Download buttons 
        FadeUpIn(
          delay: const Duration(milliseconds: 280),
          child: DownloadButtons(viewModel: vm, isMobile: isMobile),
        ),
      ],
    );
  }
}

// Right visual: icon orb + floating stat cards 

class _HeroVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decorative ring
          Center(
            child: Container(
              width: 280, height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: kBrand.withOpacity(.08), width: 1,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 210, height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kBrandWarm,
                border: Border.all(color: kBrand.withOpacity(.12), width: 1),
              ),
            ),
          ),

          // App icon
          const Center(child: SparcheIcon(size: 110)),

          // App Store subtitle ribbon
          Positioned(
            top: 16, left: 0, right: 0,
            child: FadeUpIn(
              delay: const Duration(milliseconds: 400),
              child: Center(
                child: WarmCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  borderRadius: 50,
                  bgColor: kBgWhite,
                  child: Text(
                    'All-in-one day-to-day wallet',
                    style: TextStyle(
                      fontFamily: 'DMSans', fontSize: 12,
                      fontWeight: FontWeight.w600, color: kTxtMuted,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Floating stat — loyalty card
          Positioned(
            top: 60, right: 0,
            child: FadeUpIn(
              delay: const Duration(milliseconds: 500),
              child: _FloatCard(
                emoji: '🃏',
                label: 'Loyalty Cards',
                value: '12 saved',
                accent: kAccentViolet,
              ),
            ),
          ),

          // Floating stat — spending
          Positioned(
            bottom: 80, left: 0,
            child: FadeUpIn(
              delay: const Duration(milliseconds: 620),
              child: _FloatCard(
                emoji: '💸',
                label: 'This month',
                value: 'R 3,240',
                accent: kAccentTeal,
              ),
            ),
          ),

          // Floating stat — list progress
          Positioned(
            bottom: 24, right: 4,
            child: FadeUpIn(
              delay: const Duration(milliseconds: 740),
              child: _FloatCard(
                emoji: '✅',
                label: 'Shopping list',
                value: '8 / 11 done',
                accent: kAccentAmber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Floating stat card with gentle float animation 

class _FloatCard extends StatefulWidget {
  final String emoji, label, value;
  final Color accent;
  const _FloatCard({
    required this.emoji, required this.label,
    required this.value, required this.accent,
  });
  @override
  State<_FloatCard> createState() => _FloatCardState();
}

class _FloatCardState extends State<_FloatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _y;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
    _y = Tween<double>(begin: 0, end: -9)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _y,
    builder: (_, child) => Transform.translate(
      offset: Offset(0, _y.value),
      child: child,
    ),
    child: WarmCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      borderRadius: 16,
      borderColor: widget.accent.withOpacity(.2),
      shadowColor: widget.accent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: widget.accent.withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(widget.emoji,
                  style: const TextStyle(fontSize: 17)),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.label, style: TextStyle(
                fontFamily: 'DMSans', fontSize: 10,
                fontWeight: FontWeight.w500, color: kTxtMuted,
              )),
              Text(widget.value, style: TextStyle(
                fontFamily: 'DMSans', fontSize: 15,
                fontWeight: FontWeight.w700, color: widget.accent,
                letterSpacing: -.2,
              )),
            ],
          ),
        ],
      ),
    ),
  );
}