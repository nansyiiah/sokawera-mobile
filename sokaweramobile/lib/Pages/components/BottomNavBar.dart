import 'package:flutter/material.dart';
import 'package:sokaweramobile/Pages/InputScreen.dart';
import 'package:sokaweramobile/Pages/ListScreen.dart';
import 'package:sokaweramobile/Pages/DashboardScreen/DashboardScreen.dart';
import 'package:sokaweramobile/Pages/Testing/new.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  late List<Widget> _children;

  @override
  void initState() {
    _currentIndex = 0;

    _children = [
      DashboardScreen(),
      InputScreen(),
      ListScreen(),
      // NewDart(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.house_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.input_outlined),
            label: "Input data",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list_outlined),
            label: "View data",
          ),
        ],
      ),
    );
  }
}
