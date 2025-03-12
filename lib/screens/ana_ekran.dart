import 'package:flutter/material.dart';
import '../models/emlak.dart';
import '../models/kullanici.dart';
import 'emlak_detay.dart';
import 'emlak_ekle.dart';

String formatPrice(double price) {
  return price.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      );
}

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  List<Emlak> emlaklar = [];
  String secilenTip = 'Hepsi';
  String secilenDurum = 'Hepsi';
  RangeValues fiyatAraligi = const RangeValues(0, 100000000);
  RangeValues binaYasiAraligi = const RangeValues(0, 50);
  late Kullanici aktifKullanici;

  @override
  void initState() {
    super.initState();
    // Giriş yapan kullanıcıyı al
    WidgetsBinding.instance.addPostFrameCallback((_) {
      aktifKullanici = ModalRoute.of(context)!.settings.arguments as Kullanici;
      _ornekVerileriYukle();
    });
  }

  void _ornekVerileriYukle() {
    // Örnek emlak verileri
    emlaklar = [
      Emlak(
        id: '1',
        kullaniciId: '1', // Admin'in ID'si
        baslik: 'Lüks Villa',
        aciklama: 'Beşiktaşta deniz manzaralı lüks villa',
        fiyat: 45000000, // 45 milyon
        resimUrl:
            'https://images.unsplash.com/photo-1613977257363-707ba9348227',
        konum: 'Beşiktaş, İstanbul',
        odaSayisi: 5,
        banyoSayisi: 3,
        metreKare: 300,
        tip: 'Villa',
        satilikMi: true,
        binaYasi: 2,
      ),
      Emlak(
        id: '2',
        kullaniciId: '1', // Admin'in ID'si
        baslik: 'Modern Daire',
        aciklama: 'Kadıköyde merkezi konumda modern daire',
        fiyat: 12500000, // 12.5 milyon
        resimUrl:
            'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
        konum: 'Kadıköy, İstanbul',
        odaSayisi: 3,
        banyoSayisi: 1,
        metreKare: 120,
        tip: 'Daire',
        satilikMi: true,
        binaYasi: 5,
      ),
      Emlak(
        id: '3',
        kullaniciId: '1', // Admin'in ID'si
        baslik: 'Bahçeli Müstakil',
        aciklama: 'Üsküdarda geniş bahçeli müstakil ev',
        fiyat: 18500000, // 18.5 milyon
        resimUrl:
            'https://images.unsplash.com/photo-1568605114967-8130f3a36994',
        konum: 'Üsküdar, İstanbul',
        odaSayisi: 4,
        banyoSayisi: 2,
        metreKare: 200,
        tip: 'Müstakil',
        satilikMi: true,
        binaYasi: 15,
      ),
      Emlak(
        id: '4',
        kullaniciId: '1', // Admin'in ID'si
        baslik: 'Boğaz Manzaralı Daire',
        aciklama: 'Sarıyerde boğaz manzaralı lüks daire',
        fiyat: 28500000, // 28.5 milyon
        resimUrl:
            'https://images.unsplash.com/photo-1574362848149-11496d93a7c7',
        konum: 'Sarıyer, İstanbul',
        odaSayisi: 3,
        banyoSayisi: 2,
        metreKare: 150,
        tip: 'Daire',
        satilikMi: true,
        binaYasi: 1,
      ),
      Emlak(
        id: '5',
        kullaniciId: '1', // Admin'in ID'si
        baslik: 'Kiralık Stüdyo',
        aciklama: 'Şişlide merkezi konumda kiralık stüdyo daire',
        fiyat: 25000, // 25 bin kira
        resimUrl:
            'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688',
        konum: 'Şişli, İstanbul',
        odaSayisi: 1,
        banyoSayisi: 1,
        metreKare: 45,
        tip: 'Daire',
        satilikMi: false,
        binaYasi: 3,
      ),
      Emlak(
        id: '6',
        kullaniciId: '1', // Admin'in ID'si
        baslik: 'Havuzlu Villa',
        aciklama: 'Beylikdüzünde özel havuzlu lüks villa',
        fiyat: 35000000, // 35 milyon
        resimUrl:
            'https://images.unsplash.com/photo-1580587771525-78b9dba3b914',
        konum: 'Beylikdüzü, İstanbul',
        odaSayisi: 6,
        banyoSayisi: 4,
        metreKare: 400,
        tip: 'Villa',
        satilikMi: true,
        binaYasi: 0,
      ),
      Emlak(
        id: '7',
        kullaniciId: '1', // Admin'in ID'si
        baslik: 'Kiralık Villa',
        aciklama: 'Ataşehirde bahçeli kiralık villa',
        fiyat: 85000, // 85 bin kira
        resimUrl:
            'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9',
        konum: 'Ataşehir, İstanbul',
        odaSayisi: 5,
        banyoSayisi: 3,
        metreKare: 350,
        tip: 'Villa',
        satilikMi: false,
        binaYasi: 8,
      ),
      Emlak(
        id: '8',
        kullaniciId: '1', // Admin'in ID'si
        baslik: 'Deniz Manzaralı',
        aciklama: 'Maltepe sahilde deniz manzaralı daire',
        fiyat: 15800000, // 15.8 milyon
        resimUrl:
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
        konum: 'Maltepe, İstanbul',
        odaSayisi: 3,
        banyoSayisi: 2,
        metreKare: 140,
        tip: 'Daire',
        satilikMi: true,
        binaYasi: 12,
      ),
      Emlak(
        id: '9',
        kullaniciId: '1', // Admin'in ID'si
        baslik: 'Bahçeli Müstakil',
        aciklama: 'Çekmeköyde doğayla iç içe müstakil ev',
        fiyat: 22500000, // 22.5 milyon
        resimUrl:
            'https://images.unsplash.com/photo-1583608205776-bfd35f0d9f83',
        konum: 'Çekmeköy, İstanbul',
        odaSayisi: 4,
        banyoSayisi: 2,
        metreKare: 180,
        tip: 'Müstakil',
        satilikMi: true,
        binaYasi: 20,
      ),
      Emlak(
        id: '10',
        kullaniciId: '1', // Admin'in ID'si
        baslik: 'Kiralık Daire',
        aciklama: 'Bakırköy merkeze yakın kiralık daire',
        fiyat: 35000, // 35 bin kira
        resimUrl:
            'https://images.unsplash.com/photo-1493809842364-78817add7ffb',
        konum: 'Bakırköy, İstanbul',
        odaSayisi: 2,
        banyoSayisi: 1,
        metreKare: 90,
        tip: 'Daire',
        satilikMi: false,
        binaYasi: 25,
      ),
    ];
    setState(() {});
  }

  List<Emlak> get filtrelenmisEmlaklar {
    return emlaklar.where((emlak) {
      final tipUygun = secilenTip == 'Hepsi' || emlak.tip == secilenTip;
      final durumUygun = secilenDurum == 'Hepsi' ||
          (secilenDurum == 'Satılık' && emlak.satilikMi) ||
          (secilenDurum == 'Kiralık' && !emlak.satilikMi);
      final fiyatUygun =
          emlak.fiyat >= fiyatAraligi.start && emlak.fiyat <= fiyatAraligi.end;
      final binaYasiUygun = emlak.binaYasi >= binaYasiAraligi.start &&
          emlak.binaYasi <= binaYasiAraligi.end;
      return tipUygun && durumUygun && fiyatUygun && binaYasiUygun;
    }).toList();
  }

  bool _kullaniciDuzenleyebilirMi(Emlak emlak) {
    return aktifKullanici.isAdmin || emlak.kullaniciId == aktifKullanici.id;
  }

  void emlakSil(String id) {
    final emlak = emlaklar.firstWhere((e) => e.id == id);
    if (_kullaniciDuzenleyebilirMi(emlak)) {
      setState(() {
        emlaklar.removeWhere((emlak) => emlak.id == id);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bu ilanı silme yetkiniz yok'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modern Emlak Uygulaması'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final yeniEmlak = await Navigator.push<Emlak>(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EmlakEkle(kullaniciId: aktifKullanici.id),
                ),
              );
              if (yeniEmlak != null) {
                setState(() {
                  emlaklar.add(yeniEmlak);
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/giris');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: secilenTip,
                        isExpanded: true,
                        items: ['Hepsi', 'Daire', 'Villa', 'Müstakil']
                            .map((tip) => DropdownMenuItem(
                                  value: tip,
                                  child: Text(tip),
                                ))
                            .toList(),
                        onChanged: (yeniTip) {
                          if (yeniTip != null) {
                            setState(() {
                              secilenTip = yeniTip;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButton<String>(
                        value: secilenDurum,
                        isExpanded: true,
                        items: ['Hepsi', 'Satılık', 'Kiralık']
                            .map((durum) => DropdownMenuItem(
                                  value: durum,
                                  child: Text(durum),
                                ))
                            .toList(),
                        onChanged: (yeniDurum) {
                          if (yeniDurum != null) {
                            setState(() {
                              secilenDurum = yeniDurum;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fiyat Aralığı: ${formatPrice(fiyatAraligi.start)} TL - ${formatPrice(fiyatAraligi.end)} TL',
                      style: const TextStyle(fontSize: 16),
                    ),
                    RangeSlider(
                      values: fiyatAraligi,
                      min: 0,
                      max: 100000000, // 100 milyon
                      divisions: 100,
                      onChanged: (RangeValues values) {
                        setState(() {
                          fiyatAraligi = values;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bina Yaşı: ${binaYasiAraligi.start.toInt()} - ${binaYasiAraligi.end.toInt()} yıl',
                      style: const TextStyle(fontSize: 16),
                    ),
                    RangeSlider(
                      values: binaYasiAraligi,
                      min: 0,
                      max: 50,
                      divisions: 50,
                      onChanged: (RangeValues values) {
                        setState(() {
                          binaYasiAraligi = values;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: filtrelenmisEmlaklar.isEmpty
                ? const Center(
                    child: Text(
                      'Filtrelere uygun emlak bulunamadı',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: filtrelenmisEmlaklar.length,
                    itemBuilder: (context, index) {
                      final emlak = filtrelenmisEmlaklar[index];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () async {
                            final sadecaGoruntuleme =
                                !_kullaniciDuzenleyebilirMi(emlak);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmlakDetay(
                                  emlak: emlak,
                                  emlakSil: () => emlakSil(emlak.id),
                                  sadecaGoruntuleme: sadecaGoruntuleme,
                                ),
                              ),
                            ).then((guncelEmlak) {
                              if (guncelEmlak != null) {
                                setState(() {
                                  final index = emlaklar.indexWhere(
                                      (e) => e.id == guncelEmlak.id);
                                  if (index != -1) {
                                    emlaklar[index] = guncelEmlak;
                                  }
                                });
                              }
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Image.network(
                                  emlak.resimUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.error_outline,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        emlak.baslik,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        emlak.konum,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${formatPrice(emlak.fiyat)} TL',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            emlak.satilikMi
                                                ? Icons.sell
                                                : Icons.key,
                                            size: 16,
                                            color: Colors.grey[600],
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            emlak.satilikMi
                                                ? 'Satılık'
                                                : 'Kiralık',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
