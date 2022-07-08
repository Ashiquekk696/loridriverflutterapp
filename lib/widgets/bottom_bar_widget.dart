import 'package:flutter/material.dart';
import 'package:loridriverflutterapp/helpers/colors.dart';
import 'package:loridriverflutterapp/helpers/themes.dart';
import 'package:loridriverflutterapp/pages/more_page.dart';
import 'package:loridriverflutterapp/pages/orders_page.dart';
import 'package:loridriverflutterapp/pages/notification_page.dart';

import '../pages/cash_page.dart';
import '../pages/orders_page.dart';

class MainBottomNavBar extends StatefulWidget {
  MainBottomNavBar({Key? key}) : super(key: key);

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int currentIndex = 0;
  bool iconSelected = false;
  List<Widget> pages = [
    const OrdersPage(),
    const NotificationsPage(),
    const CashPage(),
    const MorePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages.elementAt(currentIndex),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          height: 70,
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed, // Fixed
              backgroundColor: Theme.of(context).primaryColor,
              unselectedFontSize: 12,
              selectedFontSize: 12,
              selectedItemColor: AppColors.lightGreen,
              unselectedItemColor: Colors.white,
              currentIndex: currentIndex,
              onTap: (index) {
                currentIndex = index;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                  label: "Orders",
                  icon: Image.asset(
                    "assets/images/comment.png",
                    height: 30,
                    color: Colors.white,
                  ),
                  activeIcon: Image.asset("assets/images/comment.png",
                      height: 30, color: AppColors.lightGreen),
                ),
                BottomNavigationBarItem(
                  label: "Notification",
                  icon: Image.asset(
                    "assets/images/user.png",
                    height: 30,
                    color: Colors.white,
                  ),
                  activeIcon: Image.asset("assets/images/user.png",
                      height: 30, color: AppColors.lightGreen),
                ),
                BottomNavigationBarItem(
                  label: "Cash",
                  icon: Image.asset(
                    "assets/images/cashbalance.png",
                    height: 30,
                    color: Colors.white,
                  ),
                  activeIcon: Image.asset("assets/images/cashbalance.png",
                      height: 30, color: AppColors.lightGreen),
                ),
                BottomNavigationBarItem(
                  label: "More",
                  icon: Icon(
                    Icons.more,
                    color: Colors.white,
                  ),
                  activeIcon: Icon(Icons.more, color: AppColors.lightGreen),
                ),
              ]),
        ),
      ),
    );
  }
}
