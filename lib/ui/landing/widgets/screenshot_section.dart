import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sparche_web/core/colors.dart';
import 'package:stacked/stacked.dart';

import '../landing_viewmodel.dart';
import 'shared_widgets.dart';

/// Screenshot strip — cream background, real Play Store images,
/// warm card borders, hover-lift with violet accent.
class ScreenshotsSection extends ViewModelWidget<LandingViewModel> {
  const ScreenshotsSection({super.key});

  @override
  Widget build(BuildContext context, LandingViewModel vm) {
    return Container(
      color: kBgCream,
      padding: const EdgeInsets.symmetric(vertical: 88),
      child: Column(children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: FadeUpIn(child: Column(children: [
            SectionTag('App Screenshots'),
            const SizedBox(height: 16),
            SerifHeading(
              'See Sparche in action.',
              fontSize: 38,
              align: TextAlign.center,
            ),
            const SizedBox(height: 10),
          ])),
        ),

        const SizedBox(height: 52),

        _ScreenshotStrip(items: vm.screenshots),
      ]),
    );
  }
}

class _ScreenshotStrip extends StatefulWidget {
  final List<AppScreenshot> items;
  const _ScreenshotStrip({required this.items});
  @override
  State<_ScreenshotStrip> createState() => _ScreenshotStripState();
}

class _ScreenshotStripState extends State<_ScreenshotStrip> {
  late final ScrollController _ctrl;
  Timer? _timer;
  bool _paused = false;

  @override
  void initState() {
    super.initState();
    _ctrl = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
        if (_paused || !_ctrl.hasClients) return;
        final max = _ctrl.position.maxScrollExtent;
        _ctrl.offset >= max
            ? _ctrl.jumpTo(0)
            : _ctrl.jumpTo(_ctrl.offset + 1.0);
      });
    });
  }

  @override
  void dispose() { _timer?.cancel(); _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _paused = true),
    onExit:  (_) => setState(() => _paused = false),
    child: SingleChildScrollView(
      controller: _ctrl,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: widget.items
            .map((s) => _SSCard(url: s.url, caption: s.caption))
            .toList(),
      ),
    ),
  );
}

class _SSCard extends StatefulWidget {
  final String url, caption;
  const _SSCard({required this.url, required this.caption});
  @override
  State<_SSCard> createState() => _SSCardState();
}

class _SSCardState extends State<_SSCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit:  (_) => setState(() => _hovered = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 20),
      transform: Matrix4.translationValues(0, _hovered ? -10 : 0, 0),
      width: 240,
      decoration: BoxDecoration(
        color: kBgWhite,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: _hovered ? kBrand.withOpacity(.45) : kBorderSoft,
          width: _hovered ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: (_hovered ? kBrand : Colors.black).withOpacity(_hovered ? .14 : .06),
            blurRadius: _hovered ? 36 : 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            widget.url,
            fit: BoxFit.cover,
            loadingBuilder: (_, child, prog) {
              if (prog == null) return child;
              return Container(
                height: 135, color: kBrandWarm,
                child: Center(child: CircularProgressIndicator(
                  value: prog.expectedTotalBytes != null
                      ? prog.cumulativeBytesLoaded / prog.expectedTotalBytes!
                      : null,
                  color: kBrand, strokeWidth: 2,
                )),
              );
            },
            errorBuilder: (_, __, ___) => Container(
              height: 135, color: kBrandWarm,
              child: const Icon(Icons.image_outlined, color: kBrand, size: 36),
            ),
          ),
          Container(
            width: double.infinity,
            color: kBgWhite,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            child: Text(widget.caption, style: TextStyle(
              fontFamily: 'DMSans', fontSize: 13, fontWeight: FontWeight.w600,
              color: _hovered ? kBrand : kTxtBody,
            )),
          ),
        ],
      ),
    ),
  );
}