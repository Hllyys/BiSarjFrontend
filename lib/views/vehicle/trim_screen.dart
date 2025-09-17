import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app_commons.dart';

class TrimScreen extends StatefulWidget {
  const TrimScreen({super.key});

  @override
  State<TrimScreen> createState() => _TrimScreenState();
}

class _TrimScreenState extends State<TrimScreen> {
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
              separatorBuilder: (_, index) => Divider(),
              itemCount: 20,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return inkWellWidget(
                  onTap: () {
                    //
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '40 w/Supercharger',
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
          ),
        ],
      ),
    );
  }
}
