import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../custom_icons_icons.dart';
import '../models/cep_model.dart';
import '../widgets/bottom_navigation.dart';
import '../bloc/cep/blocs.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: const [
          // SearchBar(),
          SearchResults(),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(232),
      width: ScreenUtil().setWidth(360),
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color.fromARGB(255, 109, 81, 255),
      ),
      child: Stack(
        children: [
          Positioned(
            top: ScreenUtil().setHeight(50),
            left: ScreenUtil().setWidth(32),
            child: Text(
              'Procurar CEP',
              style: GoogleFonts.poppins(
                fontSize: ScreenUtil().setSp(27),
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 255, 255, 255),
                height: 1.125,
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil().setHeight(99),
            left: ScreenUtil().setWidth(51),
            child: SizedBox(
              width: ScreenUtil().setWidth(256),
              height: ScreenUtil().setHeight(46),
              child: Text(
                'Digite o CEP que você\ndeseja procurar',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  height: 1.305,
                ),
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil().setHeight(161),
            left: ScreenUtil().setWidth(32),
            child: Container(
              height: ScreenUtil().setHeight(50),
              width: ScreenUtil().setWidth(293),
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              // Text input
              child: TextField(
                style: GoogleFonts.inter(
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 128, 128, 137),
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  // icon with padding
                  prefixIcon: Padding(
                    padding:
                        EdgeInsets.fromLTRB(ScreenUtil().setWidth(16), 0, 0, 0),
                    child: Icon(
                      CustomIcons.search,
                      color: const Color.fromARGB(255, 128, 128, 137),
                      size: ScreenUtil().setHeight(18),
                    ),
                  ),

                  border: InputBorder.none,
                  hintText: 'Digite o CEP',
                  hintStyle: GoogleFonts.inter(
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 128, 128, 137),
                    height: 1.5,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  final CepBloc _cepBloc = CepBloc();
  @override
  void initState() {
    _cepBloc.add(GetCep());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CepBloc>(
      create: (_) => _cepBloc,
      child: BlocListener<CepBloc, CepState>(
        listener: (context, state) {
          if (state is CepError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<CepBloc, CepState>(
          builder: (context, state) {
            if (state is CepInitial) {
              return Container();
            } else if (state is CepLoading) {
              return Container();
            } else if (state is CepLoaded) {
              return _buildCard(context, state.cepModel);
            } else if (state is CepError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

Widget _buildCard(BuildContext context, CepModel cepModel) {
  return Text('${cepModel.cep}');
}
