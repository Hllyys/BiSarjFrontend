import 'package:flutter/material.dart';
import 'package:frontend_bisarj/model/vehicle_list_model.dart';
import 'package:frontend_bisarj/model/vehicle_model.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_data_provider.dart';
import '../../../components/app_button.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_commons.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AddBrandScreen extends StatefulWidget {
  const AddBrandScreen({super.key});

  @override
  State<AddBrandScreen> createState() => _AddBrandScreenState();
}

class _AddBrandScreenState extends State<AddBrandScreen>
    with TickerProviderStateMixin {
  TextEditingController carNumberController = TextEditingController();

  late AnimationController controller;

  List<VehicleListModel> vehicleData = addVehicle();

  String vehicleId = '';
  int currentIndex = 0;
  int carSelectIndex = -1;
  String carName = '';
  bool isBook = false;

  bool isLoading = false;
  bool isAdded = false;

  List<String> argumentsVehicleData = [];

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
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
        title: Text('Add new vehicle', style: BoldTextStyle(size: 16)),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimationLimiter(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(left: 8, right: 8),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: vehicleData.map((e) {
                    return inkWellWidget(
                      onTap: () async {
                        carSelectIndex = -1;
                        currentIndex = vehicleData.indexOf(e);
                        setState(() {});
                      },
                      child: AnimationConfiguration.staggeredList(
                        position: vehicleData.indexOf(e),
                        duration: Duration(milliseconds: 500),
                        child: SlideAnimation(
                          horizontalOffset:
                              MediaQuery.of(context).size.width * 0.8,
                          child: Container(
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: currentIndex == vehicleData.indexOf(e)
                                  ? primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(
                                defaultRadius,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Text(
                              e.name!,
                              style: BoldTextStyle(
                                color: currentIndex == vehicleData.indexOf(e)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20),
            AnimationLimiter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(
                    vehicleData[currentIndex].vehicleModel!.length,
                    (index) {
                      VehicleModel data =
                          vehicleData[currentIndex].vehicleModel![index];
                      return inkWellWidget(
                        onTap: () {
                          carSelectIndex = index;
                          setState(() {});
                        },
                        child: AnimationConfiguration.staggeredList(
                          position: index,
                          duration: Duration(milliseconds: 500),
                          child: SlideAnimation(
                            verticalOffset:
                                MediaQuery.of(context).size.width * 0.8,
                            duration: Duration(milliseconds: 375),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 24,
                              // margin: EdgeInsets.only(left: 8, right: 8),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: carSelectIndex == index
                                    ? primaryColor.withOpacity(0.1)
                                    : Colors.white,
                                border: Border.all(
                                  color: carSelectIndex == index
                                      ? primaryColor
                                      : Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Transform.translate(
                                    offset: Offset(0, 0),
                                    child: Image.asset(
                                      data.image!,
                                      height: 90,
                                      width:
                                          MediaQuery.of(context).size.width /
                                              2 -
                                          24,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text(
                                    data.name!,
                                    style: BoldTextStyle(size: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: AppButton(
          text: 'Add This Vehicle',
          backColor: isAdded ? primaryColor.withOpacity(0.5) : primaryColor,
          onPressed: () {
            if (!isAdded) {
              if (carSelectIndex == -1) {
                return commonSnackBar(message: 'Please select vehicel');
              }
              showModalBottomSheet(
                isScrollControlled: true,
                transitionAnimationController: controller,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                context: context,
                builder: (_) {
                  return StatefulBuilder(
                    builder: (context, setState) => Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: isBook
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          mainAxisAlignment: isBook
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    height: 4,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(
                                        defaultRadius,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    isBook
                                        ? "Congratulations!"
                                        : "Enter your Vehicle Number",
                                    style: BoldTextStyle(size: 16),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            if (isBook)
                              Text(
                                'Vehicle Number successfully added',
                                style: PrimaryTextStyle(size: 16),
                              ),
                            !isBook
                                ? TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: carNumberController,
                                    cursorColor: primaryColor,
                                    validator: fieldValidator,
                                    decoration: inputDecoration(
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: Icon(
                                          Icons.electric_car,
                                          size: 20,
                                          color: primaryColor,
                                        ),
                                      ),
                                      hintText: '',
                                    ),
                                  )
                                : Center(
                                    child: Lottie.asset(
                                      ic_successful,
                                      height: 120,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                            SizedBox(height: 16),
                            if (!isBook)
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Enter your ',
                                      style: SecondaryTextStyle(size: 12),
                                    ),
                                    TextSpan(
                                      text: '${carName.replaceAll('\n', '')}',
                                      style: BoldTextStyle(size: 12),
                                    ),
                                    TextSpan(
                                      text: ' registration number.',
                                      style: SecondaryTextStyle(size: 12),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(height: 16),
                            AppButton(
                              text: isBook ? 'Continues' : 'Submit',
                              onPressed: () {
                                //
                              },
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              commonSnackBar(
                message: 'This vehicle already added',
                contentType: ContentType.failure,
              );
            }
          },
        ),
      ),
    );
  }
}
