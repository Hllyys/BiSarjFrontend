import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_assets.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import '../../../utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfoScreens extends StatefulWidget {
  @override
  State<PersonalInfoScreens> createState() => _PersonalInfoScreensState();
}

class _PersonalInfoScreensState extends State<PersonalInfoScreens>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  bool isShow = false;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode contactFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();
  FocusNode genderFocusNode = FocusNode();

  late AnimationController controller;
  late Animation<double> animation;

  final ImagePicker picker = ImagePicker();
  XFile? image = null;

  String userProfile = '';

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
          title: Text('Personal Info', style: BoldTextStyle()),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  child: Stack(
                    children: [
                      image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                File(image!.path),
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : userProfile.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                userProfile,
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              ),
                            )
                          : Image.asset(
                              ic_person,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: inkWellWidget(
                          onTap: () async {
                            image = await picker.pickImage(
                              source: ImageSource.camera,
                            );
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(
                                defaultRadius,
                              ),
                            ),
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Email', style: BoldTextStyle()),
              SizedBox(height: 8),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: inputDecoration(hintText: 'andew@gmail.com'),
                focusNode: emailFocusNode,
                controller: emailController,
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(fullNameFocusNode);
                },
              ),
              SizedBox(height: 16),
              Text('First Name', style: BoldTextStyle()),
              SizedBox(height: 8),
              TextFormField(
                decoration: inputDecoration(hintText: 'Andew Ainsley'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                focusNode: fullNameFocusNode,
                controller: fullNameController,
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(contactFocusNode);
                },
                validator: fieldValidator,
              ),
              SizedBox(height: 16),
              Text('Phone Number', style: BoldTextStyle()),
              SizedBox(height: 8),
              TextFormField(
                decoration: inputDecoration(hintText: '+111 675 673 879'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                focusNode: contactFocusNode,
                controller: contactController,
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(addressFocusNode);
                },
                validator: fieldValidator,
              ),
              SizedBox(height: 16),
              Text('Street Address', style: BoldTextStyle()),
              SizedBox(height: 8),
              TextFormField(
                decoration: inputDecoration(
                  hintText: '3517 w. Gray Street New York',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                focusNode: addressFocusNode,
                controller: addressController,
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(countryFocusNode);
                },
                validator: fieldValidator,
              ),
              SizedBox(height: 16),
              Text('Country', style: BoldTextStyle()),
              SizedBox(height: 8),
              TextFormField(
                decoration: inputDecoration(hintText: 'India'),
                focusNode: countryFocusNode,
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(genderFocusNode);
                },
                controller: countryController,
                validator: fieldValidator,
              ),
              SizedBox(height: 16),
              Text('Gender', style: BoldTextStyle()),
              SizedBox(height: 8),
              TextFormField(
                decoration: inputDecoration(
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: primaryColor,
                    size: 25,
                  ),
                  hintText: 'Male',
                ),
                controller: genderController,
              ),
              SizedBox(height: 16),
              Text('Date of Birth', style: BoldTextStyle()),
              SizedBox(height: 8),
              TextFormField(
                decoration: inputDecoration(
                  suffixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: primaryColor,
                    size: 20,
                  ),
                  hintText: '12/09/1998',
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16),
          child: AppButton(
            text: 'Submit',
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
