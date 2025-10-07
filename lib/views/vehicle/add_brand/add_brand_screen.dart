import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../graphql/mutations.dart';
import '../../../graphql/graphql_client.dart';
import '../../../components/app_button.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_commons.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AddBrandScreen extends StatefulWidget {
  const AddBrandScreen({super.key});

  @override
  State<AddBrandScreen> createState() => _AddBrandScreenState();
}

class _AddBrandScreenState extends State<AddBrandScreen>
    with TickerProviderStateMixin {
  TextEditingController carNumberController = TextEditingController();
  bool isBook = false;
  bool isLoading = false;

  Future<void> createBrand() async {
    final brandName = carNumberController.text.trim();
    if (brandName.isEmpty) {
      commonSnackBar(message: 'Please enter a brand name');
      return;
    }

    setState(() => isLoading = true);

    try {
      final client = await buildGraphQLClient();

      final result = await client.value.mutate(
        MutationOptions(
          document: gql(createCarBrandMutation),
          variables: {'name': brandName},
        ),
      );

      if (result.hasException) {
        print(result.exception.toString());
        commonSnackBar(
          message: 'Failed to create brand',
          contentType: ContentType.failure,
        );
      } else {
        setState(() => isBook = true);

        commonSnackBar(
          message: 'Brand added successfully!',
          contentType: ContentType.success,
        );

        await Future.delayed(const Duration(milliseconds: 800));
        if (mounted) Navigator.pop(context, true); // Refresh sinyali gönder
      }
    } catch (e) {
      print(e);
      commonSnackBar(
        message: 'Error occurred',
        contentType: ContentType.failure,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(
          context,
          onTap: () => Navigator.pop(context, false),
        ),
        title: Text('Add New Vehicle', style: BoldTextStyle(size: 16)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isBook)
              TextField(
                controller: carNumberController,
                decoration: inputDecoration(
                  hintText: "Enter brand name",
                  prefixIcon: const Icon(
                    Icons.electric_car,
                    color: Colors.green,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            if (isBook)
              Lottie.asset(ic_successful, height: 120, fit: BoxFit.fill),
            const SizedBox(height: 16),
            AppButton(
              text: isBook ? "Continue" : "Add Brand",
              onPressed: () async {
                if (isBook) {
                  Navigator.pop(context, true); //  Refresh işareti
                } else {
                  await createBrand();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
