import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/repository/ogretmenler_repository.dart';

import '../models/ogrenci.dart';
import '../repository/ogrenciler_repository.dart';

class OgrencilerSayfasi extends ConsumerWidget {
  const OgrencilerSayfasi({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final ogrencilerRepository = ref.watch(ogrencilerProvider);
    return Scaffold(
      appBar:AppBar(
        title: const Text("Öğrenciler"),
      ),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 50,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:20,
                    vertical: 20),
                child: Text("${ogrencilerRepository.ogrenciler.length} Öğrenci",
                style: TextStyle(
                  fontSize: 15,
                ),),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context,index)=> OgrenciSatiri(
                ogrencilerRepository.ogrenciler[index],
              ),
              separatorBuilder: (context,index)=>const Divider(),
              itemCount: ogrencilerRepository.ogrenciler.length,

            ),
          ),
        ],
      ),
    );
  }
}

class OgrenciSatiri extends ConsumerWidget {
  final Ogrenci ogrenci;
  const OgrenciSatiri(this.ogrenci,{
    super.key,
  });
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    bool seviyorMuyum=ref.watch(ogrencilerProvider).seviyorMuyum(ogrenci);
    return ListTile(
      title:Text(ogrenci.ad +" "+ogrenci.soyad ),
      leading:  Text(ogrenci.cinsiyet == "Kadın"?"👩":"🧔‍♂️"),
      trailing:IconButton(
        onPressed: ((){
            ref.read(ogrencilerProvider).sev(ogrenci,!seviyorMuyum);
        }),
        icon: Icon(seviyorMuyum ?Icons.favorite:Icons.favorite_border),
      ),
    );
  }
}
