import 'package:flutter/material.dart';
import 'package:frontend_bisarj/model/payment_model.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:frontend_bisarj/utils/app_data_provider.dart';

import '../../components/app_button.dart';

class SelectPaymentMethod extends StatefulWidget {
  const SelectPaymentMethod({super.key});

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  List<PaymentModel> list = paymentMethod();
  int currentValue = 0;

  bool isLoading = false;

  String paymentType = 'Stripe';

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
        title: Text('Select Payment Method', style: BoldTextStyle()),
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (_, index) {
              return InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () {
                  selectPaymentMethod(currentIndex: index);
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        list[index].image!,
                        fit: BoxFit.contain,
                        height: 24,
                        width: 24,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8, right: 16),
                        height: 30,
                        width: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      Expanded(
                        child: Text(list[index].title!, style: BoldTextStyle()),
                      ),
                      Text(list[index].subTitle ?? '', style: BoldTextStyle()),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentValue == index
                                ? primaryColor
                                : Colors.transparent,
                            border: Border.all(
                              color: currentValue == index
                                  ? primaryColor
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppButton(
          text: 'Continue',
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  selectPaymentMethod({int? currentIndex}) {
    currentValue = currentIndex!;
    setState(() {});
  }
}
