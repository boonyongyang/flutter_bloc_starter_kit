enum AppRoutes {
  login('/login'),
  fruits('/fruits'),
  fruitDetail('fruit-detail');

  const AppRoutes(this.path);
  final String path;
}
