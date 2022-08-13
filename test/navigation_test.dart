import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/bloc/navigation/blocs.dart';

main() {
  blocTest<NavigationBloc, NavigationState>(
      'Emits [NavigationState] when NavigateTo(NavItem.home) is added',
      build: () =>
          NavigationBloc(const NavigationState(currentNavItem: NavItem.home)),
      act: (bloc) async =>
          bloc.add(const NavigateTo(destination: NavItem.home)),
      verify: (bloc) async {
        expect(bloc.state.currentNavItem, NavItem.home);
      });

  blocTest<NavigationBloc, NavigationState>(
      'Emits [NavigationState] when NavigateTo(NavItem.search) is added',
      build: () =>
          NavigationBloc(const NavigationState(currentNavItem: NavItem.home)),
      act: (bloc) async =>
          bloc.add(const NavigateTo(destination: NavItem.search)),
      verify: (bloc) async {
        expect(bloc.state.currentNavItem, NavItem.search);
      });

  blocTest<NavigationBloc, NavigationState>(
      'Emits [NavigationState] when NavigateTo(NavItem.favourites) is added',
      build: () =>
          NavigationBloc(const NavigationState(currentNavItem: NavItem.home)),
      act: (bloc) async =>
          bloc.add(const NavigateTo(destination: NavItem.favourites)),
      verify: (bloc) async {
        expect(bloc.state.currentNavItem, NavItem.favourites);
      });
}
