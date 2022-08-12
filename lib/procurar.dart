import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/navigation_bloc.dart';
import 'package:myapp/custom_icons_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Procurar extends StatelessWidget {
  const Procurar({Key? key}) : super(key: key);
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
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 0) {
              BlocProvider.of<NavigationBloc>(context)
                  .add(const NavigateTo(destination: NavItem.home));
            } else {
              BlocProvider.of<NavigationBloc>(context)
                  .add(const NavigateTo(destination: NavItem.search));
            }
          },
          elevation: 0,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
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
        ),
      ),
    );
  }
}
