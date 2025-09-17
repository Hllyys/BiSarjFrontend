import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_data_provider.dart';
import '../../model/charger_model.dart';
import '../../utils/app_commons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ChargerScrees extends StatefulWidget {
  const ChargerScrees({super.key});

  @override
  State<ChargerScrees> createState() => _ChargerScreesState();
}

class _ChargerScreesState extends State<ChargerScrees>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  int valueData = 0;

  num totalAmount = 0;
  List<ChargerModel> chargerModel = listChargerList();
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16),
        itemCount: chargerModel.length,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          ChargerModel data = chargerModel[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: MediaQuery.of(context).size.width * 0.8,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                margin: EdgeInsets.only(top: 8, right: 4, bottom: 8),
                padding: EdgeInsets.only(left: 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(defaultRadius),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        spreadRadius: 0,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${data.totalHours} hours',
                              style: PrimaryTextStyle(),
                            ),
                          ),
                          Text(
                            data.chargerStatus == 'Available'
                                ? 'Available'
                                : 'In Use',
                            style: BoldTextStyle(
                              color: data.chargerStatus == 'Available'
                                  ? primaryColor
                                  : Colors.red,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: data.chargerStatus == 'Available'
                                  ? primaryColor
                                  : Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(height: 0),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.chargerType ?? '',
                                  style: BoldTextStyle(weight: FontWeight.w500),
                                ),
                                SizedBox(height: 4),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    data.chargerImage ?? '',
                                    fit: BoxFit.cover,
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            height: 50,
                            width: 1,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Max power',
                                  style: BoldTextStyle(weight: FontWeight.w500),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${data.chargerMaxPower} Kw',
                                  style: SecondaryTextStyle(size: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Divider(height: 0),
                      SizedBox(height: 16),
                      AppButton(
                        text: 'Book',
                        padding: EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 2,
                        ),
                        onPressed: () {
                          //
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  changeValue(int? index) {
    currentIndex = index!;
  }

  String textChange({int? index}) {
    if (index == 1) {
      return '12hr';
    } else if (index == 2) {
      return '100';
    } else if (index == 3) {
      return '100%';
    }
    return "";
  }

  int? maxTime({int? index}) {
    if (index == 1) {
      return 12;
    } else if (index == 2) {
      return 100;
    } else if (index == 3) {
      return 100;
    }
    return 0;
  }

  String units({int? index}) {
    if (index == 1) {
      return "hr";
    } else if (index == 2) {
      return "Units";
    } else if (index == 3) {
      return "%";
    }
    return "";
  }

  num totalCalculation({
    num? batteryCapacity,
    num? chargingPower,
    int? currentIndex,
    num? perUnitCharges,
    int? unitValue,
  }) {
    if (currentIndex == 1) {
      num chargingTimeHours = chargingPower! / 60;
      num subTotal = chargingTimeHours * valueData * 60 * 21;
      totalAmount = subTotal;
      return totalAmount;
    } else if (currentIndex == 2) {
      num totalUnitAmount = perUnitCharges! * unitValue!;
      num gstAmount = (totalUnitAmount * 18) * 0.01;
      totalAmount = gstAmount + totalUnitAmount;
      return totalAmount;
    } else if (currentIndex == 3) {
      num numberOfFullCharge = batteryCapacity! / chargingPower!;

      num totalCost = numberOfFullCharge * chargingPower * perUnitCharges!;
      num cost = (totalCost * 0.01 * valueData);
      num gstAmount = (cost * 18) * 0.01;
      totalAmount = gstAmount + cost;
      return totalAmount;
    }
    return 0;
  }
}
