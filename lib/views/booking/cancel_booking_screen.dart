import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';
import '../../components/alert_dailog_widget.dart';
import '../../components/app_button.dart';
import '../../model/payment_model.dart';
import '../../utils/app_data_provider.dart';

class CancelBookingScreen extends StatefulWidget {
  CancelBookingScreen(this.bookingId);

  final String bookingId;

  @override
  State<CancelBookingScreen> createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  List<PaymentModel> cancelList = CancelList();

  int cancelBookingIndex = 1;

  String cancelString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel Booking', style: BoldTextStyle()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose the reason for your cancellation:',
                style: BoldTextStyle()),
            SizedBox(height: 16),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cancelList.length,
              itemBuilder: (_, index) {
                return RadioListTile(
                  value: index,
                  groupValue: cancelBookingIndex,
                  activeColor: primaryColor,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (val) {
                    changeBookingStatus(val!);
                    cancelString = cancelList[index].title!;
                  },
                  title: Text(cancelList[index].title!, style: BoldTextStyle()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8),
        child: AppButton(
          text: 'Submit',
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel:
                  MaterialLocalizations.of(context).modalBarrierDismissLabel,
              pageBuilder: (ctx, a1, a2) {
                return Container();
              },
              transitionBuilder: (ctx, a1, a2, child) {
                var curve = Curves.easeInOut.transform(a1.value);
                return AlertDialogWidget(
                  scale: curve,
                  title: 'Successful Cancellation!',
                  subTitle: 'Your booking has been successful cancelled.',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                );
              },
              transitionDuration: const Duration(milliseconds: 300),
            );
          },
          padding: EdgeInsets.all(8),
        ),
      ),
    );
  }

  changeBookingStatus(int index) {
    cancelBookingIndex = index;
    setState(() {});
  }
}
