import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/navigation/navigation_bloc.dart';
import '../bloc/navigation/navigation_event.dart';
import '../bloc/navigation/navigation_state.dart';
import '../custom_icons_icons.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
      return BottomNavigationBar(
        currentIndex: state.currentNavItem.index,
        onTap: (index) {
          BlocProvider.of<NavigationBloc>(context)
              .add(NavigateTo(destination: NavItem.values[index]));
        },
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 109, 81, 255),
        unselectedItemColor: const Color.fromARGB(255, 125, 133, 136),
        selectedLabelStyle: TextStyle(
            fontSize: ScreenUtil().setSp(10),
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(
            fontSize: ScreenUtil().setSp(10),
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.signpost),
            label: 'Procurar',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.star),
            label: 'Favoritos',
          ),
        ],
      );
    });
  }
}
