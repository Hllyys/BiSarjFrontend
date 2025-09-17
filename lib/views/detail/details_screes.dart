import 'dart:io';

// import 'package:ev/components/app_button.dart';
// import 'package:ev/main.dart';
// import 'package:ev/model/check_in_model.dart';
// import 'package:ev/model/review_model.dart';
// import 'package:ev/utils/app_colors.dart';
// import 'package:ev/views/detail/charger_screes.dart';
// import 'package:ev/views/detail/check_in_widget.dart';
// import 'package:ev/views/detail/check_ins_screens.dart';
// import 'package:ev/views/detail/info_screens.dart';
// import 'package:ev/views/detail/reviews_screes.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_sticky_header/flutter_sticky_header.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/main.dart';
import 'package:frontend_bisarj/model/check_in_model.dart';
import 'package:frontend_bisarj/model/review_model.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/views/detail/charger_screes.dart';
import 'package:frontend_bisarj/views/detail/check_in_widget.dart'
    show CheckInWidget;
import 'package:frontend_bisarj/views/detail/check_ins_screens.dart';
import 'package:frontend_bisarj/views/detail/info_screens.dart';
import 'package:frontend_bisarj/views/detail/reviews_screes.dart';

import '../../model/charger_model.dart';
import '../../model/charging_station_model.dart';
import '../../model/payment_model.dart';
import '../../utils/app_commons.dart';
import '../../utils/app_data_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class DetailScrees extends StatefulWidget {
  ChargingStationModel? chargingStationData;

  DetailScrees({super.key, this.chargingStationData});

  @override
  State<DetailScrees> createState() => _DetailScreesState();
}

