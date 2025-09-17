import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/model/wallet_model.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/views/wallet/select_payment_method.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../utils/app_commons.dart';

class TopUpWalletScreen extends StatefulWidget {
  final bool isWallet;

  TopUpWalletScreen({super.key, this.isWallet = false});

  @override
  State<TopUpWalletScreen> createState() => _TopUpWalletScreenState();
}

class _TopUpWalletScreenState extends State<TopUpWalletScreen> {
  num totalAmount = 0.0;

  num currentAmount = 10;

  var index = 0;

  List<WalletModel> walletModelList = [];

  List<int> walletAmountList = [10, 20, 50, 100, 200, 300, 500, 750, 1000];

  /// BannerAd variable
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  late Orientation _currentOrientation;

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentOrientation = MediaQuery.of(context).orientation;
    _loadAd();
  }

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

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? androidInterstitialAdsKey
          : iOSInterstitialAdsKey,
      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  void dispose() {
    super.dispose();
    _showInterstitialAd();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(
          context,
          onTap: () {
            Navigator.pop(context);
            _showInterstitialAd();
          },
        ),
        title: Text('Top Up Wallet', style: BoldTextStyle(size: 16)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter the amount of top up',
              style: PrimaryTextStyle(size: 18),
            ),
            SizedBox(height: 16),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  '\$${currentAmount}',
                  style: BoldTextStyle(size: 30),
                ),
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.start,
              runSpacing: 16,
              spacing: 16,
              children: List.generate(
                walletAmountList.length,
                (index) => InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                    changeWalletAmount(currentValue: walletAmountList[index]);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 3 - 24,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                    decoration: BoxDecoration(
                      color: currentAmount == walletAmountList[index]
                          ? primaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: AutoSizeText(
                      '\$${walletAmountList[index]}',
                      style: BoldTextStyle(
                        color: currentAmount == walletAmountList[index]
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            AppButton(
              text: 'Continue',
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SelectPaymentMethod()),
                );
              },
            ),
            SizedBox(height: 30),
            if (_anchoredAdaptiveAd != null)
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: AdWidget(ad: _anchoredAdaptiveAd!),
              ),
          ],
        ),
      ),
    );
  }

  changeWalletAmount({int? currentValue}) {
    currentAmount = currentValue!;
    setState(() {});
  }
}
