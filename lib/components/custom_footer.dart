import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(), // Notch for the FAB
      notchMargin: 6.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Spread the icons evenly across the footer
        children: <Widget>[
          _buildTabItem(
            icon: Icons.home,
            text: 'Home',
          ),
          _buildTabItem(
            icon: Icons.search,
            text: 'Search',
          ),
          SizedBox(width: 48), // The placeholder for the floating action button
          _buildTabItem(
            icon: Icons.notifications,
            text: 'Alerts',
          ),
          _buildTabItem(
            icon: Icons.person,
            text: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required IconData icon,
    required String text,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon),
        Text(text),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Footer Example')),
      body: Center(child: Text('Content goes here')),
      bottomNavigationBar: CustomFooter(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the floating button
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // This docks the FAB in the center
    );
  }
}

void main() {
  runApp(MaterialApp(home: MyHomePage()));
}
