import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:myapp/custom_icons_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(300),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.fromLTRB(32, 35, 172, 0),
            child: Text.rich(
              TextSpan(
                text: 'Olá,\n',
                style: GoogleFonts.poppins(
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 21, 21, 21),
                  height: 1.125,
                ),
                children: [
                  TextSpan(
                    text: 'Bem-vindo',
                    style: GoogleFonts.poppins(
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 21, 21, 21),
                      height: 1.125,
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 109, 81, 255),
        unselectedItemColor: const Color.fromARGB(255, 125, 133, 136),
        selectedLabelStyle: const TextStyle(
            fontSize: 10, fontFamily: 'poppins', fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(
            fontSize: 10, fontFamily: 'poppins', fontWeight: FontWeight.w500),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.people),
            label: 'Cadastrar',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.signpost),
            label: 'Procurar',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.star),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.heart),
            label: 'Usuários',
          ),
        ],
      ),
    );
  }
}
