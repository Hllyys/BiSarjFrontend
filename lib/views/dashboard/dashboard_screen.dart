import 'package:flutter/material.dart';
import 'package:frontend_bisarj/utils/app_colors.dart';
import 'package:frontend_bisarj/views/dashboard/account_screen.dart';
import 'package:frontend_bisarj/views/dashboard/booking_screen.dart';
import 'package:frontend_bisarj/views/dashboard/favorite_screen.dart';
import 'package:frontend_bisarj/views/dashboard/home_screen.dart';
import 'package:frontend_bisarj/views/wallet/wallet_screen.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';

class DashboardsScreen extends StatefulWidget {
  final int? currentIndex;

  DashboardsScreen({super.key, this.currentIndex});

  @override
  State<DashboardsScreen> createState() => _DashboardsScreenState();
}

class _DashboardsScreenState extends State<DashboardsScreen> {
  int currentIndex = 0;

  @override
  initState() {
    super.initState();
    currentIndex = widget.currentIndex ?? 0;
  }

  List<Widget> listWidget = [
    HomeScreen(),
    FavoriteScreen(),
    BookingScreen(),
    WalletScreen(),
    AccountScreen(),
  ];

  List<TabItem> items = [
    TabItem(icon: Icons.home, title: 'Home'),
    TabItem(icon: Icons.bookmark_border_outlined, title: 'Saved'),
    TabItem(icon: Icons.add_box_outlined, title: 'My Booking'),
    TabItem(icon: Icons.wallet_outlined, title: 'My Wallet'),
    TabItem(icon: Icons.person_outline_outlined, title: 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listWidget[currentIndex],
      bottomNavigationBar: BottomBarInspiredOutside(
        items: items,
        backgroundColor: Colors.white,
        colorSelected: Colors.white,
        indexSelected: currentIndex,
        isAnimated: true,
        onTap: (int index) => setState(() {
          currentIndex = index;
        }),
        top: -25,
        animated: true,
        itemStyle: ItemStyle.circle,
        chipStyle: const ChipStyle(drawHexagon: true, background: primaryColor),
        color: Colors.grey,
      ),
    );
  }
}
