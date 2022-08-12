import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/navigation/blocs.dart';
import '../widgets/bottom_navigation.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: const [],
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
