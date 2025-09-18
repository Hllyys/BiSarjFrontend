import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_bisarj/graphql/mutations.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_assets.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/views/about_screens.dart';
import 'package:frontend_bisarj/views/authe/change_password/changePassword_screen.dart';
import 'package:frontend_bisarj/views/authe/delete_account/delete_account_screen.dart';
import 'package:frontend_bisarj/views/authe/login/login_screen.dart';
import 'package:frontend_bisarj/views/authe/personal_info/personal_info_screens.dart';
import 'package:frontend_bisarj/views/bank_detail/bank_detail_screens.dart';
import 'package:frontend_bisarj/views/vehicle/select_vehicle/select_vehicel_screen.dart';
import 'package:frontend_bisarj/views/wallet/with_draw_screen.dart';
import '../../components/app_button.dart';
import '../../utils/app_commons.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controllerDialog;
  late Animation<double> _animation;
  int value = 1;

  List<String> theme = ['System Default', 'Light', 'Dark'];

  /// BannerAd variable
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  late Orientation _currentOrientation;

  @override
  void initState() {
    super.initState();
    controllerDialog = BottomSheet.createAnimationController(this);
    controllerDialog.duration = Duration(milliseconds: 400);
    controllerDialog.reverseDuration = Duration(milliseconds: 400);
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentOrientation = MediaQuery.of(context).orientation;
    _loadAd();
  }

  Future<void> _runLogout({bool allSessions = true}) async {
    final client = GraphQLProvider.of(context).value;

    try {
      final res = await client.mutate(
        MutationOptions(
          document: gql(logoutMutation), 
          variables: {'allSessions': allSessions},
        ),
      );

      if (res.hasException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed: ${res.exception}')),
        );
        return;
      }

      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
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
  void dispose() {
    controller.dispose();
    controllerDialog.dispose();
    _anchoredAdaptiveAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        appBar: appBarWidget(title: 'Account'),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              inkWellWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PersonalInfoScreens()),
                  );
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        ic_person,
                        fit: BoxFit.cover,
                        height: 70,
                        width: 70,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Query(
                        options: QueryOptions(
                          document: gql(meUserQuery),
                          fetchPolicy: FetchPolicy.cacheAndNetwork,
                        ),
                        builder: (result, {refetch, fetchMore}) {
                          if (result.isLoading && result.data == null) {
                            return Text('...', style: BoldTextStyle());
                          }
                          if (result.hasException) {
                            return Text('—', style: BoldTextStyle());
                          }

                          final u = result.data?['meUser']?['user'];
                          final fullName = u == null
                              ? ''
                              : '${u['firstName'] ?? ''} ${u['lastName'] ?? ''}'
                                    .trim();

                          return Text(
                            fullName.isEmpty ? '—' : fullName,
                            style: BoldTextStyle(),
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 16),

                    Expanded(child: SizedBox(width: 16)),
                    Icon(Icons.arrow_forward_ios_outlined),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Divider(height: 0),
              SizedBox(height: 16),
              settingWidget(
                title: 'My Vehicle',
                icon: Icons.car_crash_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SelectVehicelScreen()),
                  );
                },
              ),
              SizedBox(height: 16),
              settingWidget(
                title: 'Bank Details',
                icon: Icons.credit_card_sharp,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => BankDetailScreens()),
                  );
                  //Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScrees()));
                },
              ),
              SizedBox(height: 16),
              settingWidget(
                title: 'Wallet WithDraw',
                icon: Icons.credit_card_sharp,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => WithDrawScreen()),
                  );
                },
              ),
              SizedBox(height: 16),
              Divider(height: 0),
              SizedBox(height: 16),
              settingWidget(
                title: 'Change Password',
                icon: Icons.lock_outline_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ChangePasswordScreen()),
                  );
                },
              ),
              SizedBox(height: 16),
              settingWidget(
                title: 'Theme',
                icon: Icons.dark_mode_outlined,
                onTap: () {
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
                      return Transform.scale(
                        scale: curve,
                        child: StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      defaultRadius,
                                    ),
                                  ),
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(16),
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                              defaultRadius,
                                            ),
                                            topRight: Radius.circular(
                                              defaultRadius,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Theme',
                                                style: BoldTextStyle(
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                            inkWellWidget(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 200,
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: theme.length,
                                          shrinkWrap: true,
                                          itemBuilder: (_, index) {
                                            return RadioListTile(
                                              visualDensity: VisualDensity(
                                                vertical: 0,
                                                horizontal: 0,
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                left: 8,
                                                top: 0,
                                                right: 0,
                                                bottom: 0,
                                              ),
                                              value: index,
                                              groupValue: value,
                                              activeColor: primaryColor,
                                              onChanged: (val) {
                                                value = val!;
                                                setState(() {});
                                              },
                                              title: Text(
                                                theme[index],
                                                style: BoldTextStyle(),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                        ),
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 300),
                  );
                },
              ),
              SizedBox(height: 16),
              settingWidget(
                title: 'Delete Account',
                icon: Icons.delete_outline_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DeleteAccountScreen()),
                  );
                },
              ),
              SizedBox(height: 16),
              Divider(height: 0),
              SizedBox(height: 16),
              settingWidget(
                title: 'About',
                icon: Icons.g_translate_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AboutScreens()),
                  );
                },
              ),
              SizedBox(height: 16),
              settingWidget(
                title: 'Logout',
                icon: Icons.logout_outlined,
                onTap: () {
                  showModalBottomSheet(
                    transitionAnimationController: controllerDialog,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    context: context,
                    builder: (_) {
                      return Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Logout",
                              style: BoldTextStyle(color: Colors.red),
                            ),
                            SizedBox(height: 16),
                            Divider(height: 0),
                            SizedBox(height: 16),
                            Text(
                              "Are you sure you want to log out?",
                              style: BoldTextStyle(),
                              textAlign: TextAlign.center,
                            ),
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
                                    text: 'Cancel',
                                    onPressed: () async {
                                      await _runLogout(allSessions: true);
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
                                    text: 'Logout',
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => LoginScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 16),
              if (_anchoredAdaptiveAd != null)
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: AdWidget(ad: _anchoredAdaptiveAd!),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingWidget({String? title, IconData? icon, Function()? onTap}) {
    return InkWell(
      overlayColor: MaterialStateColor.resolveWith(
        (states) => Colors.transparent,
      ),
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.black87),
          SizedBox(width: 16),
          Expanded(child: Text(title!, style: BoldTextStyle())),
          Icon(Icons.arrow_forward_ios_rounded, size: 20),
        ],
      ),
    );
  }
}
