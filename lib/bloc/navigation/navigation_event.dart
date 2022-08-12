import 'navigation_state.dart';

abstract class NavigationEvent {
  const NavigationEvent();
}

class NavigateTo extends NavigationEvent {
  final NavItem destination;
  const NavigateTo({required this.destination});
}
