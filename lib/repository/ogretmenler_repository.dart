import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ogretmen.dart';

class OgretmenlerRepository extends ChangeNotifier{
  List ogretmenler=[
    Ogretmen("Faruk","Yılmaz",30,"Erkek"),
    Ogretmen("Semiha","Çelik",35,"Kadın"),
  ];
  void download(){
    final m ={
    "ad":"Yeni",
    "soyad":"Yenioğlu",
    "yas":21,
    "cinsiyet":"Erkek",
    };
    final ogretmen=Ogretmen.fromMap(m);
    ogretmenler.add(ogretmen);
  }

}
final ogretmenlerProvider=ChangeNotifierProvider((ref){

  return OgretmenlerRepository();

});