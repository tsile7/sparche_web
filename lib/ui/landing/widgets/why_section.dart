import 'package:flutter/material.dart';
import 'package:sparche_web/core/colors.dart';
import 'package:stacked/stacked.dart';
import '../landing_viewmodel.dart';
import 'shared_widgets.dart';

/// Why You'll Love It — cream bg, 4 cards each with unique pastel accent.
class WhySection extends ViewModelWidget<LandingViewModel> {
  const WhySection({super.key});

  static const _accents = [kAccentViolet, kAccentTeal, kAccentCoral, kAccentAmber];

  @override
  Widget build(BuildContext context, LandingViewModel vm) {
    final w          = MediaQuery.of(context).size.width;
    final isMobile   = w < 700;
    final crossCount = w > 900 ? 4 : (w > 560 ? 2 : 1);

    return Container(
      color: kBgCream,
      padding: EdgeInsets.symmetric(
        vertical: 90,
        horizontal: isMobile ? 24 : 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(children: [
            FadeUpIn(child: Column(children: [
              SectionTag("Why You'll Love It"),
              const SizedBox(height: 16),
              SerifHeading(
                'Designed for real\nshopping, real savings.',
                fontSize: 38,
                align: TextAlign.center,
              ),
            ])),

            const SizedBox(height: 52),

            GridView.count(
              crossAxisCount: crossCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.05,
              children: List.generate(
                vm.whyItems.length,
                (i) => FadeUpIn(
                  delay: Duration(milliseconds: i * 70),
                  child: _WhyCard(
                    emoji:  vm.whyItems[i].emoji,
                    title:  vm.whyItems[i].title,
                    body:   vm.whyItems[i].body,
                    accent: _accents[i % _accents.length],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _WhyCard extends StatefulWidget {
  final String emoji, title, body;
  final Color accent;
  const _WhyCard({
    required this.emoji, required this.title,
    required this.body, required this.accent,
  });
  @override
  State<_WhyCard> createState() => _WhyCardState();
}

class _WhyCardState extends State<_WhyCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit:  (_) => setState(() => _hovered = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _hovered
            ? widget.accent.withOpacity(.05)
            : kBgWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _hovered
              ? widget.accent.withOpacity(.3)
              : kBorderSoft,
        ),
        boxShadow: [BoxShadow(
          color: (_hovered ? widget.accent : Colors.black)
              .withOpacity(_hovered ? .1 : .04),
          blurRadius: _hovered ? 28 : 10,
          offset: const Offset(0, 5),
        )],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Emoji with accent bg
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: widget.accent.withOpacity(_hovered ? .14 : .08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text(widget.emoji,
                style: const TextStyle(fontSize: 20))),
          ),
          const SizedBox(height: 14),
          Text(widget.title, style: TextStyle(
            fontFamily: 'DMSans', fontSize: 15,
            fontWeight: FontWeight.w700,
            color: _hovered ? widget.accent : kTxtInk,
            letterSpacing: -.1,
          )),
          const SizedBox(height: 8),
          Expanded(child: Text(widget.body, style: const TextStyle(
            fontFamily: 'DMSans', fontSize: 13,
            fontWeight: FontWeight.w400, color: kTxtBody, height: 1.6,
          ), overflow: TextOverflow.fade)),
        ],
      ),
    ),
  );
}