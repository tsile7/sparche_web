import 'package:flutter/material.dart';
import 'package:sparche_web/core/colors.dart';
import 'package:stacked/stacked.dart';
import '../landing_viewmodel.dart';
import 'shared_widgets.dart';


class AboutSection extends ViewModelWidget<LandingViewModel> {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context, LandingViewModel vm) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 900;

    return Container(
      color: kBgSand,
      padding: EdgeInsets.symmetric(
        vertical: 90,
        horizontal: isMobile ? 24 : 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? _MobileAbout(vm: vm)
              : _DesktopAbout(vm: vm),
        ),
      ),
    );
  }
}

class _DesktopAbout extends StatelessWidget {
  final LandingViewModel vm;
  const _DesktopAbout({required this.vm});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(flex: 6, child: Padding(
        padding: const EdgeInsets.only(right: 60),
        child: _AboutCopy(vm: vm),
      )),
      Expanded(flex: 5, child: _InfoColumn(vm: vm)),
    ],
  );
}

class _MobileAbout extends StatelessWidget {
  final LandingViewModel vm;
  const _MobileAbout({required this.vm});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _AboutCopy(vm: vm),
      const SizedBox(height: 48),
      _InfoColumn(vm: vm),
    ],
  );
}

// Left: description text 

class _AboutCopy extends StatelessWidget {
  final LandingViewModel vm;
  const _AboutCopy({required this.vm});

  @override
  Widget build(BuildContext context) {
    return FadeUpIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo + wordmark
          Row(children: [
            SparcheIcon(size: 58),
            const SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Sparche', style: const TextStyle(
                fontFamily: 'DMSerifDisplay', fontSize: 28,
                fontWeight: FontWeight.w400, color: kTxtInk, letterSpacing: -.3,
              )),
              Text('All-in-one day-to-day wallet', style: const TextStyle(
                fontFamily: 'DMSans', fontSize: 13,
                fontWeight: FontWeight.w500, color: kTxtMuted,
              )),
            ]),
          ]),

          const SizedBox(height: 36),

          SectionTag('About This App'),
          const SizedBox(height: 18),

          SerifHeading(
            'Take control of your\nshopping & spending.',
            fontSize: 36,
          ),

          const SizedBox(height: 22),

          // Exact App Store / Play Store description 
          Text(
            'Take control of your shopping and spending with Sparche — '
            'your all-in-one shopping and budgeting companion! '
            'Keep all your loyalty cards in one place, track your expenses '
            'effortlessly, and manage your shopping with a built-in list '
            'and calculator. Simplify your shopping, maximize your rewards, '
            'and take control of your spending — right from your phone.',
            style: const TextStyle(
              fontFamily: 'DMSans', fontSize: 15,
              fontWeight: FontWeight.w400, height: 1.8, color: kTxtBody,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            'Whether you\'re grocery shopping, planning big purchases, or '
            'tracking everyday spending, Sparche makes every trip simpler, '
            'faster, and more rewarding.',
            style: const TextStyle(
              fontFamily: 'DMSans', fontSize: 15,
              fontWeight: FontWeight.w400, height: 1.8, color: kTxtBody,
            ),
          ),

          const SizedBox(height: 32),

          // Version history timeline 
          Text('VERSION HISTORY', style: TextStyle(
            fontFamily: 'DMSans', fontSize: 10, fontWeight: FontWeight.w700,
            letterSpacing: 2.5, color: kBrand,
          )),
          const SizedBox(height: 16),
          ...vm.versionHistory.map((v) => _VersionRow(entry: v)),
        ],
      ),
    );
  }
}

class _VersionRow extends StatelessWidget {
  final VersionEntry entry;
  const _VersionRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot + line
          Column(children: [
            Container(
              width: 10, height: 10,
              decoration: BoxDecoration(
                color: kBrand, shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: kBrand.withOpacity(.3), blurRadius: 6)],
              ),
            ),
            Container(width: 1, height: 40, color: kBorderSoft),
          ]),
          const SizedBox(width: 16),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text('v${entry.version}', style: const TextStyle(
                  fontFamily: 'DMSans', fontSize: 13, fontWeight: FontWeight.w700, color: kTxtInk,
                )),
                const SizedBox(width: 8),
                Text(entry.date, style: TextStyle(
                  fontFamily: 'DMSans', fontSize: 12, fontWeight: FontWeight.w400, color: kTxtMuted,
                )),
              ]),
              const SizedBox(height: 4),
              Text(entry.notes, style: const TextStyle(
                fontFamily: 'DMSans', fontSize: 13, fontWeight: FontWeight.w400,
                color: kTxtBody, height: 1.6,
              )),
            ],
          )),
        ],
      ),
    );
  }
}

// Right: info + metadata cards 

class _InfoColumn extends StatelessWidget {
  final LandingViewModel vm;
  const _InfoColumn({required this.vm});

  @override
  Widget build(BuildContext context) {
    return FadeUpIn(
      delay: const Duration(milliseconds: 120),
      child: Column(
        children: [
          // Data safety card
          WarmCard(
            borderRadius: 22,
            bgColor: kBgMint,
            borderColor: kAccentTeal.withOpacity(.2),
            shadowColor: kAccentTeal,
            padding: const EdgeInsets.all(24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Text('🛡️', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Text('Data Safety', style: const TextStyle(
                  fontFamily: 'DMSans', fontSize: 13, fontWeight: FontWeight.w700, color: kTxtInk,
                )),
              ]),
              const SizedBox(height: 12),
              ...[
                'No data linked to your identity',
                'All expenses stay on-device',
                'Encrypted in transit',
                'Request data deletion anytime',
              ].map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(children: [
                  Container(
                    width: 18, height: 18,
                    decoration: BoxDecoration(
                      color: kAccentTeal.withOpacity(.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, size: 11, color: kAccentTeal),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(s, style: const TextStyle(
                    fontFamily: 'DMSans', fontSize: 13,
                    fontWeight: FontWeight.w500, color: kTxtBody,
                  ))),
                ]),
              )),
            ]),
          ),
        ],
      ),
    );
  }
}