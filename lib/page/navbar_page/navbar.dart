import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:ht_movie/page/home/home_Page.dart';
import 'search_page.dart';
import 'library_page.dart';
import 'profile_page.dart';

class Navbar extends StatefulWidget {
  @override
  _Navbar createState() => _Navbar();
}

class _Navbar extends State<Navbar> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  // list màn hình
  List<Widget> _buildScreens(){
    return [
      HomePage(),
      SearchPage(),
      LibraryPage(),
      ProfilePage(),
    ];
  }

  // custom navbar
  List<PersistentBottomNavBarItem> _navBarsItems(){
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_outlined,color: Colors.white,),
        title: "Home",
        activeColorPrimary: const Color.fromARGB(255, 169, 79, 187),
        inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
        icon: Icon(Icons.search,color: Colors.white,),
        title: "Search",
        activeColorPrimary: const Color.fromARGB(255, 169, 79, 187),
        inactiveColorPrimary: Colors.grey,
        ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/images/library.png",color: Colors.white,),
        title: "Library",
        activeColorPrimary: const Color.fromARGB(255, 169, 79, 187),
        inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
        icon: Icon(Icons.person_outlined,color: Colors.white,),
        title: "Profile",
        activeColorPrimary: const Color.fromARGB(255, 169, 79, 187),
        inactiveColorPrimary: Colors.grey,
        ),
        
    ];
  }


  Widget build(BuildContext context) {
    return PersistentTabView(
      context, 
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style1,
      backgroundColor: Colors.transparent,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(40),
        colorBehindNavBar: Colors.transparent,
        border: Border.all(
          color: const Color.fromARGB(255, 133, 132, 132),
          width: 1.2,
        ),
      ),
      margin: EdgeInsets.all(8),
      navBarHeight: 70,
      );
  }
}