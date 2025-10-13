import 'package:flutter/material.dart';
import 'package:pizza/models/navigation.dart';

class Navigatorbar extends StatefulWidget {
  const Navigatorbar({super.key, required this.navigation});
  final NavigationProvider navigation;
  @override
  State<Navigatorbar> createState() => _NavigatorbarState();
}

class _NavigatorbarState extends State<Navigatorbar> {
  final List<IconData> _icons = [
    Icons.home,
    Icons.shopping_bag,
    Icons.favorite,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 75,
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_icons.length, (index) {
          final isSelected = index == widget.navigation.selectedIndex;
          return InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              widget.navigation.changePage(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : Colors.transparent,
              ),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 250),
                scale: isSelected ? 1.2 : 1.0,
                curve: Curves.easeOutBack,
                child: Icon(
                  _icons[index],
                  size: 30,
                  color: isSelected
                      ? const Color(0xFFEF1C26)
                      : const Color(0xff8E8E8E),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
