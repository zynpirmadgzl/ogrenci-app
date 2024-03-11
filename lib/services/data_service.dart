import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ogretmen.dart';
import 'package:http/http.dart' as http;

class DataService{
  final String baseUrl="https://65e96f14c9bf92ae3d39221f.mockapi.io/";
Future<Ogretmen> ogretmenIndir() async {
  final response=await http.get(Uri.parse("$baseUrl /ogretmen/1"));
  if (response.statusCode == 200) {
    return Ogretmen.fromMap(jsonDecode(response.body) );
  } else {
    throw Exception('Öğretmen indirilemedi ${response.statusCode}');
  }
}
Future<void> ogretmenEkle(Ogretmen ogretmen) async {
  final response=await http.post(
    Uri.parse("$baseUrl /ogretmen"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(ogretmen.toMap()),
  );
  if (response.statusCode == 201) {
    return;
  } else {
    throw Exception('Öğretmen eklenemedi ${response.statusCode}');
  }

}

  Future<List<Ogretmen>> ogretmenleriGetir() async {
    final response=await http.get(Uri.parse("$baseUrl /ogretmen/1"));
    if (response.statusCode == 200) {
      final l=jsonDecode(response.body);
      return l.map<Ogretmen>((e)=>Ogretmen.fromMap(e)).toList();
    } else {
      throw Exception('Öğretmenler getirilemedi ${response.statusCode}');
    }
  }
}
final dataServiceProvider=Provider((ref){
  return DataService();
});