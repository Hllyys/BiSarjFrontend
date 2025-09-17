import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_assets.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AboutScreens extends StatefulWidget {
  const AboutScreens({super.key});

  @override
  State<AboutScreens> createState() => _AboutScreensState();
}

class _AboutScreensState extends State<AboutScreens> {
  /// BannerAd variable
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  late Orientation _currentOrientation;

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  int maxFailedLoadAttempts = 3;

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentOrientation = MediaQuery.of(context).orientation;
    _loadAd();
    _createRewardedAd();
  }

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  Future<void> _loadAd() async {
    await _anchoredAdaptiveAd?.dispose();
    setState(() {
      _anchoredAdaptiveAd = null;
      _isLoaded = false;
    });

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: Platform.isAndroid ? androidBannerAdsKey : iOSBannerAdsKey,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          _anchoredAdaptiveAd = ad as BannerAd;
          setState(() {});
          print('===>>>$error');
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  void _createRewardedAd() {
    RewardedAd.load(
      adUnitId: Platform.isAndroid ? androidRewardAdsKey : iOSRewardAdsKey,
      request: request,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('$ad loaded.');
          _rewardedAd = ad;
          _numRewardedLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
          _rewardedAd = null;
          _numRewardedLoadAttempts += 1;
          if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
            _createRewardedAd();
          }
        },
      ),
    );
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
      },
    );
    _rewardedAd = null;
  }

  @override
  void dispose() {
    _anchoredAdaptiveAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(
          context,
          onTap: () {
            Navigator.pop(context);
            _showRewardedAd();
          },
        ),
        title: Text('About', style: BoldTextStyle(size: 16)),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(ic_app_icon, height: 150),
                ),
                SizedBox(height: 16),
                Text('${AppName}', style: BoldTextStyle(size: 18)),
                Text('v1.0.0', style: BoldTextStyle(size: 18)),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: AdWidget(ad: _anchoredAdaptiveAd!),
            ),
          ),
        ],
      ),
    );
  }
}
