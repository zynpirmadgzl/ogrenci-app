import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/services/data_service.dart';

import '../models/ogretmen.dart';

class OgretmenlerRepository extends ChangeNotifier{
  List ogretmenler=[
    Ogretmen("Faruk","Yılmaz",30,"Erkek"),
    Ogretmen("Semiha","Çelik",35,"Kadın"),
  ];
final DataService dataService;
  OgretmenlerRepository(this.dataService);
  void indir(){
    Ogretmen ogretmen = dataService.ogretmenIndir();
    ogretmenler.add(ogretmen);
    notifyListeners();
  }

}
final ogretmenlerProvider=ChangeNotifierProvider((ref){

  return OgretmenlerRepository(ref.watch(dataServiceProvider));

});