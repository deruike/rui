import 'package:flutter/material.dart';
import 'package:rui/pages/login_page.dart';

class RuiTopNavBar extends StatelessWidget {
  const RuiTopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100,
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: [
          Tab(
            child: Container(
              width: 120,
              child: Row(
                children: [
                  Icon(Icons.home),
                  Expanded(child: Text("Home")),
                  IconButton(onPressed: () {}, icon: Icon(Icons.close))
                ],
              ),
            ),
          ),
          Tab(icon: Icon(Icons.directions_transit)),
          Tab(icon: Icon(Icons.directions_bike)),
        ],
      ),
    );
  }
}
