import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/repository/ogretmenler_repository.dart';

import '../models/ogretmen.dart';
import 'ogretmen/ogretmen_form.dart';

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
                    child: Text("${ogretmenlerRepository.ogretmenler.length} Öğretmen",
                      style: TextStyle(
                        fontSize: 15,
                      ),),
                  ),
                ),
                const Align(
                  alignment:Alignment.centerRight,
                  child: OgretmenIndirmeButonu(),
                ),
              ],
            ),
          ),
          Expanded(
            child:RefreshIndicator(
              onRefresh: () async {
                ref.refresh(ogretmenListesiProvider);
              },
              child: ref.watch(ogretmenListesiProvider).when(
                  data: (data)=>ListView.separated(
                    itemBuilder: (context,index)=> OgretmenSatiri(
                      data[index],
                    ),
                    separatorBuilder: (context,index)=>const Divider(),
                    itemCount: data.length,

                  ),
                  error: (error, stackTrace) {
                    return SingleChildScrollView(
                        child: const Text("Error"),
                        physics:AlwaysScrollableScrollPhysics() ,);
                  },
                  loading:() {
                    return const Center(child: CircularProgressIndicator(),);
                  },
            )
          ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created= await Navigator.of(context).push<bool>(MaterialPageRoute(
              builder: (context){
                return const OgretmenForm();
              },));
            if(created== true){
              print ("Öğretmenleri yenile");
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class OgretmenIndirmeButonu extends StatefulWidget {
  const OgretmenIndirmeButonu({
    super.key,
  });

  @override
  State<OgretmenIndirmeButonu> createState() => _OgretmenIndirmeButonuState();
}

class _OgretmenIndirmeButonuState extends State<OgretmenIndirmeButonu> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:(context,ref,child){
        return isLoading ? const CircularProgressIndicator():IconButton(
          icon:const Icon(Icons.download),
          onPressed: (() async {
            try{
              setState(() {
                isLoading=true;
              });
              await ref.read(ogretmenlerProvider).indir();
            }catch(e){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
            finally{
              setState(() {
                isLoading=false;
              });
            }
          }),
        );
      }
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