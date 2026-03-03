import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

/// Data sourced from both Google Play and the Apple App Store listing.
class LandingViewModel extends BaseViewModel {

  // Store URLs 
  final Uri playStore = Uri.parse(
    'https://play.google.com/store/apps/details?id=com.philoxenic.sparche',
  );

  /// Correct Apple App Store URL (id6741689377, US listing).
  final Uri appStore = Uri.parse(
    'https://apps.apple.com/us/app/sparche/id6741689377',
  );

  // Support / info URLs 
  final Uri websiteUrl = Uri.parse('https://www.sparche.app');
  final Uri privacyUrl = Uri.parse('https://www.sparche.app/privacy-policy');

  // GlobalKeys for navbar scroll-to-section navigation 
  // Assigned to section Container widgets in landing_view.dart via `key:`.
  final GlobalKey featuresKey    = GlobalKey();
  final GlobalKey screenshotsKey = GlobalKey();
  final GlobalKey aboutKey       = GlobalKey();

  /// Smooth-scrolls to the widget identified by [key].
  void scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  /// "Get the App" — opens the correct store for the current device.
  ///   iOS / macOS  →  Apple App Store
  ///   Android      →  Google Play
  ///   Web / other  →  Google Play (safe default; explicit buttons remain)
  Future<void> openStore() {
    if (!kIsWeb) {
      if (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS) {
        return openAppStore();
      }
      if (defaultTargetPlatform == TargetPlatform.android) {
        return openPlayStore();
      }
    }
    return openPlayStore();
  }

  // Play Store CDN screenshots 
  final List<AppScreenshot> screenshots = const [
    AppScreenshot(
      url: 'https://play-lh.googleusercontent.com/ZgTG2XtL9F9Qtanigd_lJ2_pBzy4uvj8m9YtPM79M24ixYy3WGP4xPtvwPxyNnE3V_mESgcXh83qXh1SvZTJ=w526-h296',
      caption: '🃏 Loyalty Cards',
    ),
    AppScreenshot(
      url: 'https://play-lh.googleusercontent.com/ZnVBByqrhUE71Gec4qGPQelMPbVZMOJQA0-UB6wsFoYFOZFu44ChbZDo9zWs2hLS8OzsLRRCQg7gd78485EpVA=w526-h296',
      caption: '💸 Expense Tracker',
    ),
    AppScreenshot(
      url: 'https://play-lh.googleusercontent.com/R1fl6_-SVUjv4yebVMA4dCt37rkCQzPL1opbtSQ3dxnmXpLwbwAoARU4gUz8hw4X2cPv6FNeqIHP8h9065A5bg=w526-h296',
      caption: '🛒 Shopping List',
    ),
    AppScreenshot(
      url: 'https://play-lh.googleusercontent.com/MrlFzX86ohoHcfK0aC8m392QZJMvhjTI0tdgfs7uMhgCHPKStDKxUntWLOvurl1FT0CBZ8QKi_ElmPWu_YdwnK4=w526-h296',
      caption: '📊 Budget Overview',
    ),
    AppScreenshot(
      url: 'https://play-lh.googleusercontent.com/mwJszHVu14M54jwZpRmdhccp8i8caGO2YHYRT9TGaN0PHlh6PYlMF-xfAqL2bEkXyhyjRJDZXh1DRBMGNsFgrg=w526-h296',
      caption: '🧮 Smart Calculator',
    ),
  ];
 
  final List<AppFeature> features = const [
    AppFeature(
      emoji: '🃏',
      title: 'Digital Loyalty Cards',
      body: 'Store every rewards card in one place. Never miss points or perks at checkout again.',
      accentHex: 0xFF6120E2,
    ),
    AppFeature(
      emoji: '📷',
      title: 'Barcode Receipt Scanning',
      body: 'Scan receipts with your camera to log purchases faster and more accurately.',
      accentHex: 0xFFFF6B6B,
    ),
    AppFeature(
      emoji: '💸',
      title: 'Expense Tracker',
      body: 'Log purchases instantly. All data stays on your device — no cloud, no servers.',
      accentHex: 0xFF00C9A7,
    ),
    AppFeature(
      emoji: '🛒',
      title: 'Smart Shopping List',
      body: 'Plan trips, share with family, check off items and total your cart without leaving the app.',
      accentHex: 0xFFFFB830,
    ),
    AppFeature(
      emoji: '🧮',
      title: 'Built-in Calculator',
      body: 'Know your running total as you shop. No surprises when you reach the till.',
      accentHex: 0xFF3B9EFF,
    ),
    AppFeature(
      emoji: '👨‍👩‍👧',
      title: 'Family Sharing',
      body: 'Share shopping lists and budgets with family or roommates effortlessly.',
      accentHex: 0xFFE040FB,
    ),
  ];

  // Why you'll love it 
  final List<WhyItem> whyItems = const [
    WhyItem(emoji: '⚡', title: 'Save Time',
      body: 'Everything for a shopping trip in one place. No more app-juggling.'),
    WhyItem(emoji: '🗂️', title: 'Stay Organised',
      body: 'Shopping, spending, and rewards — all unified and always at hand.'),
    WhyItem(emoji: '🧠', title: 'Shop Smarter',
      body: 'Know your running total before you reach the till. Every single time.'),
    WhyItem(emoji: '👨‍👩‍👧', title: 'Family-Friendly',
      body: 'Share lists and budgets with the whole household effortlessly.'),
  ];

  // App Store version history (from Apple listing) 
  final List<VersionEntry> versionHistory = const [
    VersionEntry(
      version: '1.2.8',
      date: 'Feb 19, 2026',
      notes: 'Barcode Receipt Scanning Added: Quickly scan receipts.\n'
             'Expense Tracking: Log purchases faster and more efficiently.\n'
             'Improved UI & Functionality: Cleaner, smoother experience.\n'
             'Bug Fixes & Performance Enhancements.',
    ),
    VersionEntry(version: '1.1.3', date: 'Jan 13, 2026', notes: 'Bug fix'),
    VersionEntry(version: '1.0',   date: 'Jan 10, 2026', notes: 'Initial release'),
  ];

  // Actions 
  Future<void> openPlayStore()     => launchUrl(playStore,    mode: LaunchMode.externalApplication);
  Future<void> openAppStore()      => launchUrl(appStore,     mode: LaunchMode.externalApplication);
  Future<void> openWebsite()       => launchUrl(websiteUrl,   mode: LaunchMode.externalApplication);
  Future<void> openPrivacyPolicy() => launchUrl(privacyUrl,   mode: LaunchMode.externalApplication);
}

// Value objects 

class AppScreenshot {
  final String url;
  final String caption;
  const AppScreenshot({required this.url, required this.caption});
}

class AppFeature {
  final String emoji;
  final String title;
  final String body;
  final int accentHex;
  const AppFeature({
    required this.emoji,
    required this.title,
    required this.body,
    required this.accentHex,
  });
  Color get accent => Color(accentHex);
}

class WhyItem {
  final String emoji;
  final String title;
  final String body;
  const WhyItem({required this.emoji, required this.title, required this.body});
}

class VersionEntry {
  final String version;
  final String date;
  final String notes;
  const VersionEntry({
    required this.version,
    required this.date,
    required this.notes,
  });
}