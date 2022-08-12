import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc(NavigationState initialState) : super(initialState) {
    on<NavigateTo>(((event, emit) =>
        emit(NavigationState(currentNavItem: event.destination))));
  }
}

abstract class NavigationEvent {
  const NavigationEvent();
}

class NavigateTo extends NavigationEvent {
  final NavItem destination;
  const NavigateTo({required this.destination});
}

enum NavItem {
  home,
  search,
  favorites,
}

class NavigationState {
  final NavItem currentNavItem;
  const NavigationState({required this.currentNavItem});
}
