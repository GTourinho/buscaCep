import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:myapp/custom_icons_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bloc/cep/blocs.dart';
import '../widgets/bottom_navigation.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    BlocProvider.of<CepBloc>(context).add(const GetAmounts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CepBloc, CepState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              const WelcomeBar(),
              const BackgroundImage(),
              searchAmounts(context, state),
              savedCEPS(context, state),
            ],
          ),
          bottomNavigationBar: const BottomNavigation(),
        );
      },
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
          child: welcomeBarText(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  Row welcomeBarText() {
    return Row(
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

Widget searchAmounts(BuildContext context, CepState state) {
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
      child: searchAmountsDetails(context, state),
    ),
  );
}

Column searchAmountsDetails(BuildContext context, CepState state) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        CustomIcons.signpost,
        size: ScreenUtil().setHeight(52),
        color: const Color.fromARGB(255, 180, 166, 255),
      ),
      searchAmountsDetailsText(context, state),
    ],
  );
}

Text searchAmountsDetailsText(BuildContext context, CepState state) {
  return Text.rich(
    textAlign: TextAlign.center,
    TextSpan(
      text: state is CepAmountsLoaded ? state.searchAmount.toString() : '0',
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
  );
}

Widget savedCEPS(BuildContext context, CepState state) {
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
            savedCepsDecoration(),
            savedCepsAmountBox(context, state),
          ],
        ),
      ),
    ),
  );
}

Container savedCepsAmountBox(BuildContext context, CepState state) {
  return Container(
    height: ScreenUtil().setHeight(25),
    width: ScreenUtil().setWidth(25),
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color.fromARGB(255, 123, 97, 255),
    ),
    child: Center(
      child: Text(
        state is CepAmountsLoaded ? state.savedAmount.toString() : '0',
        style: GoogleFonts.poppins(
          fontSize: ScreenUtil().setSp(13),
          fontWeight: FontWeight.w400,
          color: const Color.fromARGB(255, 255, 255, 255),
          letterSpacing: -0.00615385,
        ),
      ),
    ),
  );
}

Row savedCepsDecoration() {
  return Row(
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
  );
}
