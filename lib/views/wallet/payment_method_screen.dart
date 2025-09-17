import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';

import '../../components/alert_dailog_widget.dart';
import '../../components/app_button.dart';
import '../../model/payment_model.dart';
import '../../utils/app_commons.dart';
import '../../utils/app_data_provider.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen>
    with SingleTickerProviderStateMixin {
  List<PaymentModel> list = paymentList();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(context),
        title: Text(
          'Top Up Wallet',
          style: BoldTextStyle(size: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select the top up method you want to use.', style: PrimaryTextStyle()),
            SizedBox(height: 16),
            ListView.builder(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (_, index) {
                return InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                    currentIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    padding: EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      border: Border.all(
                          color:
                              currentIndex == index ? primaryColor : Colors.grey.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(list[index].image!,
                              fit: BoxFit.cover, height: 40, width: 40),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(list[index].title!, style: BoldTextStyle()),
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
                              color: currentIndex == index ? primaryColor : Colors.transparent,
                              border: Border.all(
                                  color: currentIndex == index ? primaryColor : Colors.transparent),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            AppButton(
              text: 'Continue',
              onPressed: () {
                /* showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                  pageBuilder: (ctx, a1, a2) {
                    return Container();
                  },
                  transitionBuilder: (ctx, a1, a2, child) {
                    var curve = Curves.easeInOut.transform(a1.value);
                    return AlertDialogWidget(
                      scale: curve,
                      title: 'Booking Successfully!',
                      subTitle: 'You can view booking details on the My Booking menu',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                );*/

                /*showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                  pageBuilder: (ctx, a1, a2) {
                    return Container();
                  },
                  transitionBuilder: (ctx, a1, a2, child) {
                    var curve = Curves.easeInOut.transform(a1.value);
                    return AlertDialogWidget(
                      scale: curve,
                      title: 'Charging 100%\nCompleted',
                      subTitle: 'A total \$14.25 has been changed from your e-wallet.',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                );*/

                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                  pageBuilder: (ctx, a1, a2) {
                    return Container();
                  },
                  transitionBuilder: (ctx, a1, a2, child) {
                    var curve = Curves.easeInOut.transform(a1.value);
                    return AlertDialogWidget(
                      scale: curve,
                      title: 'Top Up Successful',
                      subTitle: 'A total \$100 has been added to your wallet.',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
