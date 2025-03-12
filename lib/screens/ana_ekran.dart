import 'package:flutter/material.dart';
import '../models/emlak.dart';
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
  RangeValues fiyatAraligi = const RangeValues(0, 10000000);
  RangeValues binaYasiAraligi = const RangeValues(0, 50);

  @override
  void initState() {
    super.initState();
    // Örnek emlak verileri
    emlaklar = [
      Emlak(
        id: '1',
        baslik: 'Lüks Villa',
        aciklama: 'Beşiktaşta deniz manzaralı lüks villa',
        fiyat: 5000000,
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
        baslik: 'Modern Daire',
        aciklama: 'Kadıköyde merkezi konumda modern daire',
        fiyat: 2500000,
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
        baslik: 'Bahçeli Müstakil',
        aciklama: 'Üsküdarda geniş bahçeli müstakil ev',
        fiyat: 3500000,
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
        baslik: 'Boğaz Manzaralı Daire',
        aciklama: 'Sarıyerde boğaz manzaralı lüks daire',
        fiyat: 4500000,
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
        baslik: 'Kiralık Stüdyo',
        aciklama: 'Şişlide merkezi konumda kiralık stüdyo daire',
        fiyat: 8000,
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
        baslik: 'Havuzlu Villa',
        aciklama: 'Beylikdüzünde özel havuzlu lüks villa',
        fiyat: 7500000,
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
        baslik: 'Kiralık Villa',
        aciklama: 'Ataşehirde bahçeli kiralık villa',
        fiyat: 25000,
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
        baslik: 'Deniz Manzaralı',
        aciklama: 'Maltepe sahilde deniz manzaralı daire',
        fiyat: 3200000,
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
        baslik: 'Bahçeli Müstakil',
        aciklama: 'Çekmeköyde doğayla iç içe müstakil ev',
        fiyat: 2800000,
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
        baslik: 'Kiralık Daire',
        aciklama: 'Bakırköy merkeze yakın kiralık daire',
        fiyat: 12000,
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

  void emlakSil(String id) {
    setState(() {
      emlaklar.removeWhere((emlak) => emlak.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emlak Uygulaması'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final yeniEmlak = await Navigator.push<Emlak>(
                context,
                MaterialPageRoute(builder: (context) => const EmlakEkle()),
              );
              if (yeniEmlak != null) {
                setState(() {
                  emlaklar.add(yeniEmlak);
                });
              }
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
                    const SizedBox(width: 8),
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Fiyat Aralığı:'),
                RangeSlider(
                  values: fiyatAraligi,
                  min: 0,
                  max: 10000000,
                  divisions: 100,
                  labels: RangeLabels(
                    '₺ ${formatPrice(fiyatAraligi.start)} TL',
                    '₺ ${formatPrice(fiyatAraligi.end)} TL',
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      fiyatAraligi = values;
                    });
                  },
                ),
                const Text('Bina Yaşı:'),
                RangeSlider(
                  values: binaYasiAraligi,
                  min: 0,
                  max: 50,
                  divisions: 50,
                  labels: RangeLabels(
                    '${binaYasiAraligi.start.toStringAsFixed(0)} yıl',
                    '${binaYasiAraligi.end.toStringAsFixed(0)} yıl',
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      binaYasiAraligi = values;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
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
                      final guncelEmlak = await Navigator.push<Emlak>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmlakDetay(
                            emlak: emlak,
                            emlakSil: () {
                              setState(() {
                                emlaklar.removeWhere((e) => e.id == emlak.id);
                              });
                            },
                          ),
                        ),
                      );
                      if (guncelEmlak != null) {
                        setState(() {
                          final index = emlaklar
                              .indexWhere((e) => e.id == guncelEmlak.id);
                          if (index != -1) {
                            emlaklar[index] = guncelEmlak;
                          }
                        });
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: 'emlak_resim_${emlak.id}',
                          child: AspectRatio(
                            aspectRatio: 4 / 3,
                            child: Image.network(
                              emlak.resimUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  emlak.baslik,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₺ ${formatPrice(emlak.fiyat)} TL',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  emlak.konum,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.home, size: 12),
                                    const SizedBox(width: 2),
                                    Expanded(
                                      child: Text(
                                        emlak.tip,
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    ),
                                    const Icon(Icons.calendar_today, size: 12),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${emlak.binaYasi} yaş',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.bed, size: 12),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${emlak.odaSayisi} oda',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.bathroom, size: 12),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${emlak.banyoSayisi} banyo',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.square_foot, size: 12),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${emlak.metreKare} m²',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: emlak.satilikMi
                                            ? Colors.blue
                                            : Colors.orange,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        emlak.satilikMi ? 'Satılık' : 'Kiralık',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
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
