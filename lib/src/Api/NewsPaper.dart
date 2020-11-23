import 'package:NewsPapersCo/src/models/Categoria.dart';
import 'package:NewsPapersCo/src/models/NewsResponse.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

final _URL_API = 'https://newsapi.org/v2';
final _APIKEY = 'c34d1af862f7450f838bf701798c1df8';

class NewsPaperApi with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  bool _isLoading = true;

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'Negocios', 'business'),
    Category(FontAwesomeIcons.tv, 'Entretenimiento', 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'General', 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'Salud', 'health'),
    Category(FontAwesomeIcons.vials, 'Ciencia', 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'Deportes', 'sports'),
    Category(FontAwesomeIcons.memory, 'Tecnología', 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsPaperApi() {
    this.getTopHeadlines();

    categories.forEach((item) {
      this.categoryArticles[item.name] = new List();
    });

    this.getArticlesByCategory(this._selectedCategory);
  }

  bool get isLoading => this._isLoading;

  get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor) {
    this._selectedCategory = valor;

    this._isLoading = true;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada =>
      this.categoryArticles[this.selectedCategory];

  getTopHeadlines() async {
    final url = '$_URL_API/top-headlines?apiKey=$_APIKEY&country=co';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category].length > 0) {
      this._isLoading = false;
      notifyListeners();
      return this.categoryArticles[category];
    }

    final url =
        '$_URL_API/top-headlines?apiKey=$_APIKEY&country=co&category=$category';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticles[category].addAll(newsResponse.articles);

    this._isLoading = false;
    notifyListeners();
  }
}
