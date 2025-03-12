import 'package:flutter/material.dart';
import '../models/kullanici.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  final _emailController = TextEditingController();
  final _sifreController = TextEditingController();
  bool _girisYapiliyor = true;

  // Örnek kullanıcılar (gerçek uygulamada bir veritabanında saklanmalı)
  final List<Kullanici> _kullanicilar = [
    Kullanici(
      id: '1',
      email: 'admin@emlak.com',
      sifre: 'admin123',
      isAdmin: true,
    ),
    Kullanici(
      id: '2',
      email: 'kullanici@emlak.com',
      sifre: 'kullanici123',
    ),
  ];

  void _girisYapveyaKayitOl() {
    final email = _emailController.text.trim();
    final sifre = _sifreController.text.trim();

    if (email.isEmpty || sifre.isEmpty) {
      _hataMesajiGoster('Lütfen tüm alanları doldurun');
      return;
    }

    if (_girisYapiliyor) {
      // Giriş işlemi
      final kullanici = _kullanicilar.firstWhere(
        (k) => k.email == email && k.sifre == sifre,
        orElse: () => Kullanici(id: '', email: '', sifre: ''),
      );

      if (kullanici.id.isEmpty) {
        _hataMesajiGoster('Email veya şifre hatalı');
        return;
      }

      Navigator.pushReplacementNamed(
        context,
        '/ana',
        arguments: kullanici,
      );
    } else {
      // Kayıt işlemi
      if (_kullanicilar.any((k) => k.email == email)) {
        _hataMesajiGoster('Bu email adresi zaten kullanılıyor');
        return;
      }

      final yeniKullanici = Kullanici(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        sifre: sifre,
      );

      setState(() {
        _kullanicilar.add(yeniKullanici);
      });

      _basariliMesajGoster('Kayıt başarılı! Giriş yapabilirsiniz.');
      setState(() {
        _girisYapiliyor = true;
      });
    }
  }

  void _hataMesajiGoster(String mesaj) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mesaj),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _basariliMesajGoster(String mesaj) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mesaj),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.home_work,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 32),
              Text(
                _girisYapiliyor
                    ? 'Emlak Uygulaması Giriş'
                    : 'Yeni Hesap Oluştur',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _sifreController,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _girisYapveyaKayitOl,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  _girisYapiliyor ? 'Giriş Yap' : 'Kayıt Ol',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    _girisYapiliyor = !_girisYapiliyor;
                  });
                },
                child: Text(
                  _girisYapiliyor
                      ? 'Hesabınız yok mu? Kayıt olun'
                      : 'Zaten hesabınız var mı? Giriş yapın',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _sifreController.dispose();
    super.dispose();
  }
}
