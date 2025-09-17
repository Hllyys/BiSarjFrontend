import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app.constants.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';

import '../../../utils/app_commons.dart';

class AddBrandWidget extends StatefulWidget {
  final int? index;
  final PageController? pageController;
  final Function()? onTap;

  AddBrandWidget({this.index, this.pageController,this.onTap});

  @override
  State<AddBrandWidget> createState() => _AddBrandWidgetState();
}

class _AddBrandWidgetState extends State<AddBrandWidget> {
  int currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          TextFormField(
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              filled: true,
              hintText: 'Search',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              fillColor: Colors.grey.withOpacity(0.1),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey)),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (_, index) => Divider(height: 0),
              itemCount: 20,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return inkWellWidget(
                  onTap: () {
                    currentIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      border: Border.all(
                        color: currentIndex == index ? primaryColor : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Aiways',
                            style: PrimaryTextStyle(),
                          ),
                        ),
                        inkWellWidget(
                          onTap: () {
                            if (!currentIndex.isNegative) {
                              widget.onTap!.call();
                            }
                          },
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
