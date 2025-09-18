import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frontend_bisarj/components/app_button.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import 'package:frontend_bisarj/utils/app_assets.dart';
import 'package:frontend_bisarj/graphql/mutations.dart';

class PersonalInfoScreens extends StatefulWidget {
  const PersonalInfoScreens({super.key});

  @override
  State<PersonalInfoScreens> createState() => _PersonalInfoScreensState();
}

class _PersonalInfoScreensState extends State<PersonalInfoScreens>
    with TickerProviderStateMixin {
  // anim
  late final AnimationController _animCtrl;
  late final Animation<double> _fade;

  // state
  bool _isLoading = false;
  int? _userId;

  // controllers
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();

  // focus
  final emailFocusNode = FocusNode();
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final addressFocusNode = FocusNode();

  // avatar (şimdilik sadece UI)
  final ImagePicker picker = ImagePicker();
  XFile? image;
  String userProfile = '';

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    )..forward();
    _fade = CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn);

    // context tamamen mount edildikten sonra meUser çağrısı
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadMe());
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();

    emailFocusNode.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    addressFocusNode.dispose();

    _animCtrl.dispose();
    super.dispose();
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'This field is required ' : null;

  Future<void> _loadMe() async {
    try {
      final client = GraphQLProvider.of(context).value;
      final res = await client.query(
        QueryOptions(
          document: gql(meUserQuery),
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (res.hasException) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to retrieve profile: ${res.exception}'),
          ),
        );
        return;
      }

      final u = res.data?['meUser']?['user'];
      if (u == null) return;

      _userId = u['id'] as int?;
      emailController.text = (u['email'] ?? '') as String;
      firstNameController.text = (u['firstName'] ?? '') as String;
      lastNameController.text = (u['lastName'] ?? '') as String;
      addressController.text = (u['address'] ?? '') as String;

      if (!mounted) return;
      setState(() {});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Hata: $e')));
    }
  }

  Future<void> _runUpdate() async {
    if (!formKey.currentState!.validate()) return;
    if (_userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('User not found')));
      return;
    }

    setState(() => _isLoading = true);
    try {
      final client = GraphQLProvider.of(context).value;

      final res = await client.mutate(
        MutationOptions(
          document: gql(updateUserMutation),
          variables: {
            'id': _userId,
            'data': {
              'firstName': firstNameController.text.trim(),
              'lastName': lastNameController.text.trim(),
              'email': emailController.text.trim(),
              'address': addressController.text.trim().isEmpty
                  ? null
                  : addressController.text.trim(),
            },
          },
        ),
      );

      setState(() => _isLoading = false);

      if (res.hasException) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(res.exception.toString())));
        return;
      }

      if (res.data?['updateUser'] != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Information updated')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('update failed')));
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: Scaffold(
        appBar: AppBar(
          leading: backButton(context, onTap: () => Navigator.pop(context)),
          title: Text('Personal Info', style: BoldTextStyle()),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Center(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: image != null
                            ? Image.file(
                                File(image!.path),
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                            : (userProfile.isNotEmpty
                                  ? Image.network(
                                      userProfile,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      ic_person,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: inkWellWidget(
                          onTap: () async {
                            image = await picker.pickImage(
                              source: ImageSource.camera,
                            );
                            setState(() {});
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Email
                Text('Email', style: BoldTextStyle()),
                const SizedBox(height: 8),
                TextFormField(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: inputDecoration(hintText: 'Enter your email'),
                  validator: (v) {
                    if (_required(v) != null) return 'Email required';
                    final ok = RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    ).hasMatch(v!.trim());
                    return ok ? null : 'Enter a valid email';
                  },
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(firstNameFocusNode),
                ),
                const SizedBox(height: 16),

                // First Name
                Text('First Name', style: BoldTextStyle()),
                const SizedBox(height: 8),
                TextFormField(
                  controller: firstNameController,
                  focusNode: firstNameFocusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: inputDecoration(hintText: 'First Name'),
                  validator: _required,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(lastNameFocusNode),
                ),
                const SizedBox(height: 16),

                // Last Name
                Text('Last Name', style: BoldTextStyle()),
                const SizedBox(height: 8),
                TextFormField(
                  controller: lastNameController,
                  focusNode: lastNameFocusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: inputDecoration(hintText: 'Last Name'),
                  validator: _required,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(addressFocusNode),
                ),
                const SizedBox(height: 16),

                // Address
                Text('Street Address', style: BoldTextStyle()),
                const SizedBox(height: 8),
                TextFormField(
                  controller: addressController,
                  focusNode: addressFocusNode,
                  decoration: inputDecoration(hintText: 'Enter address'),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: AppButton(
            text: _isLoading ? 'Saving...' : 'Submit',
            onPressed: _isLoading ? null : _runUpdate,
          ),
        ),
      ),
    );
  }
}
