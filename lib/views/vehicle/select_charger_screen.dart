import 'package:flutter/material.dart';
import 'package:frontend_bisarj/model/payment_model.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';

import '../../components/app_button.dart';
import '../../utils/app_commons.dart';
import '../../utils/app_data_provider.dart';

class SelectChargerScreen extends StatefulWidget {
  const SelectChargerScreen({super.key});

  @override
  State<SelectChargerScreen> createState() => _SelectChargerScreenState();
}

class _SelectChargerScreenState extends State<SelectChargerScreen> {
  List<PaymentModel> list = chargerList();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(context, onTap: () {
          Navigator.pop(context);
        }),
        title: Text(
          'Select Charger',
          style: BoldTextStyle(size: 16),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                 BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(list[index].title!, style: SecondaryTextStyle()),
                        SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(list[index].image!,
                              fit: BoxFit.cover, height: 30, width: 30),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    height: 40,
                    width: 1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Max power', style: SecondaryTextStyle()),
                        SizedBox(height: 8),
                        Text('${list[index].subTitle!} Kw', style: BoldTextStyle()),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryColor),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == index ? primaryColor : Colors.transparent,
                          border: Border.all(
                              color: currentIndex == index ? primaryColor : Colors.transparent),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppButton(
          text: 'Continue',
          onPressed: () {
            //
          },
        ),
      ),
    );
  }
}
