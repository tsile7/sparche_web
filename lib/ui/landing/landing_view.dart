import 'package:flutter/material.dart';
import 'package:sparche_web/core/colors.dart';
import 'package:stacked/stacked.dart';
import 'landing_viewmodel.dart';
import 'widgets/hero_section.dart';
import 'widgets/about_section.dart';
import 'widgets/screenshot_section.dart';
import 'widgets/features_section.dart';
import 'widgets/why_section.dart';
import 'widgets/cta_section.dart';
import 'widgets/landing_footer.dart';
import 'widgets/landing_navbar.dart';
import 'widgets/shared_widgets.dart';


class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LandingViewModel>.reactive(
      viewModelBuilder: () => LandingViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: kBgCream,
        body: Stack(
          children: [
            // Scrollable page content 
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 68), // clearance for fixed navbar

                  HeroSection(),
                  const WarmDivider(),

                  AboutSection(),
                  const WarmDivider(),

                  ScreenshotsSection(),
                  const WarmDivider(),

                  FeaturesSection(),
                  const WarmDivider(),

                  WhySection(),
                  const WarmDivider(),

                  CtaSection(),

                  LandingFooter(),
                ],
              ),
            ),

            // Fixed top navbar 
            const Positioned(
              top: 0, left: 0, right: 0,
              child: LandingNavbar(),
            ),
          ],
        ),
      ),
    );
  }
}