import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/pages/mesajlar_sayfasi.dart';
import 'package:ogrenci_app/pages/ogrenciler_sayfasi.dart';
import 'package:ogrenci_app/pages/ogretmenler_sayfasi.dart';
import 'package:ogrenci_app/repository/mesajlar_repository.dart';
import 'package:ogrenci_app/repository/ogrenciler_repository.dart';
import 'package:ogrenci_app/repository/ogretmenler_repository.dart';

void main() {
  runApp(const ProviderScope(child: const OgrenciApp()));
}
class OgrenciApp extends StatelessWidget {
  const OgrenciApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ogrenci Uygulaması',
      theme: ThemeData(
       primarySwatch: Colors.blue,

      ),
      home: const AnaSayfa(title: 'Ogrenci Ana Sayfa'),
    );
  }
}

class AnaSayfa extends ConsumerWidget {
  const AnaSayfa({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final ogrencilerRepository = ref.watch(ogrencilerProvider);
    final ogretmenlerRepository = ref.watch(ogretmenlerProvider);
    final mesajlarRepository = ref.watch(mesajlarProvider);
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal:32.0,
                      vertical:32),
                  child: Text("Öğrenci Adı",
                    style: TextStyle(
                    fontSize: 30,
                  ),),
                ),
                color: Colors.indigo[200],
                width: 300,
                height: 300,
              ),
              myDrawerItem(Icons.access_alarm, "Öğrenciler"),
              myDrawerItem(Icons.pending_actions, "Öğretmenler"),
              myDrawerItem(Icons.message, "Mesajlar"),


            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                  onPressed:((){
                    print("Öğrenciler sayfasına gidiyor");
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:(context) => OgrencilerSayfasi(),));
                  }),
                  child:Text("${ogrencilerRepository.ogrenciler.length} öğrenci"),),
              TextButton(
                onPressed:((){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context)=>OgretmenlerSayfasi(),));
                  print("Öğretmenler sayfasına gidiyor");
                }),
                child:Text("${ogretmenlerRepository.ogretmenler.length} öğretmen"),),
              TextButton(
                onPressed:((){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder:(context)=>MesajlarSayfasi())
                  );
                  print("Mesajlar sayfasına gidiyor");
                }),
                child:Text("${ref.watch(yeniMesajSayisiProvider)} yeni mesaj"),)
            ],
          ),
        ),
      ),
    );
  }
  void _ogrencilereGit(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return OgrencilerSayfasi();
    }));
        }
  void _ogretmenlereGit(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return OgretmenlerSayfasi();
    }));
        }
  Future<void> _mesajlaraGit(BuildContext context) async {
   await  Navigator.of(context).push(MaterialPageRoute(builder:(context){
      return MesajlarSayfasi();
    }));
}
Widget myDrawerItem(IconData icon, String title)=>ListTile(
  leading: Icon(
    icon,
    color:Colors.black ,),
  title: Text(title),
);}
