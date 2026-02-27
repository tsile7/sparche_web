import 'package:flutter/material.dart';
import 'package:sparche_web/core/colors.dart';
import '../landing_viewmodel.dart';

class DownloadButtons extends StatelessWidget {
  final LandingViewModel viewModel;
  final bool isMobile;

  const DownloadButtons({
    super.key,
    required this.viewModel,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: [
        _StoreButton(
          onTap: viewModel.openPlayStore,
          bgColor: kBrand,
          shadowColor: kBrand,
          iconData: Icons.play_arrow_rounded,
          iconColor: Colors.white,
          topLabel: 'GET IT ON',
          storeName: 'Google Play',
          textColor: Colors.white,
        ),
        _StoreButton(
          onTap: viewModel.openAppStore,
          bgColor: kTxtInk,
          shadowColor: kTxtInk,
          iconData: Icons.apple_rounded,
          iconColor: Colors.white,
          topLabel: 'DOWNLOAD ON THE',
          storeName: 'App Store',
          textColor: Colors.white,
        ),
      ],
    );
  }
}

class _StoreButton extends StatefulWidget {
  final VoidCallback onTap;
  final Color bgColor;
  final Color shadowColor;
  final IconData iconData;
  final Color iconColor;
  final String topLabel;
  final String storeName;
  final Color textColor;

  const _StoreButton({
    required this.onTap,
    required this.bgColor,
    required this.shadowColor,
    required this.iconData,
    required this.iconColor,
    required this.topLabel,
    required this.storeName,
    required this.textColor,
  });

  @override
  State<_StoreButton> createState() => _StoreButtonState();
}

class _StoreButtonState extends State<_StoreButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: widget.shadowColor.withOpacity(_hovered ? .35 : .18),
                blurRadius: _hovered ? 28 : 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.iconData, color: widget.iconColor, size: 26),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.topLabel,
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: .4,
                      color: widget.textColor.withOpacity(.6),
                    ),
                  ),
                  Text(
                    widget.storeName,
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: widget.textColor,
                      height: 1.2,
                      letterSpacing: -.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}