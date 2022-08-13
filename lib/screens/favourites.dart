import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        children: const [
          FavouritesList(),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
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
