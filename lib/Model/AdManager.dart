import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final BannerAd myBanner = BannerAd(
  adUnitId: 'ca-app-pub-3539198406149456/4072531201',
  size: AdSize.banner,
  request: AdRequest(),
  listener: AdListener(),
);

final AdSize adSize = AdSize(width: 300,height: 100);
final AdListener blistener = AdListener(
  // Called when an ad is successfully received.
  onAdLoaded: (Ad ad) => print('Ad loaded.'),
  // Called when an ad request failed.
  onAdFailedToLoad: (Ad ad, LoadAdError error) {
    print('Ad failed to load: $error');
  },
  // Called when an ad opens an overlay that covers the screen.
  onAdOpened: (Ad ad) => print('Ad opened.'),
  // Called when an ad removes an overlay that covers the screen.
  onAdClosed: (Ad ad) => print('Ad closed.'),
  // Called when an ad is in the process of leaving the application.
  onApplicationExit: (Ad ad) => print('Left application.'),
);
final AdWidget adWidget = AdWidget(ad: myBanner);
final Container adContainer = Container(
  alignment: Alignment.center,
  child: adWidget,
  width: myBanner.size.width.toDouble(),
  height: myBanner.size.height.toDouble(),
);


final InterstitialAd myInterstitial = InterstitialAd(
  adUnitId: 'ca-app-pub-3539198406149456/1446367861',
  request: AdRequest(),
  listener: AdListener(),
);

final AdListener ilistener = AdListener(
  // Called when an ad is successfully received.
  onAdLoaded: (Ad ad) => print('Ad loaded.'),
  // Called when an ad request failed.
  onAdFailedToLoad: (Ad ad, LoadAdError error) {
    print('Ad failed to load: $error');
    },
  // Called when an ad opens an overlay that covers the screen.
  onAdOpened: (Ad ad) => print('Ad opened.'),
  // Called when an ad removes an overlay that covers the screen.
  onAdClosed: (Ad ad) => print('Ad closed.'),
  // Called when an ad is in the process of leaving the application.
  onApplicationExit: (Ad ad) => print('Left application.'),
);


