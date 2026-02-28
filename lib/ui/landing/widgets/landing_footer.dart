import 'package:flutter/material.dart';
import 'package:sparche_web/core/colors.dart';
import 'package:stacked/stacked.dart';

import '../landing_viewmodel.dart';
import 'shared_widgets.dart';

/// Footer — warm cream bg, serif wordmark, warm dividers, hover-violet links.
class LandingFooter extends ViewModelWidget<LandingViewModel> {
  const LandingFooter({super.key});

  @override
  Widget build(BuildContext context, LandingViewModel vm) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      color: kBgSand,
      padding: EdgeInsets.symmetric(
        vertical: 44,
        horizontal: isMobile ? 24 : 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(children: [
            const WarmDivider(),
            const SizedBox(height: 36),
            isMobile ? _MobileFooter(vm: vm) : _DesktopFooter(vm: vm),
            const SizedBox(height: 32),
            const WarmDivider(),
            const SizedBox(height: 20),
            Text(
              '© 2026 Philoxenic. All Rights Reserved.  ·  Pretoria, South Africa  ·  +27 76 056 6738',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'DMSans', fontSize: 12,
                fontWeight: FontWeight.w400, color: kTxtFaint, height: 1.6,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _DesktopFooter extends StatelessWidget {
  final LandingViewModel vm;
  const _DesktopFooter({required this.vm});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Logo
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          SparcheIcon(size: 28, shadow: false),
          const SizedBox(width: 8),
          Text('Sparche', style: const TextStyle(
            fontFamily: 'DMSerifDisplay', fontSize: 18,
            fontWeight: FontWeight.w400, color: kTxtInk,
          )),
        ]),
        const SizedBox(height: 6),
        Text('All-in-one day-to-day wallet', style: TextStyle(
          fontFamily: 'DMSans', fontSize: 12,
          fontWeight: FontWeight.w400, color: kTxtMuted,
        )),
      ]),

      const Spacer(),

      Wrap(spacing: 24, children: [
        _FLink('Google Play',           vm.openPlayStore),
        _FLink('App Store',             vm.openAppStore),
        _FLink('Privacy Policy',        vm.openPrivacyPolicy),
      ]),
    ],
  );
}

class _MobileFooter extends StatelessWidget {
  final LandingViewModel vm;
  const _MobileFooter({required this.vm});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        SparcheIcon(size: 26, shadow: false),
        const SizedBox(width: 8),
        Text('Sparche', style: const TextStyle(
          fontFamily: 'DMSerifDisplay', fontSize: 17,
          fontWeight: FontWeight.w400, color: kTxtInk,
        )),
      ]),
      const SizedBox(height: 22),
      Wrap(spacing: 20, runSpacing: 14, children: [
        _FLink('Google Play',         vm.openPlayStore),
        _FLink('App Store',           vm.openAppStore),
        _FLink('Privacy Policy',      vm.openPrivacyPolicy),
      ]),
    ],
  );
}

class _FLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _FLink(this.label, this.onTap);
  @override
  State<_FLink> createState() => _FLinkState();
}

class _FLinkState extends State<_FLink> {
  bool _h = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _h = true),
    onExit:  (_) => setState(() => _h = false),
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 150),
        style: TextStyle(
          fontFamily: 'DMSans', fontSize: 13,
          fontWeight: FontWeight.w500,
          color: _h ? kBrand : kTxtMuted,
        ),
        child: Text(widget.label),
      ),
    ),
  );
}