import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:myapp/bloc/cep/blocs.dart';
import '../../models/cep_model.dart';
import '../../resources/api_repository.dart';

class CepBloc extends Bloc<CepEvent, CepState> {
  CepBloc() : super(CepInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    final LocalStorage storage = LocalStorage('ceps');

    List<CepModel> cepModels = [];

    getSearchAmount() async {
      await storage.ready;
      final searchAmount = await storage.getItem('searchAmount');
      return searchAmount != null ? int.parse(searchAmount) : 0;
    }

    getSavedAmount() async {
      await storage.ready;
      final savedAmount = await storage.getItem('savedAmount');
      return savedAmount != null ? int.parse(savedAmount) : 0;
    }

    on<GetAmounts>((event, emit) async {
      await storage.ready;
      emit(CepAmountsLoading());
      final int searchAmount = await getSearchAmount();
      final int savedAmount = await getSavedAmount();
      emit(CepAmountsLoaded(searchAmount, savedAmount));
    });

    on<GetCep>((event, emit) async {
      try {
        emit(CepLoading());
        final mList = await apiRepository.fetchCepList(event.cep);

        if (mList.error != '') {
          emit(CepError(mList.error));
        }
        if (mList.cep == '') {
          emit(const CepError(
              "Não conseguimos localizar seu endereço, verifique se as informações passadas estão corretas"));
        } else {
          emit(CepLoaded(mList));
          final searchAmount = await getSearchAmount();
          await storage.ready;
          await storage.setItem('searchAmount', (searchAmount + 1).toString());
        }
      } on NetworkError {
        emit(
          const CepError(
              "Falha ao buscar dados. Verifique sua conexão com a internet"),
        );
      }
    });

    isStorageEmpty(mList) {
      return mList == null;
    }

    on<SaveCep>(
      (event, emit) async {
        try {
          emit(CepSaving());
          final mList = await storage.getItem('ceps');
          isStorageEmpty(mList)
              ? cepModels = []
              : cepModels = await CepModel.fromJsonList(mList);
          cepModels.add(event.cepModel);
          emit(CepSaved(event.cepModel));
          await storage.ready;
          await storage.setItem('ceps', CepModel.toJsonList(cepModels));
          await storage.ready;
          await storage.setItem('savedAmount', (cepModels.length).toString());
        } on Error {
          emit(const CepError("Erro ao salvar o cep"));
        }
      },
    );

    on<GetSavedCeps>(
      (event, emit) async {
        try {
          await storage.ready;
          final mList = await storage.getItem('ceps');
          isStorageEmpty(mList)
              ? emit(const CepError("Não há ceps salvos"))
              : emit(SavedCepsLoaded(CepModel.fromJsonList(mList)));
        } on NetworkError {
          emit(
            const CepError(
                "Falha ao buscar dados. Verifique sua conexão com a internet"),
          );
        }
      },
    );
    on<RemoveSavedCep>((event, emit) async {
      try {
        emit(SavedCepsLoading());
        await storage.ready;
        final mList = await storage.getItem('ceps');
        final List<CepModel> cepModels = await CepModel.fromJsonList(mList);
        cepModels.removeWhere((cepModel) => cepModel.cep == event.cepModel.cep);
        await storage.ready;
        await storage.setItem('ceps', CepModel.toJsonList(cepModels));
        emit(SavedCepsLoaded(cepModels));
      } on Error {
        emit(const CepError("Erro ao remover o cep"));
      }
    });
  }
}
