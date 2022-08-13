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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 180, 166, 255),
                Colors.white,
              ],
            )),
          ),
          const FavouritesHeaderIcon(),
          const FavouritesHeaderText(),
          // FavouritesList(),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class FavouritesHeaderIcon extends StatelessWidget {
  const FavouritesHeaderIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: ScreenUtil().setWidth(30.56),
      top: ScreenUtil().setHeight(46.94),
      child: Icon(
        CustomIcons.star,
        color: const Color.fromARGB(255, 109, 81, 255),
        size: ScreenUtil().setHeight(32.88),
      ),
    );
  }
}

class FavouritesHeaderText extends StatelessWidget {
  const FavouritesHeaderText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ScreenUtil().setHeight(93),
      left: ScreenUtil().setWidth(32),
      child: Text(
        'Meus favoritos',
        style: GoogleFonts.poppins(
          fontSize: ScreenUtil().setSp(27),
          fontWeight: FontWeight.w600,
          color: const Color.fromARGB(255, 109, 81, 255),
          height: 1.125,
        ),
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
          return ListView.builder(
            itemCount: state.cepModels.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.cepModels[index].cep),
                subtitle: Text(state.cepModels[index].cep),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // BlocProvider.of<CepBloc>(context).add(const DeleteCep(cepModel: state.cepModels[index]));
                  },
                ),
              );
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
}
