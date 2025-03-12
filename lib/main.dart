import 'package:flutter/material.dart';
import 'screens/giris_ekrani.dart';
import 'screens/ana_ekran.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emlak Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/giris',
      routes: {
        '/giris': (context) => const GirisEkrani(),
        '/ana': (context) => const AnaEkran(),
      },
    );
  }
}
