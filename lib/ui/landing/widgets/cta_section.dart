import 'package:flutter/material.dart';
import 'package:sparche_web/core/colors.dart';
import 'package:stacked/stacked.dart';
import '../landing_viewmodel.dart';
import 'download_buttons.dart';
import 'shared_widgets.dart';

/// CTA section — warm violet gradient background, serif headline,
/// star rating, both store download buttons.
class CtaSection extends ViewModelWidget<LandingViewModel> {
  const CtaSection({super.key});

  @override
  Widget build(BuildContext context, LandingViewModel vm) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7B3AF5), // warmer violet
            Color(0xFF5010CC), // deeper
            Color(0xFF6120E2), // brand
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isMobile ? 28 : 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: FadeUpIn(
            child: Column(children: [

              // Icon
              SparcheIcon(size: 70),
              const SizedBox(height: 20),

              // Wordmark
              Text('Sparche', style: const TextStyle(
                fontFamily: 'DMSerifDisplay',
                fontSize: 22, fontWeight: FontWeight.w400,
                color: Colors.white, letterSpacing: -.3,
              )),

              const SizedBox(height: 12),

              // Stars + stats
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ...List.generate(5, (_) => Icon(
                  Icons.star_rounded, color: kStar.withOpacity(.9), size: 20,
                )),
                const SizedBox(width: 8),
                Text(
                  '300+ downloads  ·  Ages 16+',
                  style: TextStyle(
                    fontFamily: 'DMSans', fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(.6),
                  ),
                ),
              ]),

              const SizedBox(height: 36),

              // Serif headline
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'DMSerifDisplay',
                    fontSize: isMobile ? 44 : 58,
                    fontWeight: FontWeight.w400,
                    height: 1.06,
                    letterSpacing: -1.5,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(text: 'Say '),
                    TextSpan(
                      text: 'Goodbye',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: ' to a bulky wallet.\n'),
                    TextSpan(
                      text: 'Hello',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: ' to a streamlined digital experience.'),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Text(
                'Download Sparche. Loyalty cards, budgetting, '
                'shopping lists, and expenses — beautifully organised in '
                'one pocket-sized app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 16, fontWeight: FontWeight.w400,
                  height: 1.7,
                  color: Colors.white.withOpacity(.65),
                ),
              ),

              const SizedBox(height: 44),

              DownloadButtons(viewModel: vm, isMobile: isMobile),

              // iOS note
              const SizedBox(height: 20),
            ]),
          ),
        ),
      ),
    );
  }
}