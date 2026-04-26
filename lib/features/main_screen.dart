import 'package:flutter/material.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:waste_bank/features/support/binding.dart';
import 'package:waste_bank/features/support/page.dart';
import 'package:waste_bank/features/home/binding.dart';
import 'package:waste_bank/features/home/page.dart';
import 'package:waste_bank/features/market/binding.dart';
import 'package:waste_bank/features/market/page.dart';
import 'package:waste_bank/features/orders/binding.dart';
import 'package:waste_bank/features/orders/page.dart';
import 'package:waste_bank/widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            IndexedStack(
              index: _currentIndex,
              children: [
                BindingWrapper(binding: HomeBinding(), child: const HomePage()),
                BindingWrapper(binding: MarketBinding(), child: const MarketPage()),
                BindingWrapper(binding: OrdersBinding(), child: const OrdersPage()),
                BindingWrapper(binding: SupportBinding(), child: const SupportPage()),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavBar(
                currentIndex: _currentIndex,
                onTap: _changeIndex,
              ),
            ),
          ],
        ),
      );
  }
}

class BindingWrapper extends StatefulWidget {
  final Bindings binding;
  final Widget child;

  const BindingWrapper({
    super.key,
    required this.binding,
    required this.child,
  });

  @override
  State<BindingWrapper> createState() => _BindingWrapperState();
}

class _BindingWrapperState extends State<BindingWrapper> {
  @override
  void initState() {
    super.initState();
    widget.binding.dependencies(); 
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

