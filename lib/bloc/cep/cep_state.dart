import 'package:equatable/equatable.dart';
import 'package:myapp/models/cep_model.dart';

abstract class CepState extends Equatable {
  const CepState();

  @override
  List<Object?> get props => [];
}

class CepInitial extends CepState {}

class CepLoading extends CepState {}

class CepLoaded extends CepState {
  final CepModel cepModel;
  const CepLoaded(this.cepModel);
}

class SavedCepsLoaded extends CepState {
  final List<CepModel> cepModels;
  const SavedCepsLoaded(this.cepModels);
}

class CepSaved extends CepState {
  final CepModel cepModel;
  const CepSaved(this.cepModel);
}

class CepError extends CepState {
  final String? message;
  const CepError(this.message);
}
