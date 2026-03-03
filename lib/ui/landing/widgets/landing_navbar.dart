import 'package:flutter/material.dart';
import 'package:sparche_web/core/colors.dart';
import 'package:stacked/stacked.dart';
import '../landing_viewmodel.dart';
import 'shared_widgets.dart';

/// Top navigation bar — ivory background, serif wordmark,
/// light border bottom, violet CTA pill.
class LandingNavbar extends ViewModelWidget<LandingViewModel> {
  const LandingNavbar({super.key});

  @override
  Widget build(BuildContext context, LandingViewModel vm) {
    final isMobile = MediaQuery.of(context).size.width < 760;

    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: kBgCream.withOpacity(.95),
        border: const Border(
          bottom: BorderSide(color: kDivider, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: kBrand.withOpacity(.04),
            blurRadius: 24,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 52),
        child: Row(
          children: [
            _NavLogo(),
            const Spacer(),
            if (!isMobile) ...[
              _NavItem('Features',    onTap: () => vm.scrollTo(vm.featuresKey)),
              _NavItem('Screenshots', onTap: () => vm.scrollTo(vm.screenshotsKey)),
              _NavItem('About',       onTap: () => vm.scrollTo(vm.aboutKey)),
              const SizedBox(width: 20),
            ],
            // CTA — detects platform and opens the right store
            _NavCta(onTap: vm.openStore),
          ],
        ),
      ),
    );
  }
}

class _NavLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    children: [
      SparcheIcon(size: 32, shadow: false),
      const SizedBox(width: 10),
      RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Sparche',
              style: TextStyle(
                fontFamily: 'DMSerifDisplay',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: kTxtInk,
                letterSpacing: -.3,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  const _NavItem(this.label, {this.onTap});
  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit:  (_) => setState(() => _hovered = false),
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _hovered ? kBrand : kTxtMuted,
          ),
          child: Text(widget.label),
        ),
      ),
    ),
  );
}

class _NavCta extends StatefulWidget {
  final VoidCallback onTap;
  const _NavCta({required this.onTap});
  @override
  State<_NavCta> createState() => _NavCtaState();
}

class _NavCtaState extends State<_NavCta> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit:  (_) => setState(() => _hovered = false),
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
          color: _hovered ? kBrandDark : kBrand,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: kBrand.withOpacity(_hovered ? .38 : .2),
              blurRadius: _hovered ? 20 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Text(
          'Get the App',
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}