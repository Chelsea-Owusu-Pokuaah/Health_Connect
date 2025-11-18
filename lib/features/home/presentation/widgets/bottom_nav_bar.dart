import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:health_connect/core/themes/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _current = 0;

  void _onTap(int idx) {
    setState(() => _current = idx);

    switch (idx) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/chat_list');          // UPDATED
        break;
      case 2:
        context.go('/create_appointment');
        break;
      case 3:
        context.go('/schedule');
        break;
      case 4:
        context.go('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,                 // FIXED (from teal to white)
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            index: 0,
            current: _current,
            asset: 'assets/icons/home.svg',
            onTap: _onTap,
          ),
          _NavItem(
            index: 1,
            current: _current,
            asset: 'assets/icons/message.svg',
            onTap: _onTap,
          ),

          // Center ADD button
          GestureDetector(
            onTap: () => _onTap(2),
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: AppColors.primary,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/add.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),

          _NavItem(
            index: 3,
            current: _current,
            asset: 'assets/icons/calendar.svg',
            onTap: _onTap,
          ),
          _NavItem(
            index: 4,
            current: _current,
            asset: 'assets/icons/settings.svg',
            onTap: _onTap,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int current;
  final String asset;
  final Function(int) onTap;

  const _NavItem({
    required this.index,
    required this.current,
    required this.asset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = index == current;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? AppColors.primary : Colors.white,
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: SvgPicture.asset(
            asset,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              isActive ? Colors.white : const Color(0xFF7C7C7C),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
