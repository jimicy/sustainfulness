import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _IconButtonText extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;

  const _IconButtonText(
      {super.key,
      required this.icon,
      required this.text,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey,
        ),
        Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: SizedBox(
        height: 100,
        width: 70,
        child: FittedBox(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: FloatingActionButton(
                  backgroundColor: const Color.fromRGBO(231, 212, 165, 1.0),
                  child: const Icon(color: Colors.white, Icons.car_repair),
              onPressed: () {},
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
                  icon: Icons.card_giftcard,
                  text: 'Daily card',
                  isSelected: _selectedIndex == 0),
              onPressed: () {
                _onItemTapped(0);
              },
            ),
            IconButton(
              highlightColor: Colors.white.withOpacity(0.2),
              icon: _IconButtonText(
                  icon: Icons.collections,
                  text: 'Collections',
                  isSelected: _selectedIndex == 1),
              onPressed: () {
                _onItemTapped(1);
              },
            ),
            IconButton(
              highlightColor: Colors.white.withOpacity(0.2),
              icon: _IconButtonText(
                  icon: Icons.radar_outlined,
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
