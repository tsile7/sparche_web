import 'package:flutter/material.dart';
import 'package:sparche_web/core/colors.dart';


/// Warm white card with soft coloured shadow and rounded corners.
class WarmCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double borderRadius;
  final Color? bgColor;
  final Color? borderColor;
  final Color? shadowColor;

  const WarmCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20,
    this.bgColor,
    this.borderColor,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgColor ?? kBgWhite,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? kBorderSoft,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: (shadowColor ?? kBrand).withOpacity(.06),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Animated pulsing status dot — warm green for "live / available" states.
class LiveDot extends StatefulWidget {
  final Color color;
  final double size;
  const LiveDot({super.key, this.color = kSuccess, this.size = 8});

  @override
  State<LiveDot> createState() => _LiveDotState();
}

class _LiveDotState extends State<LiveDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 0.85, end: 1.15)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (_, __) => Transform.scale(
        scale: _scale.value,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(.45),
                blurRadius: widget.size,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small overline label — uppercase, letter-spaced, brand violet.
class SectionTag extends StatelessWidget {
  final String text;
  final Color? color;
  const SectionTag(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: kBrandPastel,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: kBrand.withOpacity(.18)),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontFamily: 'DMSans',
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.2,
          color: color ?? kBrand,
        ),
      ),
    );
  }
}

/// Serif display heading — uses DM Serif Display.
class SerifHeading extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign align;
  final Color? color;

  const SerifHeading(
    this.text, {
    super.key,
    this.fontSize = 40,
    this.align = TextAlign.left,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontFamily: 'DMSerifDisplay',
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        letterSpacing: fontSize > 36 ? -1.2 : -.5,
        height: 1.08,
        color: color ?? kTxtInk,
      ),
    );
  }
}

/// Thin warm-tinted horizontal divider.
class WarmDivider extends StatelessWidget {
  const WarmDivider({super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: 1,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.transparent, kDivider, kBorderWarm, kDivider, Colors.transparent],
      ),
    ),
  );
}

/// Staggered fade-up entrance animation.
class FadeUpIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;

  const FadeUpIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 550),
  });

  @override
  State<FadeUpIn> createState() => _FadeUpInState();
}

class _FadeUpInState extends State<FadeUpIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut)
        .drive(Tween(begin: 0.0, end: 1.0));
    _slide = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut)
        .drive(Tween(begin: const Offset(0, .05), end: Offset.zero));
    Future.delayed(widget.delay, () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _opacity,
    child: SlideTransition(position: _slide, child: widget.child),
  );
}

/// Sparche app icon 
class SparcheIcon extends StatelessWidget {
  final double size;
  final bool shadow;

  const SparcheIcon({super.key, this.size = 48, this.shadow = true});

  @override
  Widget build(BuildContext context) {
    final r = size * 0.24;
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(r),
      child: Image.asset(
        'assets/images/sparche_logo.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
        // Fallback to gradient icon if asset not found
        errorBuilder: (_, __, ___) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF8B52F5), Color(0xFF6120E2)],
            ),
            borderRadius: BorderRadius.circular(r),
          ),
          child: Center(
            child: Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
              size: size * 0.50,
            ),
          ),
        ),
      ),
    );

    if (!shadow) return image;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(r),
        boxShadow: [
          BoxShadow(
            color: kBrand.withOpacity(.28),
            blurRadius: size * .55,
            offset: Offset(0, size * .12),
            spreadRadius: -size * .04,
          ),
        ],
      ),
      child: image,
    );
  }
}

/// Pastel feature accent chip — rounded, coloured bg.
class AccentChip extends StatelessWidget {
  final String label;
  final Color accent;

  const AccentChip(this.label, {super.key, required this.accent});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
    decoration: BoxDecoration(
      color: accent.withOpacity(.1),
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: accent.withOpacity(.22)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'DMSans',
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: accent.withOpacity(.9),
      ),
    ),
  );
}