import 'package:final_project_advanced_mobile/feature/post_a_project/views/dash_board.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> widgetOptions = <Widget>[
    DashBoard(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Student Hub'),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: IconButton(onPressed: () {
              
            },icon:Icon(Icons.person)),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.amber),
            child: Center(
              child: widgetOptions[_selectedIndex],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 65,
                margin: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.black, 
                  boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(20),
                      blurRadius: 20,
                      spreadRadius: 10)
                ],
                borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.business),
                        label: 'Business',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.school),
                        label: 'School',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: Colors.amber[800],
                    onTap: _onItemTapped,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}