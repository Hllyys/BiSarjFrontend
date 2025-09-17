import 'package:flutter/material.dart';
import 'package:frontend_bisarj/model/wallet_model.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:frontend_bisarj/utils/app_data_provider.dart';

import '../../utils/app_colors.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  List<WalletModel> list = WalletList();

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
        title: Text('Recent Transactions', style: BoldTextStyle(size: 16)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: AnimationLimiter(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: data.status == 0
                                            ? Colors.red
                                            : primaryColor,
                                      ),
                                    ),
                                    child: Text(
                                      data.status == 0 ? 'Paid' : 'Topup',
                                      style: BoldTextStyle(
                                        color: data.status == 0
                                            ? Colors.red
                                            : primaryColor,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Text('Top Up Wallet', style: BoldTextStyle()),
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
                            color: data.status == 0 ? Colors.red : primaryColor,
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
      ),
    );
  }
}
