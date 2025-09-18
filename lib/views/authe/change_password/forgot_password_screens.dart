import 'package:flutter/material.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/graphql/mutations.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ForgotPasswordScreens extends StatefulWidget {
  const ForgotPasswordScreens({super.key});

  @override
  State<ForgotPasswordScreens> createState() => _ForgotPasswordScreensState();
}

class _ForgotPasswordScreensState extends State<ForgotPasswordScreens> {
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  String? _emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email required';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    if (!ok) return 'Geçerli bir email giriniz';
    return null;
  }

  Future<void> runForgotPassword() async {
    final err = _emailValidator(emailController.text);
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      final client = GraphQLProvider.of(context).value;
      final result = await client.mutate(
        MutationOptions(
          document: gql(forgotPasswordMutation),
          variables: {
            'email': emailController.text.trim(),
            'expiration': 15,
            'disableEmail': true,
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

      final ok = result.data?['forgotPasswordUser'] as bool?;
      if (ok == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset link sent.')),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Operation failed.')));
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

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
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text('Forgot Password?', style: BoldTextStyle(size: 20)),
              SizedBox(height: 16),
              Text(
                'Don\'t worry! Just fill in your email and we\'ll send a code to rest your password.',
                style: PrimaryTextStyle(size: 16),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              Text('Email', style: BoldTextStyle(size: 16)),
              SizedBox(height: 8),
              TextFormField(
                controller: emailController,
                cursorColor: primaryColor,
                decoration: inputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 24,
                    color: primaryColor,
                  ),
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: 30),
              AppButton(
                text: 'Send Code',
                onPressed: isLoading ? null : runForgotPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
