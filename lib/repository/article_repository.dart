import 'dart:convert';
import 'package:flutternewsbloc/helper/constant.dart';
import 'package:flutternewsbloc/model/article_model.dart';
import 'package:http/http.dart' as http;

class ArticleRepository {
  Future<List<ArticleModel>> getData(String category) async {
    String _url;
    category == ""
        ? _url = "${baseUrl}apiKey=${apiKey}"
        : _url = "${baseUrl}category=$category&apiKey=$apiKey";

    var response = await http.get(_url);

    if (response.statusCode == 200) {
      return jsonParse(response.body);
    } else {
      throw Exception();
    }
  }

  List<ArticleModel> jsonParse(final response) {
    var json = jsonDecode(response);
    var data = json['articles'];

    return new List<ArticleModel>.from(
        data.map((value) => ArticleModel.fromJson(value)));
  }
}
