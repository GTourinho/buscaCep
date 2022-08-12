import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: const [],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
