import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/vertical_coupon_widget.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:frontend_bisarj/utils/app_data_provider.dart';
import '../../model/wallet_model.dart';
import '../../utils/app_colors.dart';
import 'top_up_wallet_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class WithDrawScreen extends StatefulWidget {
  const WithDrawScreen({super.key});

  @override
  State<WithDrawScreen> createState() => _WithDrawScreenState();
}

class _WithDrawScreenState extends State<WithDrawScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  late AnimationController controller;
  late Animation<double> animation;

  int currentAmount = 10;

  List<WalletModel> walletModelList = WalletList();

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Scaffold(
        appBar: AppBar(
          leading: backButton(
            context,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text('WithDraw', style: BoldTextStyle()),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalCouponExample(
                title: 'WithDraw Request',
                totalAmount: 4000,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TopUpWalletScreen(isWallet: true),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Text('WithDraw History', style: BoldTextStyle(size: 16)),
              SizedBox(height: 16),
              AnimationLimiter(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  itemCount: walletModelList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    WalletModel walletModel = walletModelList[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: Duration(milliseconds: 375),
                      child: SlideAnimation(
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
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: primaryColor),
                                      ),
                                      child: Text(
                                        'Approved',
                                        style: BoldTextStyle(
                                          color: primaryColor,
                                          size: 10,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      walletModel.createDate!,
                                      style: SecondaryTextStyle(
                                        size: 12,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    '+\$${walletModel.amount}',
                                    style: BoldTextStyle(color: primaryColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
