import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc(NavigationState initialState) : super(initialState) {
    on<NavigateTo>(((event, emit) =>
        emit(NavigationState(currentNavItem: event.destination))));
  }
}
