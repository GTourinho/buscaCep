import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/navigation/blocs.dart';
import '../widgets/bottom_navigation.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state.currentNavItem == NavItem.home) {
          Navigator.pop(context);
          Navigator.of(context).pushNamed('/');
        }
        if (state.currentNavItem == NavItem.search) {
          Navigator.pop(context);
          Navigator.of(context).pushNamed('/search');
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: const [],
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}
