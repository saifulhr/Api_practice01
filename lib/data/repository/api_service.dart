import 'dart:convert';
import 'package:api_practice01/data/model/category_page.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl='https://www.themealdb.com/api/json/v1/1';


  Future<Categories> fetchCetagories() async{
    final response=await http.get(Uri.parse('$_baseUrl/categories.php'));
    if (response.statusCode==200){
      return Categories.fromJson(json.decode(response.body));
    }else {
      throw Exception('Faild to load Cetagories');
    }
  }
}