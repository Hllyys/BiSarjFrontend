import 'package:flutter/material.dart';
import 'package:frontend_bisarj/views/vehicle/vehicle_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isLoading = false;

  final TextEditingController firstController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final FocusNode firstFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();

  @override
  void dispose() {
    firstController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();

    firstFocusNode.dispose();
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    addressFocusNode.dispose();
    super.dispose();
  }

  Future<void> runSignUp() async {
    if (firstController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final client = GraphQLProvider.of(context).value;

      final result = await client.mutate(
        MutationOptions(
          document: gql(registerMutation),
          variables: {
            "firstName": firstController.text.trim(),
            "lastName": lastNameController.text.trim(),
            "email": emailController.text.trim(),
            "password": passwordController.text,
            "address": addressController.text.trim(),
            "isAdmin": false,
          },
        ),
      );

      setState(() => isLoading = false);

      if (result.hasException) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(result.exception.toString())));
        return;
      }

      final created = result.data?['createUser'];
      if (created == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to create user')));
        return;
      }

      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('lastSignedUpEmail', emailController.text.trim());
        await prefs.setString(
          'lastSignedUpAddress',
          addressController.text.trim(),
        ); // NEW
      } catch (_) {}

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User created: ${created['email']}')),
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const VehicleScreen()),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void showPassword() {
    setState(() => isShow = !isShow);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(context, onTap: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Create a new account', style: BoldTextStyle(size: 25)),
            const SizedBox(height: 20),

            // First Name
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
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(lastNameFocusNode),
              validator: fieldValidator,
            ),
            const SizedBox(height: 16),

            // Last Name
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
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(emailFocusNode),
              validator: fieldValidator,
            ),
            const SizedBox(height: 16),

            // Email
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
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(passwordFocusNode),
              validator: fieldValidator,
            ),
            const SizedBox(height: 16),

            // Password
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
                  onTap: showPassword,
                  child: Icon(
                    isShow ? Icons.visibility_off : Icons.visibility,
                    size: 24,
                    color: primaryColor,
                  ),
                ),
              ),
              focusNode: passwordFocusNode,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(addressFocusNode),
              validator: fieldValidator,
            ),
            const SizedBox(height: 16),

            Text('Address', style: BoldTextStyle()),
            const SizedBox(height: 8),
            TextFormField(
              controller: addressController,
              decoration: inputDecoration(
                hintText: 'Enter your address (optional)',
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  size: 24,
                  color: primaryColor,
                ),
              ),
              focusNode: addressFocusNode,
            ),
            const SizedBox(height: 20),

            // Submit
            AppButton(
              text: isLoading ? 'Please wait...' : 'Sign Up',
              style: BoldTextStyle(color: Colors.white),
              onPressed: isLoading ? null : runSignUp,
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
              onPressed: () => Navigator.pop(context),
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
}
