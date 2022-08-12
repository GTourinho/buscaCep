enum NavItem {
  home,
  search,
  favorites,
}

class NavigationState {
  final NavItem currentNavItem;
  const NavigationState({required this.currentNavItem});
}
