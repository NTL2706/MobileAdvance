import 'package:final_project_advanced_mobile/material_design_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTabBar extends StatefulWidget {
   CustomTabBar(
    {
      Key? key,
      required this.tabs,
      required this.tab_views,
      required this.lengOfTabBar
    }) : super(key: key);
  final tabs;
  final tab_views;
  int lengOfTabBar;
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _selectedColor = Color(0xff1a73e8);
  final _unselectedColor = Color(0xff5f6368);
  


  @override
  void initState() {
    _tabController = TabController(length: widget.lengOfTabBar, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ///Default Tabbar with full width tabbar indicator
              Expanded(
                flex: 1,
                child: TabBar(
                  controller: _tabController,
                  tabs: widget.tabs,
                  labelColor: _selectedColor,
                  indicatorColor: _selectedColor,
                  unselectedLabelColor: _unselectedColor,
                  labelPadding: EdgeInsets.all(0),
                ),
              ),
      
              Expanded(
                flex: 9,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: widget.tab_views),
                ),
              )
              ///Default Tabbar with indicator width of the label
              
            ]
              /// Custom Tabbar with transparent selected bg and solid selected text
              ///
          ),
        ),
    );
  }
}