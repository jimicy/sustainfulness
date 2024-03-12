import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:global_citizen_game/app/gallery/view/gallery_page.dart';
import 'package:global_citizen_game/daily_card/view/daily_card_page.dart';
import 'package:global_citizen_game/game/view/game_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _IconButtonText extends StatelessWidget {
  final String iconAssetPath;
  final String text;
  final bool isSelected;

  const _IconButtonText(
      {super.key,
      required this.iconAssetPath,
      required this.text,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: isSelected ? 1.0 : 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              iconAssetPath,
              height: 30,
              fit: BoxFit.fitHeight,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ));
  }
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    DailyCardPage(),
    GalleryPage(),
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
      backgroundColor: Color.fromRGBO(119, 152, 170, 1.0),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      extendBody: true,
      floatingActionButton: SizedBox(
        height: 100,
        width: 70,
        child: FittedBox(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: FloatingActionButton(
              backgroundColor: const Color.fromRGBO(231, 212, 165, 1.0),
              child: SvgPicture.asset(
                'assets/images/nav_icons/net.svg',
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const GameWebView();
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.fromLTRB(90, 0, 0, 0),
        height: 80,
        color: const Color.fromRGBO(78, 109, 127, 1.0),
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              highlightColor: Colors.white.withOpacity(0.2),
              icon: _IconButtonText(
                  iconAssetPath: 'assets/images/nav_icons/daily_card.svg',
                  text: 'Daily card',
                  isSelected: _selectedIndex == 0),
              onPressed: () {
                _onItemTapped(0);
              },
            ),
            IconButton(
              highlightColor: Colors.white.withOpacity(0.2),
              icon: _IconButtonText(
                  iconAssetPath: 'assets/images/nav_icons/collections.svg',
                  text: 'Collections',
                  isSelected: _selectedIndex == 1),
              onPressed: () {
                _onItemTapped(1);
              },
            ),
            IconButton(
              highlightColor: Colors.white.withOpacity(0.2),
              icon: _IconButtonText(
                  iconAssetPath: 'assets/images/nav_icons/energy_map.svg',
                  text: 'Energy Map',
                  isSelected: _selectedIndex == 2),
              onPressed: () {
                _onItemTapped(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}
