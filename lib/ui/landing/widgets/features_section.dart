import 'package:flutter/material.dart';
import 'package:sparche_web/core/colors.dart';
import 'package:stacked/stacked.dart';
import '../landing_viewmodel.dart';
import 'shared_widgets.dart';

class FeaturesSection extends ViewModelWidget<LandingViewModel> {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context, LandingViewModel vm) {
    final w          = MediaQuery.of(context).size.width;
    final isMobile   = w < 700;
    final crossCount = w > 960 ? 3 : (w > 580 ? 2 : 1);

    return Container(
      color: kBgLavender,
      padding: EdgeInsets.symmetric(
        vertical: 90,
        horizontal: isMobile ? 24 : 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(children: [
            FadeUpIn(child: Column(children: [
              SectionTag('Key Features'),
              const SizedBox(height: 16),
              SerifHeading(
                'Everything for smarter\nshopping.',
                fontSize: 40,
                align: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'One app. Three powerful tools. Zero friction.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'DMSans', fontSize: 15,
                  fontWeight: FontWeight.w400, color: kTxtMuted,
                ),
              ),
            ])),

            const SizedBox(height: 56),

            GridView.count(
              crossAxisCount: crossCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.18,
              children: List.generate(
                vm.features.length,
                (i) => FadeUpIn(
                  delay: Duration(milliseconds: i * 70),
                  child: _FeatureCard(
                    emoji:  vm.features[i].emoji,
                    title:  vm.features[i].title,
                    body:   vm.features[i].body,
                    accent: vm.features[i].accent,
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

class _FeatureCard extends StatefulWidget {
  final String emoji, title, body;
  final Color accent;
  const _FeatureCard({
    required this.emoji, required this.title,
    required this.body, required this.accent,
  });
  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: _hovered
              ? widget.accent.withOpacity(.04)
              : kBgWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? widget.accent.withOpacity(.35)
                : kBorderSoft,
          ),
          boxShadow: [
            BoxShadow(
              color: (_hovered ? widget.accent : Colors.black)
                  .withOpacity(_hovered ? .1 : .04),
              blurRadius: _hovered ? 32 : 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Accent icon box
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 48, height: 48,
              decoration: BoxDecoration(
                color: widget.accent.withOpacity(_hovered ? .16 : .1),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: widget.accent.withOpacity(.25),
                ),
              ),
              child: Center(
                child: Text(widget.emoji,
                    style: const TextStyle(fontSize: 21)),
              ),
            ),
            const SizedBox(height: 16),
            Text(widget.title, style: TextStyle(
              fontFamily: 'DMSans', fontSize: 15,
              fontWeight: FontWeight.w700, color: kTxtInk, letterSpacing: -.1,
            )),
            const SizedBox(height: 8),
            Expanded(child: Text(widget.body, style: const TextStyle(
              fontFamily: 'DMSans', fontSize: 13,
              fontWeight: FontWeight.w400, color: kTxtBody, height: 1.65,
            ), overflow: TextOverflow.fade)),
          ],
        ),
      ),
    );
  }
}