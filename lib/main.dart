import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:myapp/custom_icons_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/procurar.dart';

import 'bloc/navigation_bloc.dart';

void main() {
  runApp(BlocProvider<NavigationBloc>(
      create: (context) => NavigationBloc(
            NavigationState(currentNavItem: NavItem.home),
          ),
      child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: ((context, state) => MyApp()))));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            scaffoldBackgroundColor: Colors.white,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => MyHomePage(),
            '/search': (context) => const Procurar(),
          },
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state.currentNavItem == NavItem.search) {
          Navigator.of(context).pushNamed('/search');
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: const [
            WelcomeBar(),
            BackgroundImage(),
            SearchAmounts(),
            SavedCEPS(),
          ],
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

// Widgets

class WelcomeBar extends StatelessWidget {
  const WelcomeBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(ScreenUtil().setHeight(95)),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(32),
            ScreenUtil().setHeight(35),
            ScreenUtil().setWidth(32),
            0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Olá,\n',
                  style: GoogleFonts.poppins(
                    fontSize: ScreenUtil().setSp(27),
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 21, 21, 21),
                    height: 1.125,
                  ),
                  children: [
                    TextSpan(
                      text: 'Bem-vindo',
                      style: GoogleFonts.poppins(
                        fontSize: ScreenUtil().setSp(27),
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 21, 21, 21),
                        height: 1.125,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ScreenUtil().setHeight(27),
      left: ScreenUtil().setWidth(32),
      child: SvgPicture.asset(
        'assets/images/otwb1.svg',
        width: ScreenUtil().setWidth(500),
        height: ScreenUtil().setHeight(500),
      ),
    );
  }
}

class SearchAmounts extends StatelessWidget {
  const SearchAmounts({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ScreenUtil().setHeight(399),
      left: ScreenUtil().setWidth(79),
      child: Container(
        height: ScreenUtil().setHeight(202),
        width: ScreenUtil().setWidth(202),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(255, 109, 81, 255),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CustomIcons.signpost,
              size: ScreenUtil().setHeight(52),
              color: const Color.fromARGB(255, 180, 166, 255),
            ),
            Text.rich(
              TextSpan(
                text: '525',
                style: GoogleFonts.inter(
                  fontSize: ScreenUtil().setSp(60),
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                children: [
                  TextSpan(
                    text: '\nCEPs pesquisados',
                    style: GoogleFonts.inter(
                      fontSize: ScreenUtil().setSp(12),
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SavedCEPS extends StatelessWidget {
  const SavedCEPS({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ScreenUtil().setHeight(624),
      left: ScreenUtil().setWidth(32),
      child: Container(
        height: ScreenUtil().setHeight(57),
        width: ScreenUtil().setWidth(296),
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color.fromARGB(255, 246, 244, 255),
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(16), 0, ScreenUtil().setWidth(16), 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    CustomIcons.saved,
                    color: Color.fromARGB(255, 180, 165, 253),
                  ),
                  SizedBox(
                    height: ScreenUtil().setWidth(28.75),
                  ),
                  Text(
                    'CEPs salvos',
                    style: GoogleFonts.poppins(
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 123, 97, 255),
                      letterSpacing: -0.016,
                    ),
                  ),
                ],
              ),
              Container(
                height: ScreenUtil().setHeight(25),
                width: ScreenUtil().setWidth(25),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 123, 97, 255),
                ),
                child: Center(
                  child: Text(
                    '3',
                    style: GoogleFonts.poppins(
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      letterSpacing: -0.00615385,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
