import 'package:flutter/material.dart';
import 'package:newpizzeria/GoogleMapPage.dart';
import 'package:newpizzeria/HomePage.dart';
import 'package:newpizzeria/ProductPage.dart';
class BottomNavigatorPage extends StatefulWidget {

  @override
  _BottomNavigatorPageState createState() => _BottomNavigatorPageState();
}
int _selectedIndex = 0; //New

class _BottomNavigatorPageState extends State<BottomNavigatorPage> {
  var _pages = [HomePage(),ProductPage(),GoogleMapPage()];

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Truck',
          ),
        ],
      ),
    );
  }
}
