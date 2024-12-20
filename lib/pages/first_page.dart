import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/pages/home_page.dart';
import 'package:yous_app/pages/profile_page.dart';
import 'package:yous_app/pages/qrscanner.dart';
import 'package:yous_app/states/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _selectedIndex = 0;
  AppColors appColors = AppColors();
  Repository repository = Repository();

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
  }

  final List _pages = [
    HomePage(),
    HomePage(),
    ProfilePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      body: _pages[_selectedIndex],
      floatingActionButton: Container(
        height: 56.0,
        width: 56.0,
        decoration: BoxDecoration(
          color: appColors.mainColor,
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Qrscanner()),
            );
          },
          backgroundColor: Color.fromARGB(0, 235, 17, 17),
          elevation: 0,
          child: Icon(
            Icons.qr_code_scanner,
            size: 32,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        shape: CircularNotchedRectangle(),
        color: appColors.mainColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                buildNavItem(Icons.home, 'home'.tr, 0),
                buildNavItem(Icons.reviews, 'review'.tr, 10),
              ],
            ),
            Row(
              children: [
                buildNavItem(Icons.person, 'me'.tr, 2),
                buildNavItem(Icons.help, 'report'.tr, 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        if (index != 10) {
           _navigateBottomBar(index);
        }
       
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _selectedIndex == index ? Colors.yellow : Colors.white,
            ),
            Text(
              label,
              style: TextStyle(
                color: _selectedIndex == index ? Colors.yellow : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
