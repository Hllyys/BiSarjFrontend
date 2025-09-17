import 'package:flutter/material.dart';
import 'package:frontend_bisarj/views/vehicle/vehicle_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../graphql/mutations.dart';

import '../../../components/app_button.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_commons.dart';

class SignUpScreens extends StatefulWidget {
  const SignUpScreens({super.key});

  @override
  State<SignUpScreens> createState() => _SignUpScreensState();
}

class _SignUpScreensState extends State<SignUpScreens> {
  bool isShow = false;

  TextEditingController firstController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode firstFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Create a new account', style: BoldTextStyle(size: 25)),
            const SizedBox(height: 20),

            /// First Name
            Text('First Name', style: BoldTextStyle()),
            const SizedBox(height: 8),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: firstController,
              decoration: inputDecoration(
                hintText: 'Enter First Name',
                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  size: 24,
                  color: primaryColor,
                ),
              ),
              focusNode: firstFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(lastNameFocusNode);
              },
              validator: fieldValidator,
            ),
            const SizedBox(height: 16),

            /// Last Name
            Text('Last Name', style: BoldTextStyle()),
            const SizedBox(height: 8),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: lastNameController,
              decoration: inputDecoration(
                hintText: 'Enter Last Name',
                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  size: 24,
                  color: primaryColor,
                ),
              ),
              focusNode: lastNameFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(emailFocusNode);
              },
              validator: fieldValidator,
            ),
            const SizedBox(height: 16),

            /// Email
            Text('Email', style: BoldTextStyle()),
            const SizedBox(height: 8),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: emailController,
              decoration: inputDecoration(
                hintText: 'andew@gmail.com',
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 24,
                  color: primaryColor,
                ),
              ),
              focusNode: emailFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(passwordFocusNode);
              },
              validator: fieldValidator,
            ),
            const SizedBox(height: 16),

            /// Password
            Text('Password', style: BoldTextStyle()),
            const SizedBox(height: 8),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: passwordController,
              obscureText: !isShow,
              decoration: inputDecoration(
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  size: 24,
                  color: primaryColor,
                ),
                hintText: '••••••••',
                suffixIcon: inkWellWidget(
                  onTap: () {
                    showPassword();
                  },
                  child: Icon(
                    isShow ? Icons.visibility_off : Icons.visibility,
                    size: 24,
                    color: primaryColor,
                  ),
                ),
              ),
              focusNode: passwordFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).unfocus();
              },
              validator: fieldValidator,
            ),
            const SizedBox(height: 20),

            /// GraphQL Mutation ile kaydetme
            Mutation(
              options: MutationOptions(
                document: gql(registerMutation),
                onCompleted: (dynamic resultData) {
                  if (resultData != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "User created: ${resultData['createUser']['email']}",
                        ),
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const VehicleScreen()),
                    );
                  }
                },
                onError: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Error: ${error?.graphqlErrors.first.message ?? "Unknown error"}",
                      ),
                    ),
                  );
                },
              ),
              builder: (RunMutation runMutation, QueryResult? result) {
                return AppButton(
                  text: 'Sign Up',
                  style: BoldTextStyle(color: Colors.white),
                  onPressed: () {
                    runMutation({
                      "firstName": firstController.text,
                      "lastName": lastNameController.text,
                      "email": emailController.text,
                      "password": passwordController.text,
                      "isAdmin": false,
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already have an account?', style: PrimaryTextStyle(size: 16)),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Sign In',
                style: BoldTextStyle(size: 16, color: primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showPassword() {
    setState(() {
      isShow = !isShow;
    });
  }
}