class _DetailScreesState extends State<DetailScrees>
    with TickerProviderStateMixin {
  bool isDetailLoading = false;

  late AnimationController controller;
  late AnimationController controllerDialog;

  late Animation<double> animation;

  int listIndex = 0;

  bool isMore = false;
  double averageCount = 0.0;
  num totalReviewCount = 0;

  List<String> list = ["Info", "Charger", "Check", "Reviews"];
  List<PaymentModel> listData = CheckInData();

  List<ChargerModel?> chargerModel = [];

  List<String> favoriteCharger = [];

  List<Widget> widgetList = [
    InfoScreens(),
    ChargerScrees(),
    CheckInsScreens(),
    ReviewsScrees(),
  ];

  bool isFavorite = false;

  TabController? tabController;
  ScrollController scrollController = ScrollController();

  double rattingCount = 0.0;
  List<ReviewModel> reviewDataList = [];
  List<CheckInModel> checkInDataList = [];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController reviewController = TextEditingController();
  List<ChargerModel> dataCharger = listChargerList();

  /// Add
  int maxFailedLoadAttempts = 3;

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    _createRewardedAd();
    _createInterstitialAd();
    Future.delayed(Duration(milliseconds: 300), () {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      );
    });
    controllerDialog = BottomSheet.createAnimationController(this);
    controllerDialog.duration = Duration(milliseconds: 400);
    controllerDialog.reverseDuration = Duration(milliseconds: 400);
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
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
    _rewardedAd?.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Scaffold(
        body: DefaultTabController(
          length: 4,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          widget.chargingStationData!.stationImage ?? '',
                          fit: BoxFit.cover,
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Positioned(
                          top: 30,
                          right: 20,
                          child: inkWellWidget(
                            onTap: () {
                              isFavorite = !isFavorite;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                !isFavorite
                                    ? Icons.bookmark_border_outlined
                                    : Icons.bookmark,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 20,
                          child: inkWellWidget(
                            onTap: () {
                              Navigator.pop(context);
                              //_showInterstitialAd();
                              _showRewardedAd();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            widget.chargingStationData!.stationName ?? '',
                            style: BoldTextStyle(size: 25),
                          ),
                          SizedBox(height: 8),
                          Text(
                            widget.chargingStationData!.stationAddress ?? '',
                            style: PrimaryTextStyle(),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                widget.chargingStationData!.avgReviewCount ??
                                    '',
                                style: BoldTextStyle(),
                              ),
                              SizedBox(width: 8),
                              RatingBar.builder(
                                initialRating: double.parse(
                                  widget.chargingStationData!.avgReviewCount!,
                                ),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                glow: false,
                                itemSize: 13,
                                ignoreGestures: true,
                                itemBuilder: (context, _) =>
                                    Icon(Icons.star, color: Colors.amber),
                                onRatingUpdate: (rating) {
                                  //
                                },
                              ),
                              SizedBox(width: 8),
                              Text(
                                '(${widget.chargingStationData!.totalReview} reviews)',
                                style: PrimaryTextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  widget.chargingStationData!.status ?? '',
                                  style: PrimaryTextStyle(
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.grey,
                                size: 15,
                              ),
                              SizedBox(width: 8),
                              Text(
                                widget.chargingStationData!.avgReviewCount ??
                                    '',
                                style: PrimaryTextStyle(),
                              ),
                              SizedBox(width: 16),
                              Icon(
                                Icons.directions_car,
                                color: Colors.grey,
                                size: 15,
                              ),
                              SizedBox(width: 8),
                              Text('5 mins', style: PrimaryTextStyle()),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(height: 0),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 8,
                                  ),
                                  backgroundColor: primaryColor,
                                  text: 'Get Direction',
                                  onPressed: () {
                                    mapDirection(
                                      latitude: widget
                                          .chargingStationData!
                                          .stationLocation!
                                          .latitude,
                                      longitude: widget
                                          .chargingStationData!
                                          .stationLocation!
                                          .longitude,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: AppButton(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 8,
                                  ),
                                  text: 'Route Planer',
                                  onPressed: () async {
                                    //
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(height: 0),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SliverStickyHeader.builder(
                sticky: true,
                overlapsContent: false,
                builder: (_, state) {
                  return AnimatedContainer(
                    color: Colors.white,
                    padding: state.isPinned
                        ? EdgeInsets.only(top: 16)
                        : EdgeInsets.all(0),
                    duration: Duration(milliseconds: 500),
                    child: TabBar(
                      controller: tabController,
                      labelColor: primaryColor,
                      unselectedLabelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: primaryColor,
                      padding: EdgeInsets.zero,
                      automaticIndicatorColorAdjustment: true,
                      onTap: (val) {
                        listIndex = val;
                        setState(() {});
                      },
                      tabs: list.map((e) {
                        return Tab(text: e);
                      }).toList(),
                    ),
                  );
                },
                sliver: SliverList(
                  delegate: SliverChildListDelegate([widgetList[listIndex]]),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigationWidget(currentIndex: listIndex),
      ),
    );
  }

  Widget? bottomNavigationWidget({int? currentIndex}) {
    if (currentIndex == 2) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: AppButton(
          text: 'Check-in',
          onPressed: () {
            showModalBottomSheet(
              transitionAnimationController: controllerDialog,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              context: appNavigator.currentState!.context,
              builder: (_) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8, bottom: 8),
                          height: 3,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                        ),
                        Text("Check-in", style: BoldTextStyle(size: 18)),
                        SizedBox(height: 8),
                        Divider(height: 0),
                        SizedBox(height: 8),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          shrinkWrap: true,
                          itemCount: listData.length,
                          itemBuilder: (_, index) {
                            return inkWellWidget(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CheckInWidget(
                                      title: listData[index].title!,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 8, bottom: 8),
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      listData[index].image!,
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        listData[index].title!,
                                        style: BoldTextStyle(),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          padding: EdgeInsets.all(8),
        ),
      );
    } else if (currentIndex == 3) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: AppButton(
          text: 'Write a Reviews',
          onPressed: () {
            rattingCount = 0;
            showModalBottomSheet(
              isScrollControlled: true,
              transitionAnimationController: controllerDialog,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              context: appNavigator.currentState!.context,
              builder: (_) {
                return Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(
                        appNavigator.currentState!.context,
                      ).viewInsets.bottom,
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 8, bottom: 8),
                                  height: 3,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(
                                      defaultRadius,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Write a Review",
                                  style: BoldTextStyle(size: 18),
                                ),
                                SizedBox(height: 16),
                                Divider(height: 0),
                                SizedBox(height: 16),
                                Text("Give it a star", style: BoldTextStyle()),
                                SizedBox(height: 16),
                                RatingBar.builder(
                                  initialRating: rattingCount,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  glow: false,
                                  itemPadding: EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  itemBuilder: (context, _) =>
                                      Icon(Icons.star, color: Colors.amber),
                                  onRatingUpdate: (rating) {
                                    rattingCount = rating;
                                  },
                                ),
                                SizedBox(height: 16),
                                Divider(height: 0),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                          Text("Comment", style: PrimaryTextStyle(size: 16)),
                          SizedBox(height: 16),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            maxLines: 2,
                            style: BoldTextStyle(size: 14),
                            controller: reviewController,
                            decoration: inputDecoration(
                              title: 'This is my favorite EV Charging stations',
                            ),
                          ),
                          SizedBox(height: 20),
                          AppButton(
                            text: 'Submit',
                            onPressed: () {
                              if (rattingCount <= 0) {
                                return commonToast(
                                  title: 'Please add your ratting review',
                                );
                              }
                              reviewController.clear();
                              Navigator.pop(context);
                            },
                            padding: EdgeInsets.all(8),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          padding: EdgeInsets.all(8),
        ),
      );
    }
    return Offstage();
  }
}
