import 'package:bloc/bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:myapp/bloc/cep/cep_event.dart';
import 'package:myapp/bloc/cep/cep_state.dart';
import '../../models/cep_model.dart';
import '../../resources/api_repository.dart';

class CepBloc extends Bloc<CepEvent, CepState> {
  CepBloc() : super(CepInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    final LocalStorage storage = LocalStorage('ceps');
    List<CepModel> cepModels = [];

    on<GetCep>((event, emit) async {
      try {
        emit(CepLoading());
        final mList = await apiRepository.fetchCepList(event.cep);
        emit(CepLoaded(mList));
        if (mList.error != '') {
          emit(CepError(mList.error));
        }
        if (mList.cep == '') {
          emit(const CepError(
              "Não conseguimos localizar seu endereço, verifique se as informações passadas estão corretas"));
        }
      } on NetworkError {
        emit(
          const CepError(
              "Falha ao buscar dados. Verifique sua conexão com a internet"),
        );
      }
    });

    on<SaveCep>(
      (event, emit) async {
        try {
          emit(CepSaving());
          final mList = storage.getItem('ceps');
          if (mList == null) {
            cepModels = [];
          } else {
            cepModels = cepModels = await CepModel.fromJsonList(mList);
          }
          cepModels.add(event.cepModel);
          await storage.ready;
          storage.setItem('ceps', CepModel.toJsonList(cepModels));
          emit(CepSaved(event.cepModel));
        } on Error {
          emit(const CepError("Erro ao salvar o cep"));
        }
      },
    );

    on<GetSavedCeps>(
      (event, emit) async {
        try {
          await storage.ready;
          final mList = await CepModel.fromJsonList(storage.getItem('ceps'));
          if (mList == null) {
            emit(const CepError("Não há ceps salvos"));
          } else {
            emit(SavedCepsLoaded(mList));
          }
        } on NetworkError {
          emit(
            const CepError(
                "Falha ao buscar dados. Verifique sua conexão com a internet"),
          );
        }
      },
    );
  }
}
