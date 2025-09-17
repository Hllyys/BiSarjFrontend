import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/vertical_coupon_widget.dart';
import 'package:frontend_bisarj/model/wallet_model.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_data_provider.dart';
import 'package:frontend_bisarj/views/wallet/top_up_wallet_screen.dart';

import '../../utils/app_commons.dart';
import 'transactions_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  final List<WalletModel> list = WalletList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: 'My Wallet'),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                VerticalCouponExample(
                  title: 'Add Money',
                  totalAmount: 5000,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TopUpWalletScreen()),
                    );
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Recent Transaction',
                        style: BoldTextStyle(size: 20),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TransactionsScreen(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'View All',
                            style: BoldTextStyle(color: primaryColor),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, color: primaryColor),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                AnimationLimiter(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    itemCount: list.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      WalletModel data = list[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: FadeInAnimation(
                          duration: const Duration(milliseconds: 375),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                color: data.status == 0
                                                    ? Colors.red
                                                    : primaryColor,
                                              ),
                                            ),
                                            child: Text(
                                              data.status == 0
                                                  ? 'Paid'
                                                  : 'Topup',
                                              style: BoldTextStyle(
                                                color: data.status == 0
                                                    ? Colors.red
                                                    : primaryColor,
                                                size: 10,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Text(
                                            'Top Up Wallet',
                                            style: BoldTextStyle(),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        data.createDate ?? '',
                                        style: SecondaryTextStyle(
                                          size: 12,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  data.status == 0
                                      ? '-\$${data.amount}'
                                      : '+\$${data.amount}',
                                  style: BoldTextStyle(
                                    color: data.status == 0
                                        ? Colors.red
                                        : primaryColor,
                                  ),
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
        ],
      ),
    );
  }
}
