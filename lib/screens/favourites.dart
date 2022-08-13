import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/custom_icons_icons.dart';
import '../bloc/cep/blocs.dart';
import '../widgets/bottom_navigation.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 180, 166, 255),
            Colors.white,
          ],
        )),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(46.06),
            left: ScreenUtil().setWidth(32),
            right: ScreenUtil().setWidth(32),
          ),
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FavouritesHeader(),
              const FavouritesList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class FavouritesHeader extends StatelessWidget {
  const FavouritesHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(76.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const FavouritesHeaderIcon(),
          const FavouritesHeaderText(),
        ],
      ),
    );
  }
}

class FavouritesHeaderIcon extends StatelessWidget {
  const FavouritesHeaderIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      CustomIcons.star,
      color: const Color.fromARGB(255, 109, 81, 255),
      size: ScreenUtil().setHeight(32.88),
    );
  }
}

class FavouritesHeaderText extends StatelessWidget {
  const FavouritesHeaderText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Meus favoritos',
      style: GoogleFonts.poppins(
        fontSize: ScreenUtil().setSp(27),
        fontWeight: FontWeight.w600,
        color: const Color.fromARGB(255, 109, 81, 255),
        height: 1.125,
      ),
    );
  }
}

class FavouritesList extends StatefulWidget {
  const FavouritesList({Key? key}) : super(key: key);

  @override
  State<FavouritesList> createState() => _FavouritesListState();
}

class _FavouritesListState extends State<FavouritesList> {
  @override
  void initState() {
    BlocProvider.of<CepBloc>(context).add(const GetSavedCeps());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CepBloc, CepState>(
      builder: (context, state) {
        if (state is SavedCepsLoaded) {
          return ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: ((context, index) => SizedBox(
                  height: ScreenUtil().setHeight(7),
                )),
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(30),
            ),
            itemCount: state.cepModels.length,
            itemBuilder: (context, index) {
              return cepContainer();
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Container cepContainer() {
    return Container(
      height: ScreenUtil().setHeight(101),
      width: ScreenUtil().setWidth(296),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.all(
          Radius.circular(ScreenUtil().setHeight(8)),
        ),
      ),
    );
  }
}
