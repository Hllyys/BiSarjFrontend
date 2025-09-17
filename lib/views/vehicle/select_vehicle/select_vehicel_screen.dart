import 'dart:io';

// import 'package:ev/model/payment_model.dart';
// import 'package:ev/model/user_model.dart';
// import 'package:ev/utils/app_commons.dart';
// import 'package:ev/utils/app_data_provider.dart';
// import 'package:ev/views/vehicle/add_brand/add_brand_screen.dart';
// import 'package:ev/views/vehicle/select_charger_screen.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:frontend_bisarj/model/payment_model.dart';
import 'package:frontend_bisarj/model/user_model.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:frontend_bisarj/utils/app_data_provider.dart';
import 'package:frontend_bisarj/views/vehicle/add_brand/add_brand_screen.dart';
import 'package:frontend_bisarj/views/vehicle/select_charger_screen.dart';
import '../../../components/alert_dailog_widget.dart';
import '../../../components/app_button.dart';
import '../../../utils/app_colors.dart';
//import '../../../utils/app_constants.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SelectVehicelScreen extends StatefulWidget {
  const SelectVehicelScreen({super.key});

  @override
  State<SelectVehicelScreen> createState() => _SelectVehicelScreenState();
}

class _SelectVehicelScreenState extends State<SelectVehicelScreen> {
  int currentIndex = 0;

  List<MyVehicleModel> vehicleIds = [];
  List<PaymentModel> vehicelData = carList();

  late userModel userData;

  /// BannerAd variable
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  late Orientation _currentOrientation;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(
          context,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Select Your Vehicel', style: BoldTextStyle(size: 16)),
        actions: [
          inkWellWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddBrandScreen()),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          shrinkWrap: true,
          itemCount: vehicelData.length,
          itemBuilder: (_, index) {
            PaymentModel data = vehicelData[index];
            return index == 4
                ? Column(
                    children: [
                      if (_anchoredAdaptiveAd != null)
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: AdWidget(ad: _anchoredAdaptiveAd!),
                        ),
                      selectVehicleWidget(index: index, data: data),
                    ],
                  )
                : selectVehicleWidget(index: index, data: data);
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppButton(
          text: 'Continue',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SelectChargerScreen()),
            );
          },
        ),
      ),
    );
  }

  changeVehicle(int currentValue) {
    currentIndex = currentValue;
    setState(() {});
  }

  Widget selectVehicleWidget({required int index, required PaymentModel data}) {
    return InkWell(
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      onTap: () {
        changeVehicle(index);
      },
      child: AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(milliseconds: 500),
        child: SlideAnimation(
          verticalOffset: MediaQuery.of(context).size.width * 0.8,
          child: Dismissible(
            key: Key('$index'),
            direction: DismissDirection.endToStart,
            background: slideLeftBackground(),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: MaterialLocalizations.of(
                    context,
                  ).modalBarrierDismissLabel,
                  pageBuilder: (ctx, a1, a2) {
                    return Container();
                  },
                  transitionBuilder: (ctx, a1, a2, child) {
                    var curve = Curves.easeInOut.transform(a1.value);
                    return AlertDialogWidget(
                      scale: curve,
                      title: 'Successful Cancellation!',
                      subTitle: 'Your booking has been successful cancelled.',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                );
              }
              return true;
            },
            child: Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      data.image!,
                      fit: BoxFit.contain,
                      height: 50,
                      width: 40,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8, right: 16),
                    height: 30,
                    width: 1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.title ?? '', style: BoldTextStyle()),
                        SizedBox(height: 8),
                        Text(data.subTitle ?? '', style: SecondaryTextStyle()),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryColor),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == index
                            ? primaryColor
                            : Colors.transparent,
                        border: Border.all(
                          color: currentIndex == index
                              ? primaryColor
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget slideLeftBackground() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.5),
      borderRadius: BorderRadius.circular(defaultRadius),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(Icons.delete, color: Colors.white),
          Text(
            " Delete",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            textAlign: TextAlign.right,
          ),
          SizedBox(width: 20),
        ],
      ),
    ),
  );
}
