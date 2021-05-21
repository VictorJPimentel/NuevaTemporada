// import 'package:flutter/material.dart';

// class MotionBar extends StatelessWidget {
//    MotionTabController _tabController;
//   @override
//   void initState() {
//     super.initState();
//     _tabController = new MotionTabController(initialIndex:1,vsync: this);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _tabController.dispose();
//   }
// flutter pub add motion_tab_bar
//   bottomNavigationBar: MotionTabBar(
//           labels: [
//             "Account","Home","Dashboard"
//           ],
//           initialSelectedTab: "Home",
//           tabIconColor: Colors.green,
//           tabSelectedColor: Colors.red,
//           onTabItemSelected: (int value){
//                print(value);
//                setState(() {
//                   _tabController.index = value;
//                });
//           },
//           icons: [
//             Icons.account_box,Icons.home,Icons.menu
//           ],
//           textStyle: TextStyle(color: Colors.red),
//   ),
//   }

// mixin MotionTabController {
// }
