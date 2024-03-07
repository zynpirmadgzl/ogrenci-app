import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ogretmen.dart';

class DataService{
Ogretmen ogretmenIndir(){
  final j ="""{
  
    "ad":"Yeni",
    "soyad":"Yenioğlu",
    "yas":21,
    "cinsiyet":"Erkek",
  }""";
  final m=jsonDecode(j);
  final ogretmen=Ogretmen.fromMap(m);
  return ogretmen;
}
}
final dataServiceProvider=Provider((ref){
  return DataService();
});