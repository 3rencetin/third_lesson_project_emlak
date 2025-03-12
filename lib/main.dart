import 'package:flutter/material.dart';
import 'screens/ana_ekran.dart';

void main() {
  runApp(const EmlakApp());
}

class EmlakApp extends StatelessWidget {
  const EmlakApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emlak Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.orange,
        ),
        useMaterial3: true,
      ),
      home: const AnaEkran(),
    );
  }
}
