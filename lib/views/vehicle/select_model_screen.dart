import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';

class SelectModelScreen extends StatefulWidget {
  const SelectModelScreen({super.key});

  @override
  State<SelectModelScreen> createState() => _SelectModelScreenState();
}

class _SelectModelScreenState extends State<SelectModelScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        separatorBuilder: (_, index) => Divider(),
        itemCount: 8,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return inkWellWidget(
            onTap: () {
             //
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Model S',
                      style: PrimaryTextStyle(),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
