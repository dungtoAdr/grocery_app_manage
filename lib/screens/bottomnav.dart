import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:grocery_manager_app/models/category.dart';
import 'package:grocery_manager_app/providers/category_provider.dart';
import 'package:grocery_manager_app/screens/home_screen.dart';
import 'package:grocery_manager_app/screens/order_screen.dart';
import 'package:grocery_manager_app/screens/chart_screen.dart';
import 'package:grocery_manager_app/screens/user_screen.dart';
import 'package:provider/provider.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late HomeScreen homePage;
  late ChartScreen chartPage;
  late OrderScreen orderPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePage = HomeScreen();
    chartPage = ChartScreen();
    orderPage = OrderScreen();
    pages = [homePage, chartPage, orderPage];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 500),
        color: Colors.blue,
        onTap: (value) {
          setState(() {});
          currentTabIndex = value;
        },
        items: [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.ac_unit_rounded, color: Colors.white),
          Icon(Icons.access_alarm_rounded, color: Colors.white),
        ],
      ),
      body: pages[currentTabIndex],

    );
  }
}
