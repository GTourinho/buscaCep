import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/screens/search.dart';
import '../bloc/navigation/blocs.dart';

void main() {
  runApp(BlocProvider<NavigationBloc>(
      create: (context) => NavigationBloc(
            const NavigationState(currentNavItem: NavItem.home),
          ),
      child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: ((context, state) => const MyApp()))));
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
            '/': (context) => const Home(),
            '/search': (context) => const Search(),
          },
        );
      },
    );
  }
}
