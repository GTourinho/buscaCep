import 'package:equatable/equatable.dart';
import '../../models/cep_model.dart';

abstract class CepEvent extends Equatable {
  const CepEvent();

  @override
  List<Object> get props => [];
}

class GetCep extends CepEvent {
  final String cep;
  const GetCep({required this.cep});
}

class SaveCep extends CepEvent {
  final CepModel cepModel;
  const SaveCep({required this.cepModel});
}

class GetSavedCeps extends CepEvent {
  const GetSavedCeps();
}

class GetAmounts extends CepEvent {
  const GetAmounts();
}
