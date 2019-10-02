class Category {
  String code;
  String title;
  String symbol;
  List<Category> children = [];

  Category({this.code, this.title, this.symbol, this.children = const []});

  String get icon {
    return "assets/symbols/$code.png";
  }
}
