import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/repository/ogretmenler_repository.dart';

import '../models/ogretmen.dart';

class OgretmenlerSayfasi extends ConsumerWidget {
  const OgretmenlerSayfasi({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final ogretmenlerRepository=ref.watch(ogretmenlerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğretmenler"),
      ),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 50,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:20,
                        vertical: 20),
                    child: Text("${ogretmenlerRepository.ogretmenler.length}Öğretmen",
                      style: TextStyle(
                        fontSize: 15,
                      ),),
                  ),
                ),
                Align(
                  alignment:Alignment.centerRight,
                  child: IconButton(
                    icon:const Icon(Icons.download),
                    onPressed: ((){
                      ref.read(ogretmenlerProvider);
                    }),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context,index)=> OgretmenSatiri(
                ogretmenlerRepository.ogretmenler[index],
              ),
              separatorBuilder: (context,index)=>const Divider(),
              itemCount: ogretmenlerRepository.ogretmenler.length,

            ),
          ),
        ],
      ),
    );
  }
}
class OgretmenSatiri extends ConsumerWidget {
  final Ogretmen ogretmen;
  const OgretmenSatiri(this.ogretmen,{
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ListTile(
      title:Text(ogretmen.ad +" "+ogretmen.soyad ),
      leading:  Text(ogretmen.cinsiyet == "Kadın"?"👩":"🧔‍♂️"),
    );
  }
}