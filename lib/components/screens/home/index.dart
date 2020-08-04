import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hdman/components/screens/bill/index.dart';
import 'package:hdman/components/screens/explore/index.dart';
import 'package:hdman/components/screens/favorite/index.dart';
import 'package:hdman/components/screens/notification/index.dart';
import 'package:hdman/components/screens/order/index.dart';
import 'package:hdman/components/screens/profile/index.dart';
import 'package:hdman/components/screens/stores/index.dart';
import 'package:hdman/provider/model/market.dart';
import 'package:hdman/widget/TextFix.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static int _countProduct = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetUser = <Widget>[
    ExploreScreen(),
    BillScreen(),
    FavoriteScreen(),
    ProfileScreen()
  ];

  static List<Widget> _widgetMarket = <Widget>[
    StoresScreen(),
    OrderScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];

  List<BottomNavigationBarItem> BottomUser = [
    BottomNavigationBarItem(
      icon: Icon(Icons.explore),
      title: TextFix(
        title: 'สำรวจ',
      ),
    ),
    BottomNavigationBarItem(
      icon: _countProduct > 0
          ? Stack(children: <Widget>[
              Icon(Icons.receipt),
              Positioned(
                // draw a red marble
                top: 0.0,
                right: 0.0,
                child: Icon(Icons.brightness_1,
                    size: 10.0, color: Colors.redAccent),
              )
            ])
          : Icon(Icons.receipt),
      title: TextFix(
        title: 'รายการ',
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      title: TextFix(
        title: 'รายการโปรด',
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: TextFix(
        title: 'โปรไฟล์',
      ),
    ),
  ];

  List<BottomNavigationBarItem> BottomMarket = [
    BottomNavigationBarItem(
      icon: Icon(Icons.store),
      title: TextFix(
        title: 'ร้านค้า',
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.receipt),
      title: TextFix(
        title: 'รายการ',
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.inbox),
      title: TextFix(
        title: 'กล่องข้อความ',
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: TextFix(
        title: 'โปรไฟล์',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final marketProvider = Provider.of<MarketProvider>(context, listen: false);

    return Scaffold(
      body: Container(
        child: Center(
            child: marketProvider.color
                ? _widgetMarket.elementAt(_selectedIndex)
                : _widgetUser.elementAt(_selectedIndex)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: marketProvider.color ? Colors.grey : null,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: marketProvider.color ? BottomMarket : BottomUser,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
    );
  }
}
