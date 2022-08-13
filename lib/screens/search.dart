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
    return BlocProvider(
      create: (context) => CepBloc(),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(ScreenUtil().setHeight(232)),
            child: const SearchBar()),
        body: const SearchResults(),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();

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
          searchBarHeader(),
          searchBarText(),
          searchContainer(context)
        ],
      ),
    );
  }

  Positioned searchContainer(BuildContext context) {
    return Positioned(
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
        child: searchTextField(context),
      ),
    );
  }

  TextField searchTextField(BuildContext context) {
    return TextField(
      controller: _controller,
      onSubmitted: (value) =>
          BlocProvider.of<CepBloc>(context).add(GetCep(cep: value)),
      style: GoogleFonts.inter(
        fontSize: ScreenUtil().setSp(14),
        fontWeight: FontWeight.w400,
        color: const Color.fromARGB(255, 128, 128, 137),
        height: 1.5,
      ),
      decoration: searchDecoration(),
    );
  }

  InputDecoration searchDecoration() {
    return InputDecoration(
      prefixIcon: Padding(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(16), 0, 0, 0),
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
    );
  }

  Positioned searchBarText() {
    return Positioned(
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
    );
  }

  Positioned searchBarHeader() {
    return Positioned(
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
    );
  }
}

class SearchResults extends StatelessWidget {
  const SearchResults({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<CepBloc, CepState>(
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
          } else if (state is CepSaved) {
            return _buildCard(context, state.cepModel);
          } else if (state is CepError) {
            return Container();
          } else if (state is CepError) {
            return Container();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

Widget _buildCard(BuildContext context, CepModel cepModel) {
  final bool isCepSaved =
      BlocProvider.of<CepBloc>(context).state is CepSaved ? true : false;
  return Padding(
    padding: EdgeInsets.only(
      left: ScreenUtil().setWidth(32),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cepDetailsHeader(),
        Padding(padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(17))),
        cepDetails(cepModel),
        Padding(padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(29))),
        saveCepButton(
          context,
          cepModel,
          isCepSaved,
        ),
      ],
    ),
  );
}

Text cepDetailsHeader() {
  return Text(
    'Endereço:',
    textAlign: TextAlign.start,
    style: GoogleFonts.poppins(
      fontSize: ScreenUtil().setSp(19),
      fontWeight: FontWeight.w500,
      color: const Color.fromARGB(255, 109, 81, 255),
      letterSpacing: 0.013,
      height: 1.11,
    ),
  );
}

Text cepDetails(CepModel cepModel) {
  return Text(
    '${cepModel.logradouro} - ${cepModel.complemento} - ${cepModel.localidade} ${cepModel.uf} -\nCEP ${cepModel.cep}',
    style: GoogleFonts.poppins(
      fontSize: ScreenUtil().setSp(15),
      fontWeight: FontWeight.w400,
      color: const Color.fromARGB(255, 0, 0, 0),
      letterSpacing: 0.013,
      height: 1.4,
    ),
  );
}

Widget saveCepButton(BuildContext context, CepModel cepModel, bool isCepSaved) {
  return InkWell(
    onTap: isCepSaved
        ? () {
            BlocProvider.of<CepBloc>(context).add(const GetSavedCeps());
          }
        : () {
            BlocProvider.of<CepBloc>(context).add(SaveCep(cepModel: cepModel));
          },
    child: Container(
      width: ScreenUtil().setWidth(296),
      height: ScreenUtil().setHeight(48),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isCepSaved
            ? const Color.fromARGB(255, 245, 245, 248)
            : const Color.fromARGB(255, 46, 23, 157),
        borderRadius: const BorderRadius.all(
          Radius.circular(72),
        ),
      ),
      child: saveCepDecoration(isCepSaved),
    ),
  );
}

Padding saveCepDecoration(bool isCepSaved) {
  return Padding(
    padding: EdgeInsets.only(
      left: ScreenUtil().setWidth(23),
      right: ScreenUtil().setWidth(23),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isCepSaved
            ? Icon(
                CustomIcons.starsaved,
                color: const Color.fromARGB(255, 234, 183, 1),
                size: ScreenUtil().setHeight(24),
              )
            : Icon(
                CustomIcons.star,
                color: const Color.fromARGB(255, 180, 166, 255),
                size: ScreenUtil().setHeight(24),
              ),
        Text(
          'Adicionar aos favoritos',
          style: GoogleFonts.hind(
            fontSize: ScreenUtil().setSp(16),
            fontWeight: FontWeight.w500,
            color: isCepSaved
                ? const Color.fromARGB(255, 123, 97, 255)
                : const Color.fromARGB(255, 255, 255, 255),
            letterSpacing: 0.013,
            height: 1,
          ),
        ),
        SizedBox(
          width: ScreenUtil().setHeight(24),
        ),
      ],
    ),
  );
}
