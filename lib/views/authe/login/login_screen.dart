import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_assets.dart';
import 'package:frontend_bisarj/views/authe/change_password/forgot_password_screens.dart';
import 'package:frontend_bisarj/views/authe/sign_up/sign_up_screen.dart';
import 'package:frontend_bisarj/views/vehicle/vehicle_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/app_button.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_commons.dart';
import '../../../graphql/mutations.dart';
import '../otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isShow = false;
  bool isRemember = false;
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadRememberedUser(); // başlangıçta kaydedilen bilgileri getirir
  }

  // SharedPreferences’den verileri okur
  Future<void> _loadRememberedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString("savedEmail");
    final savedPassword = prefs.getString("savedPassword");
    final remember = prefs.getBool("rememberMe") ?? false;

    if (remember && savedEmail != null && savedPassword != null) {
      setState(() {
        isRemember = true;
        emailController.text = savedEmail;
        passwordController.text = savedPassword;
      });
    }
  }

  Future<void> runLogin() async {
    setState(() => isLoading = true);

    final client = GraphQLProvider.of(context).value;

    final result = await client.mutate(
      MutationOptions(
        document: gql(loginMutation),
        variables: {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        },
      ),
    );

    setState(() => isLoading = false);

    if (result.hasException) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.exception.toString())));
    } else {
      final token = result.data?['loginUser']['token'];
      final user = result.data?['loginUser']['user']; /*  */

      if (token != null) {
        final prefs = await SharedPreferences.getInstance();

        // Remember Me seçiliyse email şifreyi kaydet
        if (isRemember) {
          await prefs.setString("savedEmail", emailController.text.trim());
          await prefs.setString(
            "savedPassword",
            passwordController.text.trim(),
          );
          await prefs.setBool("rememberMe", true);
        } else {
          await prefs.remove("savedEmail");
          await prefs.remove("savedPassword");
          await prefs.setBool("rememberMe", false);
        }

        // Token  user bilgilerini kaydet
        await prefs.setString("token", token);
        print('Token kaydedildi: $token');

        await prefs.setString("userFirstName", user['firstName']);
        await prefs.setString("userLastName", user['lastName']);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const VehicleScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 100,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome!', style: BoldTextStyle(size: 25)),
            const SizedBox(height: 8),
            Text('Sign in to continue', style: PrimaryTextStyle(size: 20)),
            const SizedBox(height: 50),

            // Email
            Text('Email', style: BoldTextStyle(size: 16)),
            const SizedBox(height: 8),
            TextFormField(
              controller: emailController,
              cursorColor: primaryColor,
              decoration: inputDecoration(
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  size: 24,
                  color: primaryColor,
                ),
                hintText: 'Enter your email',
              ),
              focusNode: emailFocusNode,
              onFieldSubmitted: (val) =>
                  FocusScope.of(context).requestFocus(passwordFocusNode),
            ),

            const SizedBox(height: 16),

            // Password
            Text('Password', style: BoldTextStyle(size: 16)),
            const SizedBox(height: 8),
            TextFormField(
              controller: passwordController,
              cursorColor: primaryColor,
              obscureText: !isShow,
              decoration: inputDecoration(
                prefixIcon: const Icon(
                  Icons.lock_outline_rounded,
                  size: 24,
                  color: primaryColor,
                ),
                hintText: '••••••••••',
                suffixIcon: inkWellWidget(
                  onTap: () => setState(() => isShow = !isShow),
                  child: Icon(
                    isShow ? Icons.visibility_off : Icons.visibility,
                    size: 24,
                    color: primaryColor,
                  ),
                ),
              ),
              focusNode: passwordFocusNode,
            ),

            const SizedBox(height: 20),

            // Remember me Forgot Password
            Row(
              children: [
                Checkbox(
                  value: isRemember,
                  activeColor: primaryColor,
                  onChanged: (val) => setState(() => isRemember = val ?? false),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text('Remember Me', style: PrimaryTextStyle(size: 16)),
                ),
                inkWellWidget(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ForgotPasswordScreens(),
                    ),
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: PrimaryTextStyle(size: 16),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Sign In button
            AppButton(
              onPressed: isLoading ? null : runLogin,
              text: isLoading ? 'Signing in...' : 'Sign In',
              style: BoldTextStyle(color: Colors.white),
            ),

            const SizedBox(height: 16),

            Center(
              child: Text('Or Sign in with', style: PrimaryTextStyle(size: 14)),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                socialWidget(image: ic_google, onTap: () {}),
                const SizedBox(width: 16),
                socialWidget(
                  image: ic_phone,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OTPScreen()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // Footer
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Don\'t have an account?', style: PrimaryTextStyle(size: 16)),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignUpScreens()),
              ),
              child: Text(
                'Sign Up',
                style: BoldTextStyle(size: 16, color: primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget socialWidget({String? image, Function()? onTap}) {
    return inkWellWidget(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(defaultRadius),
          boxShadow: [
            BoxShadow(spreadRadius: 1, color: Colors.black.withOpacity(0.2)),
          ],
        ),
        child: Image.asset(image!, height: 30, width: 30),
      ),
    );
  }
}
