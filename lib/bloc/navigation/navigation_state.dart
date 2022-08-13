enum NavItem {
  home,
  search,
  favourites,
}

class NavigationState {
  final NavItem currentNavItem;
  const NavigationState({required this.currentNavItem});
}
