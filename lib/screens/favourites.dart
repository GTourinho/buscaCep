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
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              FavouritesHeader(),
              FavouritesList(),
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
    return SizedBox(
      height: ScreenUtil().setHeight(76.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          FavouritesHeaderIcon(),
          FavouritesHeaderText(),
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
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: ((context, index) => SizedBox(
                  height: ScreenUtil().setHeight(7),
                )),
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(30),
            ),
            itemCount: state.cepModels.length,
            itemBuilder: (context, index) {
              return cepContainer(context, state, index);
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

  Container cepContainer(
      BuildContext context, SavedCepsLoaded state, int index) {
    return Container(
      height: ScreenUtil().setHeight(103),
      width: ScreenUtil().setWidth(296),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.all(
          Radius.circular(ScreenUtil().setHeight(8)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  state.cepModels[index].cep,
                  style: GoogleFonts.poppins(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 89, 89, 89),
                    height: 1.4,
                    letterSpacing: 0.013,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    CustomIcons.subtract,
                    size: ScreenUtil().setHeight(20.5),
                  ),
                  color: const Color.fromARGB(255, 109, 81, 255),
                  onPressed: (() => {
                        BlocProvider.of<CepBloc>(context).add(
                          RemoveSavedCep(cepModel: state.cepModels[index]),
                        ),
                      }),
                ),
              ],
            ),
            Text(
              state.cepModels[index].complemento != ""
                  ? '${state.cepModels[index].logradouro} - ${state.cepModels[index].complemento} - ${state.cepModels[index].localidade} ${state.cepModels[index].uf} - CEP ${state.cepModels[index].cep}'
                  : '${state.cepModels[index].logradouro} - ${state.cepModels[index].localidade} ${state.cepModels[index].uf} - CEP ${state.cepModels[index].cep}',
              style: GoogleFonts.poppins(
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 69, 69, 69),
                height: 1.62,
                letterSpacing: 0.013,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
